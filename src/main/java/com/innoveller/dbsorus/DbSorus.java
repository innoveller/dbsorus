package com.innoveller.dbsorus;

import com.fasterxml.jackson.databind.JsonNode;
import com.innoveller.dbsorus.directives.DirectiveProcessor;
import com.innoveller.dbsorus.models.*;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.*;
import java.util.stream.Collectors;

import com.innoveller.dbsorus.seedparser.md.MdJsonParser;
import com.innoveller.dbsorus.seedparser.md.MdTableParser;
import com.innoveller.dbsorus.utils.IOUtils;

public class DbSorus {

    private final DirectiveProcessor directiveProcessor;

    private DbSorus(DirectiveProcessor directiveProcessor) {
        this.directiveProcessor = directiveProcessor;
    }

    public UUID retrieveGeneratedUUID(String key) {
        return this.directiveProcessor.getColumnLevelDirectiveProcessor().retrieveGeneratedUUID(key)
                .orElseThrow(() -> new RuntimeException("Cannot retrieve the generated UUID by key: " + key));
    }

    public Integer getorGenerateInteger(String key) {
        return this.directiveProcessor.getColumnLevelDirectiveProcessor().retrieveGeneratedInteger(key)
                .orElseThrow(() -> new RuntimeException("Cannot retrieve the generated Integer by key: " + key));
    }

    public static Configurator configure(ClassLoader classLoader) {
        return new Configurator(classLoader);
    }

    public static class Configurator {
        private final ClassLoader classLoader;
        private final List<String> seedPaths;

        private String databaseUrl;
        private String username;
        private String password;

        public Configurator(ClassLoader classLoader) {
            this.classLoader = classLoader;
            this.seedPaths = new ArrayList<>();
        }

        public Configurator dataSource(String databaseUrl, String username, String password) {
            this.databaseUrl = databaseUrl;
            this.username = username;
            this.password = password;
            return this;
        }

        public Configurator seedPath(String path) {
            this.seedPaths.add(path);
            return this;
        }

        public Configurator seedPaths(String... paths) {
            Collections.addAll(this.seedPaths, paths);
            return this;
        }

        public DbSorus load() throws Exception {
            MdTableParser mdTableParser = new MdTableParser();
            MdJsonParser mdJsonParser = new MdJsonParser();

            DirectiveProcessor directiveProcessor = new DirectiveProcessor();

            List<SeedTable> processedSeedTables = new ArrayList<>();
            for(String seedPath : seedPaths) {
                try(InputStream in = classLoader.getResourceAsStream(seedPath)) {
                    List<String> lines = IOUtils.readLines(in, StandardCharsets.UTF_8);

                    System.out.println("Parsing tables from seedPath: " + seedPath);
                    List<SeedTable> rawSeedTables = mdTableParser.parseTables(lines);

                    System.out.println("Parsing json documents from seedPath: " + seedPath);
                    List<SeedJsonDocument> rawSeedJsonDocuments = mdJsonParser.parseJsonObjects(lines);
                    System.out.println("Found json documents: " + rawSeedJsonDocuments.size());

                    List<SeedObject> rawSeedObjects = new ArrayList<>();
                    rawSeedObjects.addAll(rawSeedTables);
                    rawSeedObjects.addAll(rawSeedJsonDocuments);
                    List<SeedObject> orderedRawSeedObjects = rawSeedObjects.stream()
                            .sorted(Comparator.comparing(SeedObject::getPrecedence)).collect(Collectors.toList());

                    for(SeedObject rawSeedObject : orderedRawSeedObjects) {
                        System.out.println("Processing seed object: " + rawSeedObject.getName());

                        if(rawSeedObject instanceof SeedTable) {

                            SeedTable rawSeedTable = (SeedTable) rawSeedObject;
                            SeedTable processSeedTable = directiveProcessor.processDirectives(rawSeedTable);
                            processedSeedTables.add(processSeedTable);
                        } else if(rawSeedObject instanceof SeedJsonDocument) {
                            SeedJsonDocument rawSeedJsonDoc = (SeedJsonDocument) rawSeedObject;
                            JsonNode jsonNode = directiveProcessor.processDirectives(rawSeedJsonDoc);
                            directiveProcessor.getColumnLevelDirectiveProcessor().addJsonNode(rawSeedJsonDoc.getName(), jsonNode);
                        }
                    }
                }
            }
            System.out.println("Number of processed tables: " + processedSeedTables.size());

            Properties props = new Properties();
            props.setProperty("user", this.username);
            props.setProperty("password", this.password);
            props.setProperty("ssl", "false");

            try(Connection conn = DriverManager.getConnection(this.databaseUrl, props)) {
                List<String> listOfSqlToExecute = new ArrayList<>();

                for(SeedTable givenTable: processedSeedTables) {
                    System.out.println("Working on table: " + givenTable.getName());
                    PgTableMetadata tableMetadata = PgTableInspector.inspectTable(conn, givenTable.getName());
                    for(SeedTableRow row : givenTable.getRows()) {
                        String sql = PgTableSQLComposer.composeInsertStatement(
                                tableMetadata, row.getMap());
                        listOfSqlToExecute.add(sql);
                    }
                }
                System.out.println("Executing " + listOfSqlToExecute.size() + " insert statements ...");

                for(String sql : listOfSqlToExecute) {
                    System.out.println("\nExecuting Insert:\n" + sql);
                    Statement stmt = conn.createStatement();
                    stmt.executeUpdate(sql);
                }
            }

            return new DbSorus(directiveProcessor);
        }
    }
}

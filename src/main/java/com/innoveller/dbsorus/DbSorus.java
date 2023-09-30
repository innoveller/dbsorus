package com.innoveller.dbsorus;

import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.PgTableMetadata;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import com.innoveller.dbsorus.models.SeedTableRow;
import com.innoveller.dbsorus.seedparser.md.MdSeedParser;

public class DbSorus {

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

        public void load() throws Exception {
            MdSeedParser mdTableParser = new MdSeedParser();
            DirectiveProcessor directiveProcessor = new DirectiveProcessor();

            List<SeedTable> processedSeedTables = new ArrayList<>();
            for(String seedPath : seedPaths) {
                try(InputStream in = classLoader.getResourceAsStream(seedPath)) {
                    System.out.println("Parsing tables from seedPath: " + seedPath);
                    List<SeedTable> rawSeedTables = mdTableParser.parseTables(in);
                    for(SeedTable rawSeedTable : rawSeedTables) {
                        SeedTable processSeedTable = directiveProcessor.processDirectives(rawSeedTable);
                        processedSeedTables.add(processSeedTable);
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
        }
    }
}

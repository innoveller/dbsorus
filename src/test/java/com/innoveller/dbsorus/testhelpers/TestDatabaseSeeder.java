package com.innoveller.dbsorus.testhelpers;

import org.flywaydb.core.Flyway;
import org.testcontainers.containers.JdbcDatabaseContainer;
import org.testcontainers.ext.ScriptUtils;
import org.testcontainers.jdbc.JdbcDatabaseDelegate;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class TestDatabaseSeeder {
    public static final String DEFAULT_FLYWAY_MIGRATION_DIR_PATH = "db/migration/default";

    private final JdbcDatabaseContainer<?> jdbcDatabaseContainer;
    private final String flywayMigrationScriptFolderPath;
    private final String preMigrationScriptPath;
    private final List<String> seedScriptPaths;

    private TestDatabaseSeeder(JdbcDatabaseContainer<?> jdbcDatabaseContainer, String flywayMigrationScriptFolderPath, String preMigrationScriptPath, List<String> seedScriptPaths) {
        this.jdbcDatabaseContainer = jdbcDatabaseContainer;
        this.flywayMigrationScriptFolderPath = flywayMigrationScriptFolderPath;
        this.preMigrationScriptPath = preMigrationScriptPath;
        this.seedScriptPaths = seedScriptPaths;
    }

    /*public void run() throws IOException {
        if(preMigrationScriptPath != null) {
            if(Thread.currentThread().getContextClassLoader().getResource(preMigrationScriptPath) != null) {
                System.out.println("Executing pre-migration script: " + preMigrationScriptPath);
                ScriptUtils.runInitScript(new JdbcDatabaseDelegate(jdbcDatabaseContainer, ""), preMigrationScriptPath);
            } else {
                throw new IOException("Cannot find pre-migration script: " + preMigrationScriptPath);
            }
        }

        List<String> sortedScriptFilePaths = Utils.getSortedScriptFilePaths(this.flywayMigrationScriptFolderPath);
        for(String scriptPath : sortedScriptFilePaths) {
            System.out.println("Executing flyway-migration script: " + scriptPath);
            ScriptUtils.runInitScript(new JdbcDatabaseDelegate(jdbcDatabaseContainer, ""), scriptPath);
        }

        if(seedScriptPaths != null) {
            for(String seedScriptPath : seedScriptPaths) {
                System.out.println("Executing seed script: " + seedScriptPath);
                ScriptUtils.runInitScript(new JdbcDatabaseDelegate(jdbcDatabaseContainer, ""), seedScriptPath);
            }
        }
    }*/

    public void run() throws IOException {
        if(preMigrationScriptPath != null) {
            if(Thread.currentThread().getContextClassLoader().getResource(preMigrationScriptPath) != null) {
                System.out.println("Executing pre-migration script: " + preMigrationScriptPath);
                ScriptUtils.runInitScript(new JdbcDatabaseDelegate(jdbcDatabaseContainer, ""), preMigrationScriptPath);
            } else {
                throw new IOException("Cannot find pre-migration script: " + preMigrationScriptPath);
            }
        }

        Flyway flyway = Flyway.configure()
                .dataSource(jdbcDatabaseContainer.getJdbcUrl(), jdbcDatabaseContainer.getUsername(),
                        jdbcDatabaseContainer.getPassword())
                .locations(flywayMigrationScriptFolderPath)
                .load();

        flyway.migrate();

        if(seedScriptPaths != null) {
            for(String seedScriptPath : seedScriptPaths) {
                System.out.println("Executing seed script: " + seedScriptPath);
                ScriptUtils.runInitScript(new JdbcDatabaseDelegate(jdbcDatabaseContainer, ""), seedScriptPath);
            }
        }
    }

    public static Builder withContainer(JdbcDatabaseContainer<?> jdbcDatabaseContainer) {
        return new Builder(jdbcDatabaseContainer);
    }

    public static class Builder {
        private JdbcDatabaseContainer<?> jdbcDatabaseContainer;
        private String flywayMigrationScriptFolderPath;
        private String preMigrationScriptPath;
        private final List<String> seedScriptPaths = new ArrayList<>();

        public Builder(JdbcDatabaseContainer<?> jdbcDatabaseContainer) {
            this.jdbcDatabaseContainer = jdbcDatabaseContainer;
        }

        public Builder withFlywayMigration(String flywayMigrationScriptFolderPath) {
            this.flywayMigrationScriptFolderPath = flywayMigrationScriptFolderPath;
            return this;
        }

        public Builder withFlywayMigration(String flywayMigrationScriptFolderPath, String preMigrationScriptPath) {
            this.flywayMigrationScriptFolderPath = flywayMigrationScriptFolderPath;
            this.preMigrationScriptPath = preMigrationScriptPath;
            return this;
        }

        public Builder withSeedScript(String seedScript) {
            this.seedScriptPaths.add(seedScript);
            return this;
        }

        public void run() throws IOException {
            TestDatabaseSeeder seeder = new TestDatabaseSeeder(this.jdbcDatabaseContainer, this.flywayMigrationScriptFolderPath, this.preMigrationScriptPath, this.seedScriptPaths);
            seeder.run();
        }
    }

    public static class Utils {
        public static List<String> getSortedScriptFilePaths(String folderPath) throws IOException {
            return getResourceFileNames(folderPath)
                    .stream()
                    .filter(fileName -> fileName.startsWith("V") && fileName.contains("__") && fileName.endsWith(".sql"))
                    .sorted((o1, o2) -> {
                        int v1 = Integer.parseInt(o1.substring(1).split("__")[0]);
                        int v2 = Integer.parseInt(o2.substring(1).split("__")[0]);
                        return v1 - v2;
                    })
                    .map(fileName -> folderPath + "/" + fileName)
                    .collect(Collectors.toList());
        }

        public static List<String> getResourceFileNames(String folderPath) throws IOException {
            List<String> fileNames = new ArrayList<>();
            try (InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream(folderPath);
                 BufferedReader br = new BufferedReader(new InputStreamReader(in))) {

                String resource;
                while ((resource = br.readLine()) != null) {
                    fileNames.add(resource);
                }
            }
            return fileNames;
        }
    }
}
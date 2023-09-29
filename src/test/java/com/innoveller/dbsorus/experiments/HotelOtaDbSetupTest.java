package com.innoveller.dbsorus.experiments;

import com.innoveller.dbsorus.DbSorus;
import org.flywaydb.core.Flyway;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.testcontainers.containers.PostgreSQLContainer;
import java.io.IOException;

public class HotelOtaDbSetupTest {
    private static final String DATABASE_NAME = "test_db";
    private static final String DATABASE_USERNAME = "test_user";
    private static final String DATABASE_PASSWORD = "test";

    public static PostgreSQLContainer<?> container = new PostgreSQLContainer<>("postgres:14.5")
            .withDatabaseName(DATABASE_NAME)
            .withUsername(DATABASE_USERNAME)
            .withPassword(DATABASE_PASSWORD)
            .withInitScript("databases/hotel-booking-ota/backup-schema-only.sql")
            .withExposedPorts(5432);

    @BeforeClass
    public static void before() throws Exception {
        container.start();

        String host = container.getHost();
        System.out.println("Container is starting...");
        int port = container.getFirstMappedPort();
        System.out.println("Container is now running at: " + container.getJdbcUrl());
        //System.out.println("Using mapped port: " + port);
        //System.out.println("Container JDBC url: " + container.getJdbcUrl());

        DbSorus.configure(Thread.currentThread().getContextClassLoader())
                .dataSource(container.getJdbcUrl(), container.getUsername(), container.getPassword())
                .seedPath("databases/hotel-booking-ota/sample.md")
                .load();
    }

    @Test
    public void shouldReturnMigrationFiles() throws IOException {


        /*List<String> sortedScriptFilePaths = DbSeeder.Utils.getSortedScriptFilePaths("db/migration/default");
        System.out.println("files " + sortedScriptFilePaths);

        Assert.assertEquals(85, sortedScriptFilePaths.size());
        System.out.println("sortedScriptFilePaths : " + sortedScriptFilePaths);

        List<String> resourceFileNames = DbSeeder.Utils.getResourceFileNames("db/migration/default");

        Assert.assertEquals(85, resourceFileNames.size());
        System.out.println("resourceFileNamese : " + resourceFileNames);*/
    }

    @AfterClass
    public static void after() {
        System.out.println("Container is now stopping...");
        container.stop();
        System.out.println("Container stopped.");
    }
}

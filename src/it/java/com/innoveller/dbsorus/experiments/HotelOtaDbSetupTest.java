package com.innoveller.dbsorus.experiments;

import com.innoveller.dbsorus.DbSorus;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.testcontainers.containers.PostgreSQLContainer;
import java.io.IOException;
import java.util.UUID;

import static org.junit.Assert.assertNotNull;

public class HotelOtaDbSetupTest {
    private static final String DATABASE_NAME = "test_db";
    private static final String DATABASE_USERNAME = "test_user";
    private static final String DATABASE_PASSWORD = "test";

    public static PostgreSQLContainer<?> container = new PostgreSQLContainer<>("postgres:14.5")
            .withDatabaseName(DATABASE_NAME)
            .withUsername(DATABASE_USERNAME)
            .withPassword(DATABASE_PASSWORD)
            .withInitScript("hotel-booking-ota/schema.sql")
            .withExposedPorts(5432);

    public static DbSorus dbSorus;

    @BeforeClass
    public static void before() throws Exception {
        System.out.println("Container is starting...");
        container.start();
        System.out.println("Container is now running at: " + container.getJdbcUrl());
        //System.out.println("Using mapped port: " + port);
        //System.out.println("Container JDBC url: " + container.getJdbcUrl());

        dbSorus = DbSorus.configure(Thread.currentThread().getContextClassLoader())
                .dataSource(container.getJdbcUrl(), container.getUsername(), container.getPassword())
                .seedPath("hotel-booking-ota/example.md")
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

        //UUID uuid = dbSorus.getOrGenerateUUID("x");
        //assertNotNull(uuid);

        Integer id = dbSorus.getorGenerateInteger("novotel-std");
        System.out.println("Room type id : " + id);
    }

    @AfterClass
    public static void after() {
        System.out.println("Container is now stopping...");
        container.stop();
        System.out.println("Container stopped.");
    }
}

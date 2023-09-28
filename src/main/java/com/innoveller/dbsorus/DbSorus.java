package com.innoveller.dbsorus;


import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.PgTableMetadata;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.List;
import java.util.Properties;

import com.innoveller.dbsorus.models.SeedTableRow;
import com.innoveller.dbsorus.seedparser.md.MdSeedParser;

public class DbSorus {

    public static void seed(DbConnectionInfo dbConnectionInfo, InputStream seedSourceInputStream) throws Exception {
        MdSeedParser mdTableParser = new MdSeedParser();

        List<SeedTable> givenTables = mdTableParser.parseTables(seedSourceInputStream);

        Properties props = new Properties();
        props.setProperty("user", dbConnectionInfo.getUsername());
        props.setProperty("password", dbConnectionInfo.getPassword());
        props.setProperty("ssl", "false");

        try(Connection conn = DriverManager.getConnection(dbConnectionInfo.getDatabaseUrl(), props)) {
            for(SeedTable givenTable: givenTables) {
                System.out.println("Working on tale: " + givenTable.getName());
                PgTableMetadata tableMetadata = PgTableInspector.inspectTable(conn, givenTable.getName());
                for(SeedTableRow row : givenTable.getRows()) {
                    String sql = PgTableSQLComposer.composeInsertStatement(
                            tableMetadata, row.getMap());
                    System.out.println("\nExecuting sql:\n" + sql);
                    Statement stmt = conn.createStatement();
                    //stmt.executeUpdate(errorOrSql.get());
                }
            }
        }
    }
}

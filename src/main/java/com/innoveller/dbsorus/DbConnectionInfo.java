package com.innoveller.dbsorus;

public class DbConnectionInfo {
    private final String databaseUrl;
    private final String username;
    private final String password;

    public DbConnectionInfo(String databaseUrl, String username, String password) {
        this.databaseUrl = databaseUrl;
        this.username = username;
        this.password = password;
    }

    public String getDatabaseUrl() {
        return databaseUrl;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
}
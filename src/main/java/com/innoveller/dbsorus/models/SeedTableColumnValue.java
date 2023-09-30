package com.innoveller.dbsorus.models;

public class SeedTableColumnValue {
    private final String columnName;
    private final String value;

    public SeedTableColumnValue(String columnName, String value) {
        this.columnName = columnName;
        this.value = value;
    }

    public String getColumnName() {
        return columnName;
    }

    public String getValue() {
        return value;
    }
}

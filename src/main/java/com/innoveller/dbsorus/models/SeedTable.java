package com.innoveller.dbsorus.models;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SeedTable {
    private final String tableName;
    private final List<String> columnNames;
    private final List<SeedTableRow> rows;

    public SeedTable(String tableName, List<String> columnNames, List<SeedTableRow> rows) {
        this.tableName = tableName;
        this.columnNames = columnNames;
        this.rows = rows;
    }

    public String getName() {
        return tableName;
    }

    public List<String> getColumnNames() {
        return columnNames;
    }

    public List<SeedTableRow> getRows() {
        return rows;
    }


    public SeedTable withRows(List<SeedTableRow> newRows) {
        return new SeedTable(tableName, columnNames, newRows);
    }

}

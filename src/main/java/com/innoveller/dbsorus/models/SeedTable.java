package com.innoveller.dbsorus.models;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SeedTable implements SeedObject {
    private final String tableName;
    private final List<String> columnNames;
    private final List<SeedTableRow> rows;

    private final int precedence;

    public SeedTable(String tableName, int precedence, List<String> columnNames, List<SeedTableRow> rows) {
        this.tableName = tableName;
        this.columnNames = columnNames;
        this.rows = rows;
        this.precedence = precedence;
    }

    @Override
    public int getPrecedence() {
        return precedence;
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
        return new SeedTable(tableName, precedence, columnNames, newRows);
    }

}

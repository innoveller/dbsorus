package com.innoveller.dbsorus.models;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class SeedTableBuilder {
    private final String tableName;
    private List<String> columnNames;
    private List<List<String>> rowList = new ArrayList<>();

    private SeedTableBuilder(String tableName) {
        this.tableName = tableName;
    }

    public SeedTableBuilder columns(String... columnNames) {
        this.columnNames = Stream.of(columnNames).collect(Collectors.toList());
        return this;
    }

    public SeedTableBuilder row(String... values) {
        if(this.columnNames == null || this.columnNames.isEmpty()) {
            throw new RuntimeException("Columns must be defined first.");
        }

        if(this.columnNames.size() != values.length) {
            throw new RuntimeException("Row values must match columns");
        }

        List<String> row = Stream.of(values).collect(Collectors.toList());
        this.rowList.add(row);
        return this;
    }

    public SeedTable build() {
        List<SeedTableRow> seedTableRows = this.rowList.stream().map(columnValues -> {
            Map<String, String> columnName2ValueMap = new HashMap<>();
            for(int i=0; i < columnNames.size(); i++) {
                String columnName = columnNames.get(i);
                String columnValue = columnValues.get(i);
                columnName2ValueMap.put(columnName, columnValue);
            }
            return new SeedTableRow(columnName2ValueMap);
        }).collect(Collectors.toList());
        return new SeedTable(this.tableName, 0, this.columnNames, seedTableRows);
    }

    public static SeedTableBuilder table(String tableName) {
        return new SeedTableBuilder(tableName);
    }

    public static String integer(String key) {
        return "@int:" + key;
    }

    public static String uuid(String key) {
        return "@uuid:" + key;
    }

    public static String series(int from, int to) {
        return "@series:" + from + ".." + to;
    }

    public static String series(LocalDate from, LocalDate to) {
        return "@series:" + from.format(DateTimeFormatter.ISO_DATE) + ".." + to.format(DateTimeFormatter.ISO_DATE);
    }
}

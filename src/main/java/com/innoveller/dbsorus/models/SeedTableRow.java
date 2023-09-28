package com.innoveller.dbsorus.models;

import java.util.HashMap;
import java.util.Map;

public class SeedTableRow {
    private final Map<String, String> map;

    public SeedTableRow(Map<String, String> givenMap) {
        this.map = new HashMap<>(givenMap);
    }

    public Map<String, String> getMap() {
        return this.map;
    }

    public String getValue(String columnName) {
        return map.get(columnName);
    }

    public SeedTableRow withNewValue(String columnName, String newValue) {
        Map<String, String> newMap = new HashMap<>(map);
        newMap.put(columnName, newValue);
        return new SeedTableRow(newMap);
    }

    public SeedTableRow withNewValues(Map<String, String> partialMap) {
        Map<String, String> newMap = new HashMap<>(map);
        newMap.putAll(partialMap);
        return new SeedTableRow(newMap);
    }

    // // https://stackoverflow.com/questions/40879952/parsing-insert-sql-query-in-java-using-regular-expression
}

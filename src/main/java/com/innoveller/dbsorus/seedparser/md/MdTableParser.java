package com.innoveller.dbsorus.seedparser.md;

import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.SeedTableRow;
import com.innoveller.dbsorus.utils.IOUtils;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class MdTableParser {
    private static final String TABLE_ATTRIBUTE_KEY = "@table:";

    public List<SeedTable> parseTables(InputStream inputStream) throws Exception {
        List<String> lines = IOUtils.readLines(inputStream, StandardCharsets.UTF_8);
        return parseTables(lines);
    }

    public List<SeedTable> parseTables(List<String> lines) throws Exception {
        Map<NameWithPrecedence, List<String>> tableName2Lines = groupLinesByTableName(lines);
        //System.out.println("num tables" + tableName2Lines.size());

        List<SeedTable> tables = new ArrayList<>();
        for(Map.Entry<NameWithPrecedence, List<String>> entry: tableName2Lines.entrySet()) {
            SeedTable table = parseTable(entry.getKey().getName(), entry.getKey().getPrecedence(), entry.getValue());
            tables.add(table);
        }
        return tables;
    }

    private Map<NameWithPrecedence, List<String>> groupLinesByTableName(List<String> lines) {
        Map<NameWithPrecedence, List<String>> tableName2Lines = new LinkedHashMap<>();
        NameWithPrecedence currentTableName = null;
        for(int i = 0; i < lines.size(); i++) {
            String currLine = lines.get(i);
            if(currLine.contains(TABLE_ATTRIBUTE_KEY)) {
                int subStringStart = currLine.indexOf(TABLE_ATTRIBUTE_KEY) + TABLE_ATTRIBUTE_KEY.length();
                currentTableName = new NameWithPrecedence(currLine.substring(subStringStart).trim(), i);
                tableName2Lines.put(currentTableName, new ArrayList<>());
            } else {
                if(currentTableName!=null && !currLine.isEmpty() && !currLine.contains("-|")) {
                    tableName2Lines.get(currentTableName).add(currLine);
                }

                if(currentTableName!=null && currLine.isEmpty() && !tableName2Lines.get(currentTableName).isEmpty()) {
                    currentTableName = null;
                }
                //TODO break after space
            }
        }
        return tableName2Lines;
    }

    private SeedTable parseTable(String tableName, int precedence, List<String> lines) throws Exception {
        //System.out.println("Parsing table: " + tableName);
        List<String> columnNames = parseColumnNames(lines.get(0));
        List<SeedTableRow> tableRows = new ArrayList<>();
        for(int i = 1; i < lines.size(); i++) {
            String currLine = lines.get(i);
            Map<String, String> map = new HashMap<>();
            List<String> columnValues = parseColumnValues(currLine);
            for(int colIndex = 0; colIndex< columnNames.size(); colIndex++) {
                String columnName = columnNames.get(colIndex);
                String columnValue = columnValues.get(colIndex);
                map.put(columnName, isNullString(columnValue)? null : columnValue);
            }
            tableRows.add(new SeedTableRow(map));
        }
        return new SeedTable(tableName, precedence, columnNames, tableRows);
    }

    private List<String> parseColumnNames(String mdTableRowString) {
        String[] tokens = mdTableRowString.replaceFirst("\\|", "").split("\\|");
        return Stream.of(tokens).map(String::trim).filter(value -> !value.isEmpty()).collect(Collectors.toList());
    }

    private List<String> parseColumnValues(String mdTableRowString) {
        String[] tokens = mdTableRowString.replaceFirst("\\|", "").split("\\|");
        return Stream.of(tokens).map(String::trim).collect(Collectors.toList());
    }

    private boolean isNullString(String value) {
        if(value == null) {
            return true;
        } else return "null".equalsIgnoreCase(value.trim());
    }

    private void printLines(String description, List<String> lines) {
        System.out.println(description);
        for(String line : lines) {
            System.out.println(line);
        }
    }

}

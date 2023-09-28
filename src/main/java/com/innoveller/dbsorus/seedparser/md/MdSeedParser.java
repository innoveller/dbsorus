package com.innoveller.dbsorus.seedparser.md;

import com.innoveller.dbsorus.DirectiveProcessor;
import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.SeedTableRow;
import com.innoveller.dbsorus.utils.IOUtils;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class MdSeedParser {
    private static final String TABLE_ATTRIBUTE_KEY = "@tbl:";

    private final DirectiveProcessor directiveProcessor = new DirectiveProcessor();

    public List<SeedTable> parseTables(InputStream inputStream) throws Exception {
        List<String> lines = IOUtils.readLines(inputStream, StandardCharsets.UTF_8);
        Map<String, List<String>> tableName2Lines = groupLinesByTableName(lines);

        List<SeedTable> tables = new ArrayList<>();
        for(Map.Entry<String, List<String>> entry: tableName2Lines.entrySet()) {
            SeedTable table = parseTable(entry.getKey(), entry.getValue());
            tables.add(table);
        }
        return tables;
    }

    private Map<String, List<String>> groupLinesByTableName(List<String> lines) {
        Map<String, List<String>> tableName2Lines = new LinkedHashMap<>();
        String currentTableName = null;
        for(int i = 0; i < lines.size(); i++) {
            String currLine = lines.get(i);
            if(currLine.contains(TABLE_ATTRIBUTE_KEY)) {
                int subStringStart = currLine.indexOf(TABLE_ATTRIBUTE_KEY) + TABLE_ATTRIBUTE_KEY.length();
                currentTableName = currLine.substring(subStringStart).trim();
                tableName2Lines.put(currentTableName, new ArrayList<>());
            } else {
                if(currentTableName!=null && !currLine.isBlank() && !currLine.contains("-|")) {
                    tableName2Lines.get(currentTableName).add(currLine);
                }
            }
        }
        return tableName2Lines;
    }

    private SeedTable parseTable(String tableName, List<String> lines) throws Exception {
        List<String> columnNames = parseColumnNames(lines.get(0));
        List<SeedTableRow> tableRows = new ArrayList<>();
        for(int i = 1; i < lines.size(); i++) {
            String currLine = lines.get(i);
            Map<String, String> map = new HashMap<>();
            List<String> columnValues = parseColumnValues(currLine);
            for(int colIndex = 0; colIndex< columnNames.size(); colIndex++) {
                String columnName = columnNames.get(colIndex);
                String columnValue = columnValues.get(colIndex);
                map.put(columnName, columnValue);
            }
            tableRows.add(new SeedTableRow(map));
        }
        return new SeedTable(tableName, columnNames, tableRows);
    }

    private List<String> parseColumnNames(String mdTableRowString) {
        String[] tokens = mdTableRowString.replaceFirst("\\|", "").split("\\|");
        return Stream.of(tokens).map(String::trim).filter(value -> !value.isBlank()).collect(Collectors.toList());
    }

    private List<String> parseColumnValues(String mdTableRowString) {
        String[] tokens = mdTableRowString.replaceFirst("\\|", "").split("\\|");
        return Stream.of(tokens).map(String::trim).collect(Collectors.toList());
    }

    private void printLines(String description, List<String> lines) {
        System.out.println(description);
        for(String line : lines) {
            System.out.println(line);
        }
    }

}

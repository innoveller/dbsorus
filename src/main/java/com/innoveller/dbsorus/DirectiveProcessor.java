package com.innoveller.dbsorus;

import com.innoveller.dbsorus.expressions.SeriesExpressionParser;
import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.SeedTableRow;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class DirectiveProcessor {
    private final Map<String, UUID> uuidMap = new HashMap<>();
    private final Map<String, Integer> integerMap = new HashMap<>();

    public UUID getOrGenerateUUID(String key) {
        if(uuidMap.containsKey(key)) {
            return uuidMap.get(key);
        } else {
            UUID uuid = UUID.randomUUID();
            uuidMap.put(key, uuid);
            return uuid;
        }
    }

    public Integer getOrGenerateInteger(String key) {
        if(integerMap.containsKey(key)) {
            return integerMap.get(key);
        } else {
            Integer intValue = Double.valueOf(Math.random() * Integer.MAX_VALUE).intValue();
            integerMap.put(key, intValue);
            return intValue;
        }
    }

    public SeedTable processDirectives(SeedTable seedTable) throws Exception {
        List<SeedTableRow> tableRowsAfterDirectives = new ArrayList<>();
        for (SeedTableRow tableRow : seedTable.getRows()) {
            List<SeedTableRow> rows = processDirectives(tableRow);
            tableRowsAfterDirectives.addAll(rows);
        }
        return seedTable.withRows(tableRowsAfterDirectives);
    }

    public List<SeedTableRow> processDirectives(SeedTableRow row) throws Exception {
        // process @uuid
        Map<String, String> updatingColumnValues = new HashMap<>();
        row.getMap().forEach((key, value) -> {
            if(value != null) {
                if(value.trim().startsWith("@uuid:")) {
                    updatingColumnValues.put(key, getOrGenerateUUID(value.trim()).toString());
                } else if(value.trim().startsWith("@integer:")) {
                    updatingColumnValues.put(key, getOrGenerateInteger(value.trim()).toString());
                } else if(value.trim().startsWith("@date:")) {
                    String dateExpression = value.trim().substring("@date:".length()).trim();
                    if("today".equalsIgnoreCase(dateExpression)) {
                        String dateValue = LocalDate.now().format(DateTimeFormatter.ISO_DATE);
                        updatingColumnValues.put(key, dateValue);
                    }
                }
            }
        });
        row = row.withNewValues(updatingColumnValues);

        // process @series
        Optional<Map.Entry<String, String>> entryOptional = row.getMap().entrySet().stream()
                .filter(entry -> entry.getValue()!=null && entry.getValue().contains("@series:")).findAny();
        if(entryOptional.isPresent()) {
            String columnName = entryOptional.get().getKey();
            String value = entryOptional.get().getValue().trim();

            String rangePart = value.substring(value.indexOf("@series:") + "@series:".length());
            System.out.println("Range part: " + rangePart);

            List<String> serialValues = SeriesExpressionParser.generateSeries(rangePart);
            List<SeedTableRow> serialRows = new ArrayList<>();
            for(String serialValue: serialValues) {
                serialRows.add(row.withNewValue(columnName, serialValue));
            }
            return serialRows;
        }
        return Collections.singletonList(row);
    }


}

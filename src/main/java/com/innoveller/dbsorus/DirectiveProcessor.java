package com.innoveller.dbsorus;

import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.SeedTableRow;

import java.util.*;

public class DirectiveProcessor {
    private final Map<String, UUID> uuidMap = new HashMap<>();

    private UUID getOrGenerateUUID(String key) {
        if(uuidMap.containsKey(key)) {
            return uuidMap.get(key);
        } else {
            UUID uuid = UUID.randomUUID();
            uuidMap.put(key, uuid);
            return uuid;
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
        Map<String, String> uuidGeneratedColumnValueMap = new HashMap<>();
        row.getMap().forEach((key, value) -> {
            if(value != null && value.trim().startsWith("@uuid:")) {
                uuidGeneratedColumnValueMap.put(key, getOrGenerateUUID(value.trim()).toString());
            }
        });
        row = row.withNewValues(uuidGeneratedColumnValueMap);

        // process @series
        Optional<Map.Entry<String, String>> entryOptional = row.getMap().entrySet().stream()
                .filter(entry -> entry.getValue().contains("@series:")).findAny();
        if(entryOptional.isPresent()) {
            String columnName = entryOptional.get().getKey();
            String value = entryOptional.get().getValue().trim();

            String rangePart = value.substring(value.indexOf("@series:") + "@series:".length());
            System.out.println("Range part: " + rangePart);

            List<String> serialValues = SeriesGenerator.generateSeries(rangePart);
            List<SeedTableRow> serialRows = new ArrayList<>();
            for(String serialValue: serialValues) {
                serialRows.add(row.withNewValue(columnName, serialValue));
            }
            return serialRows;
        }
        return Collections.singletonList(row);
    }


}

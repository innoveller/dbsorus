package com.innoveller.dbsorus.directives;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.TextNode;
import com.innoveller.dbsorus.IDGenerator;
import com.innoveller.dbsorus.directives.ColumnLevelDirectiveProcessor;
import com.innoveller.dbsorus.expressions.SeriesExpressionParser;
import com.innoveller.dbsorus.models.SeedJsonDocument;
import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.SeedTableRow;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class DirectiveProcessor {

    private final ColumnLevelDirectiveProcessor columnLevelDirectiveProcessor;

    private final ObjectMapper objectMapper;

    private final IDGenerator idGenerator;

    public DirectiveProcessor(IDGenerator idGenerator) {
        this.idGenerator = idGenerator;
        columnLevelDirectiveProcessor = new ColumnLevelDirectiveProcessor(idGenerator);

        objectMapper = new ObjectMapper();
        objectMapper.setNodeFactory(new JsonNodeFactory() {
            @Override
            public TextNode textNode(String text) {
                String processedText = columnLevelDirectiveProcessor.processDirective(text);
                return super.textNode(processedText);
            }
        });
    }

    public IDGenerator getIdGenerator() {
        return idGenerator;
    }

    public ColumnLevelDirectiveProcessor getColumnLevelDirectiveProcessor() {
        return columnLevelDirectiveProcessor;
    }

    public Optional<UUID> retrieveGeneratedUUID(String key) {
        return this.idGenerator.retrieveGeneratedUUID(key);
    }

    public Optional<Integer> retrieveGeneratedInteger(String key) {
        return this.idGenerator.retrieveGeneratedInteger(key);
    }

    public JsonNode processDirectives(SeedJsonDocument seedJsonDocument) throws IOException {
        return objectMapper.readTree(seedJsonDocument.getJsonNode().traverse());
    }

    public SeedTable processDirectives(SeedTable seedTable) throws Exception {
        List<SeedTableRow> tableRowsAfterDirectives = new ArrayList<>();
        for (SeedTableRow tableRow : seedTable.getRows()) {
            List<SeedTableRow> rows = processDirectives(tableRow);
            tableRowsAfterDirectives.addAll(rows);
        }
        return seedTable.withRows(tableRowsAfterDirectives);
    }

    public List<SeedTableRow> processDirectives(SeedTableRow givenRow) throws Exception {
        Map<String, String> updatingValues = new HashMap<>();
        for(Map.Entry<String, String> entry: givenRow.getMap().entrySet()) {
            if(entry.getValue() != null) {
                updatingValues.put(entry.getKey(), columnLevelDirectiveProcessor.processDirective(entry.getValue()));
            }
        }
        SeedTableRow columnLevelProcessedRow = givenRow.withNewValues(updatingValues);

        // process row-level directives
        Optional<Map.Entry<String, String>> entryOptional = columnLevelProcessedRow.getMap().entrySet().stream()
                .filter(entry -> entry.getValue()!=null && entry.getValue().contains("@series:")).findAny();
        if(entryOptional.isPresent()) {
            String columnName = entryOptional.get().getKey();
            String value = entryOptional.get().getValue().trim();

            String rangePart = value.substring(value.indexOf("@series:") + "@series:".length());
            System.out.println("Range part: " + rangePart);

            List<String> serialValues = SeriesExpressionParser.generateSeries(rangePart);
            List<SeedTableRow> serialRows = new ArrayList<>();
            for(String serialValue: serialValues) {
                serialRows.add(columnLevelProcessedRow.withNewValue(columnName, serialValue));
            }
            return serialRows;
        } else {
            return Collections.singletonList(columnLevelProcessedRow);
        }
    }


}

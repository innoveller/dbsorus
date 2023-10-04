package com.innoveller.dbsorus.directives;

import com.fasterxml.jackson.databind.JsonNode;
import com.innoveller.dbsorus.expressions.DateTimeExpressionParser;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.List;

public class ColumnLevelDirectiveProcessor {
    private final Map<String, UUID> uuidMap = new HashMap<>();
    private final Map<String, Integer> integerMap = new HashMap<>();
    private final Map<String, JsonNode> jsonNodeMap = new HashMap<>();
    private final ColumnLevelDirectiveParser directiveParser = new ColumnLevelDirectiveParser();
    private final DirectiveExpressionExtractor directiveExpressionExtractor = new DirectiveExpressionExtractor();

    public void addJsonNode(String key, JsonNode jsonNode) {
        System.out.println("Adding json node with key: " + key);
        System.out.println(jsonNode.toString());
        this.jsonNodeMap.put(key, jsonNode);
    }

    public UUID getOrGenerateUUID(String key) {
        if(uuidMap.containsKey(key)) {
            return uuidMap.get(key);
        } else {
            UUID uuid = UUID.randomUUID();
            uuidMap.put(key, uuid);
            return uuid;
        }
    }

    public Optional<UUID> retrieveGeneratedUUID(String key) {
        if(uuidMap.containsKey(key)) {
            return Optional.of(uuidMap.get(key));
        } else {
            return Optional.empty();
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

    public Optional<Integer> retrieveGeneratedInteger(String key) {
        if(integerMap.containsKey(key)) {
            return Optional.of(integerMap.get(key));
        } else {
            return Optional.empty();
        }
    }

    public String processDirective(String columnValue) {
        if(columnValue != null && !columnValue.isEmpty()) {
            if(columnValue.trim().startsWith("@")) {
                Optional<ColumnLevelDirective> directiveOptional = directiveParser.parse(columnValue);
                if(directiveOptional.isPresent()) {
                    ColumnLevelDirective directive = directiveOptional.get();
                    return executeDirective(directive);
                }
            }

            // just a quick sanity check before proceeding with parsing
            if(columnValue.contains("@")) {
                List<String> directiveExpressionCandidates = directiveExpressionExtractor.extractDirectiveExpressions(columnValue);
                if(!directiveExpressionCandidates.isEmpty()) {
                    String rebuildingColumnValue = columnValue;
                    for(String directiveCandidate: directiveExpressionCandidates) {
                        Optional<ColumnLevelDirective> directiveOptional = directiveParser.parse(directiveCandidate);
                        if(directiveOptional.isPresent()) {
                            ColumnLevelDirective directive = directiveOptional.get();
                            String result = executeDirective(directive);
                            rebuildingColumnValue = rebuildingColumnValue.replace(directiveCandidate, result);
                        }
                    }
                    return rebuildingColumnValue;
                }
            }
        }
        return columnValue;
    }

    private String executeDirective(ColumnLevelDirective directive) {
        switch (directive.getType()) {
            case UUID:
                return getOrGenerateUUID(directive.getValue()).toString();
            case INTEGER:
                return getOrGenerateInteger(directive.getValue()).toString();
            case DATE:
                return DateTimeExpressionParser.parseDate(directive.getValue()).format(DateTimeFormatter.ISO_DATE);
            case DATETIME:
                return DateTimeExpressionParser.parseDateTime(directive.getValue()).format(DateTimeFormatter.ISO_DATE_TIME);
            case INSTANT:
                return DateTimeExpressionParser.parseInstant(directive.getValue()).toString();
            case JSON:
                return (jsonNodeMap.containsKey(directive.getValue()))? jsonNodeMap.get(directive.getValue()).toString() : "";
            default:
                throw new RuntimeException("Cannot process the parsed directive: " + directive.getType());
        }
    }
}

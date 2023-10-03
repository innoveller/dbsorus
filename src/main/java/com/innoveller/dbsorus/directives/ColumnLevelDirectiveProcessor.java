package com.innoveller.dbsorus.directives;

import com.fasterxml.jackson.databind.JsonNode;
import com.innoveller.dbsorus.expressions.DateTimeExpressionParser;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

public class ColumnLevelDirectiveProcessor {
    private final Map<String, UUID> uuidMap = new HashMap<>();
    private final Map<String, Integer> integerMap = new HashMap<>();

    private final Map<String, JsonNode> jsonNodeMap = new HashMap<>();

    private final ColumnLevelDirectiveParser directiveParser = new ColumnLevelDirectiveParser();

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
        if(columnValue != null && columnValue.contains("json")) {
            System.err.println("Interesting: column value: " + columnValue);
        }

        if(columnValue != null && !columnValue.isEmpty()) {
            Optional<ColumnLevelDirective> directiveOptional = directiveParser.parse(columnValue);
            if(directiveOptional.isPresent()) {
                ColumnLevelDirective directive = directiveOptional.get();
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
        return columnValue;
    }
}

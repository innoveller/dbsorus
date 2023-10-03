package com.innoveller.dbsorus.models;

import com.fasterxml.jackson.databind.JsonNode;

public class SeedJsonDocument implements SeedObject {
    private final String name;
    private final int precedence;
    private final JsonNode jsonNode;

    public SeedJsonDocument(String name, int precedence, JsonNode jsonNode) {
        this.name = name;
        this.precedence = precedence;
        this.jsonNode = jsonNode;
    }

    public String getName() {
        return name;
    }

    @Override
    public int getPrecedence() {
        return precedence;
    }

    public JsonNode getJsonNode() {
        return jsonNode;
    }
}

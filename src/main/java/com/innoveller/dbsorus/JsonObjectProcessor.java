package com.innoveller.dbsorus;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.TextNode;

import java.io.IOException;

public class JsonObjectProcessor {

    public String process(String jsonString) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        mapper.setNodeFactory(new JsonNodeFactory() {
            @Override
            public TextNode textNode(String text) {
                return super.textNode(text.toUpperCase());
            }
        });
        JsonNode jsonNode = mapper.readTree(jsonString);
        return mapper.writeValueAsString(jsonNode);
    }
}

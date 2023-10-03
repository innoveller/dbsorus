package com.innoveller.dbsorus.seedparser.md;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.innoveller.dbsorus.models.SeedJsonDocument;
import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.SeedTableRow;
import com.innoveller.dbsorus.utils.IOUtils;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class MdJsonParser {
    private static final String JSON_DOC_ATTRIBUTE_KEY = "@json:";

    private final ObjectMapper objectMapper = new ObjectMapper();

    public List<SeedJsonDocument> parseJsonObjects(InputStream inputStream) throws Exception {
        List<String> lines = IOUtils.readLines(inputStream, StandardCharsets.UTF_8);
        return parseJsonObjects(lines);
    }

    public List<SeedJsonDocument> parseJsonObjects(List<String> lines) throws Exception {

        Map<NameWithPrecedence, List<String>> docName2Lines = groupLinesByDocument(lines);
        System.out.println("Docs to Line Groups : " + docName2Lines.size());

        List<SeedJsonDocument> parsedDocuments = new ArrayList<>();

        for(Map.Entry<NameWithPrecedence, List<String>> entry : docName2Lines.entrySet()) {
            String jsonString = String.join("\n", entry.getValue());
            System.out.println("Json: " + entry.getKey().getName());
            System.out.println(jsonString);
            JsonNode jsonNode = objectMapper.readTree(jsonString);
            SeedJsonDocument document = new SeedJsonDocument(entry.getKey().getName(), entry.getKey().getPrecedence(), jsonNode);
            parsedDocuments.add(document);
        }
        return parsedDocuments;
    }

    private Map<NameWithPrecedence, List<String>> groupLinesByDocument(List<String> lines) {
        Map<NameWithPrecedence, List<String>> jsonDocName2Lines = new LinkedHashMap<>();
        NameWithPrecedence currJsonDocName = null;
        boolean foundCodeBlockStart = false;

        for(int i = 0; i < lines.size(); i++) {
            String currLine = lines.get(i);
            if(currLine.trim().startsWith(JSON_DOC_ATTRIBUTE_KEY)) {
                int subStringStart = currLine.indexOf(JSON_DOC_ATTRIBUTE_KEY) + JSON_DOC_ATTRIBUTE_KEY.length();
                currJsonDocName = new NameWithPrecedence(currLine.substring(subStringStart).trim(), i);
                jsonDocName2Lines.put(currJsonDocName, new ArrayList<>());
            } else {
                if(currJsonDocName != null) {

                    if(currLine.contains("```")) {
                        if(!foundCodeBlockStart) {
                            foundCodeBlockStart = true;
                        } else {
                            currJsonDocName = null;
                            foundCodeBlockStart = false;
                        }
                    } else {
                        if(foundCodeBlockStart) {
                            jsonDocName2Lines.get(currJsonDocName).add(currLine);
                        }
                    }
                }
            }
        }
        return jsonDocName2Lines;
    }
}

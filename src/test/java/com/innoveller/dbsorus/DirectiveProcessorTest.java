package com.innoveller.dbsorus;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.innoveller.dbsorus.directives.DirectiveProcessor;
import com.innoveller.dbsorus.models.SeedJsonDocument;
import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.SeedTableRow;
import com.innoveller.dbsorus.testhelpers.FluentHashMap;
import org.junit.Test;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

public class DirectiveProcessorTest {
    @Test
    public void shouldSupportNullValues() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        SeedTableRow seedTableRow1 = new SeedTableRow(FluentHashMap.map("id", "1").with("name", "James"));
        SeedTableRow seedTableRow2 = new SeedTableRow(FluentHashMap.map("id", "2").with("name", null));

        SeedTable seedTable = new SeedTable("users", 0, Collections.singletonList("id"),
                Stream.of(seedTableRow1, seedTableRow2).collect(Collectors.toList()));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(2, resultRows.size());

        assertEquals("1", resultRows.get(0).getValue("id"));
        assertEquals("James", resultRows.get(0).getValue("name"));

        assertEquals("2", resultRows.get(1).getValue("id"));
        assertNull(resultRows.get(1).getValue("name"));
    }

    @Test
    public void shouldGenerateUUIDs() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        SeedTableRow seedTableRow = new SeedTableRow(Collections.singletonMap("id", "@uuid:x"));
        SeedTable seedTable = new SeedTable("users", 0, Collections.singletonList("id"), Collections.singletonList(seedTableRow));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(1, resultRows.size());

        String uuidString = resultRows.get(0).getValue("id");
        assertEquals(uuidString, UUID.fromString(uuidString).toString());
    }

    @Test
    public void shouldGenerateInteger() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        SeedTableRow seedTableRow1 = new SeedTableRow(Collections.singletonMap("id", "@int:x"));
        SeedTableRow seedTableRow2 = new SeedTableRow(Collections.singletonMap("id", "@integer:y"));

        SeedTable seedTable = new SeedTable("users", 0, Collections.singletonList("id"),
                Stream.of(seedTableRow1, seedTableRow2).collect(Collectors.toList()));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(2, resultRows.size());

        String intString1 = resultRows.get(0).getValue("id");
        Integer retrievedInt1 = directiveProcessor.retrieveGeneratedInteger("x").get();
        assertEquals(String.valueOf(retrievedInt1), intString1);

        String intString2 = resultRows.get(1).getValue("id");
        Integer retrievedInt2 = directiveProcessor.retrieveGeneratedInteger("y").get();
        assertEquals(String.valueOf(retrievedInt2), intString2);
    }

    @Test
    public void shouldGenerateNumberSeries() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        Map<String, String> rowMap = new HashMap<>();
        rowMap.put("id", "1");
        rowMap.put("total_count", "@series:10..14");

        SeedTableRow seedTableRow = new SeedTableRow(rowMap);
        SeedTable seedTable = new SeedTable("purchases", 0, Stream.of("id", "total_count").collect(Collectors.toList()),
                Collections.singletonList(seedTableRow));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(5, resultRows.size());

        assertEquals("10", resultRows.get(0).getValue("total_count"));
        assertEquals("11", resultRows.get(1).getValue("total_count"));
        assertEquals("12", resultRows.get(2).getValue("total_count"));
        assertEquals("13", resultRows.get(3).getValue("total_count"));
        assertEquals("14", resultRows.get(4).getValue("total_count"));
    }

    @Test
    public void shouldGenerateDateSeries() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        Map<String, String> rowMap = new HashMap<>();
        rowMap.put("id", "1");
        rowMap.put("date", "@series:2023-01-01..2023-01-03");

        SeedTableRow seedTableRow = new SeedTableRow(rowMap);
        SeedTable seedTable = new SeedTable("rates", 0, Stream.of("id", "date").collect(Collectors.toList()), Collections.singletonList(seedTableRow));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(3, resultRows.size());

        assertEquals("2023-01-01", resultRows.get(0).getValue("date"));
        assertEquals("2023-01-02", resultRows.get(1).getValue("date"));
        assertEquals("2023-01-03", resultRows.get(2).getValue("date"));
    }

    @Test
    public void shouldGenerateDate() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        SeedTableRow seedTableRow = new SeedTableRow(FluentHashMap
                .map("room_id", "@uuid:r1")
                .with("date", "@date:today")
                .with("allotment", "3"));
        SeedTable seedTable = new SeedTable("room_allotment",
                0, Stream.of("room_id", "date", "allotment").collect(Collectors.toList()), //TODO weak link
                Collections.singletonList(seedTableRow));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(1, resultRows.size());

        String uuidString = resultRows.get(0).getValue("room_id");
        assertEquals(uuidString, UUID.fromString(uuidString).toString());

        String isoDateString = resultRows.get(0).getValue("date");
        assertEquals(LocalDate.now().format(DateTimeFormatter.ISO_DATE), isoDateString);
    }

    @Test
    public void shouldGenerateDateTime() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        SeedTableRow seedTableRow = new SeedTableRow(FluentHashMap
                .map("room_id", "@uuid:r1")
                .with("today", "@date:today")
                .with("tomorrow", "@date:today+P1D")
                .with("meeting_time", "@datetime:now")
                .with("allotment", "3"));
        SeedTable seedTable = new SeedTable("room_allotment",
                0, Collections.emptyList(), //TODO weak link
                Collections.singletonList(seedTableRow));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(1, resultRows.size());

        String uuidString = resultRows.get(0).getValue("room_id");
        UUID uuid = directiveProcessor.retrieveGeneratedUUID("r1").get();
        assertEquals(uuid.toString(), uuidString);

        assertEquals(LocalDate.now().format(DateTimeFormatter.ISO_DATE), resultRows.get(0).getValue("today"));

        //assertEquals(LocalDate.now().plusDays(1).format(DateTimeFormatter.ISO_DATE), resultRows.get(0).getValue("tomorrow"));
        //assertEquals(LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME), resultRows.get(0).getValue("meeting_time"));
        //String isoDateString = resultRows.get(0).getValue("date");
        //assertEquals(LocalDate.now().format(DateTimeFormatter.ISO_DATE), isoDateString);
    }

    @Test
    public void shouldProcessDirectivesOnJson() throws IOException {
        String content = "[\n" +
                "   {\n" +
                "      \"id\":\"@int:rt-1\",\n" +
                "      \"date\":\"@date:today\",\n" +
                "      \"rates\":[],\n" +
                "      \"date\":200,\n" +
                "      \"rateGroupId\":100,\n" +
                "      \"numberOfAdults\":2,\n" +
                "      \"numberOfChildren\":0,\n" +
                "      \"numberOfExtraBeds\":0\n" +
                "   }\n" +
                "]";
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(content);
        SeedJsonDocument seedJsonDocument = new SeedJsonDocument("selection", 0, jsonNode);

        DirectiveProcessor directiveProcessor = new DirectiveProcessor();
        Integer generatedInt = directiveProcessor.getColumnLevelDirectiveProcessor().getOrGenerateInteger("rt-1");
        JsonNode processNode = directiveProcessor.processDirectives(seedJsonDocument);
        System.out.println("processed json:\n" + processNode.toString());
        assertEquals(String.valueOf(generatedInt), processNode.get(0).get("id").asText());


    }


}

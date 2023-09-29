package com.innoveller.dbsorus.seedparser.md;

import com.innoveller.dbsorus.DirectiveProcessor;
import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.models.SeedTableRow;
import org.junit.Test;

import java.util.*;

import static org.junit.Assert.assertEquals;

public class DirectiveProcessorTest {

    @Test
    public void testProcessUUIDDirective() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        SeedTableRow seedTableRow = new SeedTableRow(Collections.singletonMap("id", "@uuid:x"));
        SeedTable seedTable = new SeedTable("users", List.of("id"), Collections.singletonList(seedTableRow));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(1, resultRows.size());

        String uuidString = resultRows.get(0).getValue("id");
        assertEquals(uuidString, UUID.fromString(uuidString).toString());
    }

    @Test
    public void testProcessSeriesDirectiveForNumbers() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        Map<String, String> rowMap = new HashMap<>();
        rowMap.put("id", "1");
        rowMap.put("total_count", "@series:10..14");

        SeedTableRow seedTableRow = new SeedTableRow(rowMap);
        SeedTable seedTable = new SeedTable("purchases", List.of("id", "total_count"), Collections.singletonList(seedTableRow));

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
    public void testProcessSeriesDirectiveForDates() throws Exception {
        DirectiveProcessor directiveProcessor = new DirectiveProcessor();

        Map<String, String> rowMap = new HashMap<>();
        rowMap.put("id", "1");
        rowMap.put("date", "@series:2023-01-01..2023-01-03");

        SeedTableRow seedTableRow = new SeedTableRow(rowMap);
        SeedTable seedTable = new SeedTable("rates", List.of("id", "date"), Collections.singletonList(seedTableRow));

        SeedTable resultSeedTable = directiveProcessor.processDirectives(seedTable);
        List<SeedTableRow> resultRows = resultSeedTable.getRows();
        assertEquals(3, resultRows.size());

        assertEquals("2023-01-01", resultRows.get(0).getValue("date"));
        assertEquals("2023-01-02", resultRows.get(1).getValue("date"));
        assertEquals("2023-01-03", resultRows.get(2).getValue("date"));
    }
}

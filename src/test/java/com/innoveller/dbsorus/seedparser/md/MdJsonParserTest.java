package com.innoveller.dbsorus.seedparser.md;

import com.innoveller.dbsorus.models.SeedJsonDocument;
import com.innoveller.dbsorus.models.SeedTable;
import org.junit.Test;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class MdJsonParserTest {

    @Test
    public void testParse() throws Exception {
        String content = "\n" +
                "@json: selection-1\n" +
                "```json\n" +
                "[\n" +
                "   {\n" +
                "      \"id\":\"@int:rt-1\",\n" +
                "      \"rates\":[         \n" +
                "         {\n" +
                "            \"date\":\"@date:now+P1D\",\n" +
                "            \"netRate\":18900.0,\n" +
                "            \"sellRate\":21000.0,\n" +
                "            \"commissionRate\":2100.0,\n" +
                "            \"discountApplied\":null,\n" +
                "            \"sellRateRoomCharge\":21000.0,\n" +
                "            \"commissionableAmount\":21000.0,\n" +
                "            \"sellRateExtraBedsCharge\":0.0\n" +
                "         }\n" +
                "      ]\n" +
                "   }\n" +
                "]\n" +
                "```\n" +
                "\n" +
                "@json: selection-2\n" +
                "```json\n" +
                "[\n" +
                "   {\n" +
                "      \"id\":\"@int:rt-1\",\n" +
                "      \"rates\":[],\n" +
                "      \"roomTypeId\":200,\n" +
                "      \"rateGroupId\":100,\n" +
                "      \"numberOfAdults\":2,\n" +
                "      \"numberOfChildren\":0,\n" +
                "      \"numberOfExtraBeds\":0\n" +
                "   }\n" +
                "]\n" +
                "```";

        MdJsonParser parser = new MdJsonParser();
        try(InputStream in = new ByteArrayInputStream(content.getBytes())) {

            List<SeedJsonDocument> documents = parser.parseJsonObjects(in);
            assertEquals(2, documents.size());

            /*List<SeedTable> tables = new MdTableParser().parseTables(in);

            SeedTable table = tables.get(0);
            assertEquals("software_design_book", table.getName());
            assertEquals(2, table.getRows().size());

            assertEquals("10222", table.getRows().get(0).getValue("id"));
            assertEquals("The Mythical Man-Month", table.getRows().get(0).getValue("title"));
            assertEquals("Fred Brooks", table.getRows().get(0).getValue("author"));

            assertEquals("12982", table.getRows().get(1).getValue("id"));
            assertEquals("Clean Code", table.getRows().get(1).getValue("title"));
            assertEquals("Uncle Bob", table.getRows().get(1).getValue("author"));*/
        }
    }
}

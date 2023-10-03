package com.innoveller.dbsorus.seedparser.md;

import com.innoveller.dbsorus.models.SeedJsonDocument;
import com.innoveller.dbsorus.models.SeedTable;
import com.innoveller.dbsorus.utils.IOUtils;
import org.junit.Test;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

public class MdTableParserTest {

    @Test
    public void verifyParseSingleTableCorrectly() throws Exception {
        String content =
                "### @table: software_design_book\n" +
                "| id    | title                    | author      |\n" +
                "|-------|--------------------------|-------------|\n" +
                "| 10222 | The Mythical Man-Month   | Fred Brooks |\n" +
                "| 12982 | Clean Code               | Uncle Bob   |\n";
        try(InputStream in = new ByteArrayInputStream(content.getBytes())) {
            List<SeedTable> tables = new MdTableParser().parseTables(in);

            SeedTable table = tables.get(0);
            assertEquals("software_design_book", table.getName());
            assertEquals(2, table.getRows().size());

            assertEquals("10222", table.getRows().get(0).getValue("id"));
            assertEquals("The Mythical Man-Month", table.getRows().get(0).getValue("title"));
            assertEquals("Fred Brooks", table.getRows().get(0).getValue("author"));

            assertEquals("12982", table.getRows().get(1).getValue("id"));
            assertEquals("Clean Code", table.getRows().get(1).getValue("title"));
            assertEquals("Uncle Bob", table.getRows().get(1).getValue("author"));
        }
    }

    @Test
    public void verifyParsePoorlyFormattedTableCorrectly() throws Exception {
        String content = "@table: software_design_book\n" +
                        "| id | title | author |\n" +
                        "|-|-|-|\n" +
                        "| 10222 | The Mythical Man-Month | Fred Brooks |\n" +
                        "| 12982 | Clean Code | Uncle Bob |\n";
        try(InputStream in = new ByteArrayInputStream(content.getBytes())) {
            List<SeedTable> tables = new MdTableParser().parseTables(in);

            SeedTable table = tables.get(0);
            assertEquals("software_design_book", table.getName());
            assertEquals(2, table.getRows().size());

            assertEquals("10222", table.getRows().get(0).getValue("id"));
            assertEquals("The Mythical Man-Month", table.getRows().get(0).getValue("title"));
            assertEquals("Fred Brooks", table.getRows().get(0).getValue("author"));

            assertEquals("12982", table.getRows().get(1).getValue("id"));
            assertEquals("Clean Code", table.getRows().get(1).getValue("title"));
            assertEquals("Uncle Bob", table.getRows().get(1).getValue("author"));
        }
    }

    @Test
    public void verifyParseMultipleTablesCorrectly() throws Exception {
        String content =
                "### @table: bank\n" +
                "| id    | full_name        | short_name |\n" +
                "|-------|------------------|------------|\n" +
                "| 10222 | Bank of America  | boa        |\n" +
                "| 12982 | Chase            | cha        |\n" +
                        "\n" +
                "### @table: town\n" +
                "| id    | name             | population |\n" +
                "|-------|------------------|------------|\n" +
                "| 10222 | Yangon           | 25000      |\n" +
                "| 10221 | Naypyitaw        | 25000      |\n" +
                "| 12982 | Mandalay         | 34000      |\n";
        try(InputStream in = new ByteArrayInputStream(content.getBytes())) {
            List<SeedTable> tables = new MdTableParser().parseTables(in);
            assertEquals(2, tables.size());

            SeedTable table1 = tables.get(0);
            assertEquals("bank", table1.getName());
            assertEquals(2, table1.getRows().size());
            assertEquals("Bank of America", table1.getRows().get(0).getValue("full_name"));
            assertEquals("Chase", table1.getRows().get(1).getValue("full_name"));

            SeedTable table2 = tables.get(1);
            assertEquals("town", table2.getName());
            assertEquals(3, table2.getRows().size());
            assertEquals("Yangon", table2.getRows().get(0).getValue("name"));
            assertEquals("Naypyitaw", table2.getRows().get(1).getValue("name"));
        }
    }

    @Test
    public void verifyParseNullValuesCorrectly() throws Exception {
        String content =
                "### @table: bank\n" +
                        "| id    | name | short_name |\n" +
                        "|-------|------|------------|\n" +
                        "| 10222 | AAA  | aaa        |\n" +
                        "| 10223 | BBB  | NULL       |\n" +
                        "| 12982 | CCC  | null       |\n";
        try(InputStream in = new ByteArrayInputStream(content.getBytes())) {
            List<SeedTable> tables = new MdTableParser().parseTables(in);

            SeedTable table = tables.get(0);
            assertEquals("bank", table.getName());
            assertEquals(3, table.getRows().size());

            assertEquals("AAA", table.getRows().get(0).getValue("name"));
            assertEquals("aaa", table.getRows().get(0).getValue("short_name"));

            assertEquals("BBB", table.getRows().get(1).getValue("name"));
            assertNull(table.getRows().get(1).getValue("short_name"));

            assertEquals("CCC", table.getRows().get(2).getValue("name"));
            assertNull(table.getRows().get(2).getValue("short_name"));

            //assertEquals("Chase", table.getRows().get(1).getValue("full_name"));
        }
    }

    @Test
    public void verifyParseTableAndDocuments() throws Exception {
        String content = "@table: user_account\n" +
                "\n" +
                "| id      | email               | display_name     | is_system_user | is_active | get_notified |\n" +
                "|---------|---------------------|------------------|----------------|-----------|--------------|\n" +
                "| @int:u1 | user@innoveller.com | Innoveller Admin | true           | true      | false        |\n" +
                "\n" +
                "\n" +
                "\n" +
                "@json:selection-1\n" +
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
                "```\n" +
                "\n" +
                "\n" +
                "@table: town\n" +
                "\n" +
                "| id   | name_en | description_en    |\n" +
                "|------|---------|-------------------|\n" +
                "| 1200 | Yangon  | @json:selection-1 |\n";
        try (InputStream in = new ByteArrayInputStream(content.getBytes())) {
            List<String> lines = IOUtils.readLines(in, StandardCharsets.UTF_8);
            List<SeedTable> tables = new MdTableParser().parseTables(lines);
            List< SeedJsonDocument> docs = new MdJsonParser().parseJsonObjects(lines);

            assertEquals(2, tables.size());
            assertEquals(1, docs.size());
        }
    }
}

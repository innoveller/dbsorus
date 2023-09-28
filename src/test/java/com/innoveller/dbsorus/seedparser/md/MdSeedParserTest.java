package com.innoveller.dbsorus.seedparser.md;

import com.innoveller.dbsorus.models.SeedTable;
import org.junit.Test;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class MdSeedParserTest {

    @Test
    public void verifyParseSingleTableCorrectly() throws Exception {
        String content =
                "### @tbl: bank\n" +
                "| id    | full_name        | short_name |\n" +
                "|-------|------------------|------------|\n" +
                "| 10222 | Bank of America  | boa        |\n" +
                "| 12982 | Chase            | cha        |\n";
        try(InputStream in = new ByteArrayInputStream(content.getBytes())) {
            List<SeedTable> tables = new MdSeedParser().parseTables(in);

            SeedTable table = tables.get(0);
            assertEquals("bank", table.getName());
            assertEquals(2, table.getRows().size());

            assertEquals("Bank of America", table.getRows().get(0).getValue("full_name"));
            assertEquals("Chase", table.getRows().get(1).getValue("full_name"));
        }
    }

    @Test
    public void verifyParseMultipleTablesCorrectly() throws Exception {
        String content =
                "### @tbl: bank\n" +
                "| id    | full_name        | short_name |\n" +
                "|-------|------------------|------------|\n" +
                "| 10222 | Bank of America  | boa        |\n" +
                "| 12982 | Chase            | cha        |\n" +
                "### @tbl: town\n" +
                "| id    | name             | population |\n" +
                "|-------|------------------|------------|\n" +
                "| 10222 | Yangon           | 25000      |\n" +
                "\n" +
                "| 10221 | Naypyitaw        | 25000      |\n" +
                "| 12982 | Mandalay         | 34000      |\n";
        try(InputStream in = new ByteArrayInputStream(content.getBytes())) {
            List<SeedTable> tables = new MdSeedParser().parseTables(in);
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
}

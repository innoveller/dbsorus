package com.innoveller.dbsorus.models;

import org.junit.Test;

import static com.innoveller.dbsorus.models.SeedTableBuilder.integer;
import static com.innoveller.dbsorus.models.SeedTableBuilder.uuid;
import static org.junit.Assert.assertEquals;

public class SeedTableBuilderTest {

    @Test
    public void testBuildSeedTable() {
        SeedTable seedTable = SeedTableBuilder.table("movie")
                .columns("id", "imdb_id", "title", "released_date")
                .row("@int:x", "@uuid:y", "Shaw Shank Redemption", "2023-01-01")
                .row(integer("x"), uuid("1"), "Shaw Shank Redemption", "2023-01-01")
                .build();
        assertEquals("movie", seedTable.getName());

        SeedTableRow row1 = seedTable.getRows().get(0);
        assertEquals("@int:x", row1.getValue("id"));
        assertEquals("@uuid:y", row1.getValue("imdb_id"));
    }
}

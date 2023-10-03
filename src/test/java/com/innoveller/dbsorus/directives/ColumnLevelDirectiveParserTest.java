package com.innoveller.dbsorus.directives;

import org.junit.Test;

import static org.junit.Assert.*;

public class ColumnLevelDirectiveParserTest {

    @Test
    public void shouldParseUUIDDirectivesCorrectly() {
        ColumnLevelDirectiveParser parser = new ColumnLevelDirectiveParser();
        ColumnLevelDirective directive = parser.parse("@uuid:x").orElse(null);
        assertNotNull(directive);
        assertEquals(ColumnLevelDirective.DirectiveType.UUID, directive.getType());
        assertEquals("x", directive.getValue());
    }

    @Test
    public void shouldParseIntDirectivesCorrectly() {
        ColumnLevelDirectiveParser parser = new ColumnLevelDirectiveParser();
        ColumnLevelDirective directive = parser.parse("@int:x").orElse(null);
        assertNotNull(directive);
        assertEquals(ColumnLevelDirective.DirectiveType.INTEGER, directive.getType());
        assertEquals("x", directive.getValue());
    }

    @Test
    public void shouldParseDateDirectivesCorrectly() {
        ColumnLevelDirectiveParser parser = new ColumnLevelDirectiveParser();
        ColumnLevelDirective directive = parser.parse("@date:today").orElse(null);
        assertNotNull(directive);
        assertEquals(ColumnLevelDirective.DirectiveType.DATE, directive.getType());
        assertEquals("today", directive.getValue());
    }
}

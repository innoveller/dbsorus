package com.innoveller.dbsorus.expressions;

import junit.framework.TestCase;
import org.junit.Test;

import java.time.*;
import java.time.temporal.ChronoUnit;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class DateTimeExpressionParserTest {

    @Test
    public void shouldParseDateExpressionCorrectly() {
        assertEquals(LocalDate.now(), DateTimeExpressionParser.parseDate("today"));
        assertEquals(LocalDate.now().plusDays(1), DateTimeExpressionParser.parseDate("today + P1D"));
        assertEquals(LocalDate.now().minusDays(1), DateTimeExpressionParser.parseDate("today -P1D"));
        assertEquals(LocalDate.now().minusDays(100), DateTimeExpressionParser.parseDate("today - p100d"));
        assertEquals(LocalDate.now().plusDays(5), DateTimeExpressionParser.parseDate("today+p5d"));
        assertEquals(LocalDate.now().plusMonths(1).plusDays(10), DateTimeExpressionParser.parseDate("today +p1m10d"));
        assertEquals(LocalDate.now().plusYears(1).plusDays(20), DateTimeExpressionParser.parseDate("today+ P1Y20D"));
    }

    @Test
    public void shouldParseDateTimeExpressionCorrectly() {
        final int deltaSeconds = 2; // lenient seconds difference between java code executions

        assertTrue(ChronoUnit.SECONDS.between(LocalDateTime.now(),
                DateTimeExpressionParser.parseDateTime("now")) < deltaSeconds);

        assertTrue(ChronoUnit.SECONDS.between(LocalDateTime.now().plusMinutes(15),
                DateTimeExpressionParser.parseDateTime("now +PT15M")) < deltaSeconds);

        assertTrue(ChronoUnit.SECONDS.between(LocalDateTime.now().minusMinutes(10),
                DateTimeExpressionParser.parseDateTime("now -PT10M")) < deltaSeconds);

        assertTrue(ChronoUnit.SECONDS.between(LocalDateTime.now().minusDays(3).minusMinutes(20),
                DateTimeExpressionParser.parseDateTime("now - P3DT20M")) < deltaSeconds);
    }

    @Test
    public void shouldParseInstantExpressionCorrectly() {
        final int deltaSeconds = 2; // lenient seconds difference between java code executions

        assertTrue(ChronoUnit.SECONDS.between(Instant.now(),
                DateTimeExpressionParser.parseInstant("now")) < deltaSeconds);

        assertTrue(ChronoUnit.SECONDS.between(Instant.now().plus(Duration.ofMinutes(15)),
                DateTimeExpressionParser.parseInstant("now +PT15M")) < deltaSeconds);

        assertTrue(ChronoUnit.SECONDS.between(Instant.now().minus(Duration.ofMinutes(10)),
                DateTimeExpressionParser.parseInstant("now -PT10M")) < deltaSeconds);
    }
}
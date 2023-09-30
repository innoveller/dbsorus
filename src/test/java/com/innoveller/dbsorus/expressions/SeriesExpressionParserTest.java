package com.innoveller.dbsorus.expressions;

import com.innoveller.dbsorus.expressions.SeriesExpressionParser;
import org.junit.Assert;
import org.junit.Test;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class SeriesExpressionParserTest {

    @Test
    public void testCorrectlyGenerateIntegers() {
        List<String> values = SeriesExpressionParser.generateSeries("1..3");
        Assert.assertArrayEquals(new String[]{"1", "2", "3"}, values.toArray(new String[0]));
    }

    @Test
    public void testCorrectlyGenerateNegativeIntegers() {
        List<String> values = SeriesExpressionParser.generateSeries("-2..3");
        Assert.assertArrayEquals(new String[]{"-2", "-1", "0", "1", "2", "3"}, values.toArray(new String[0]));
    }

    @Test
    public void testCorrectlyGenerateDates() {
        List<String> values = SeriesExpressionParser.generateSeries("2023-01-01..2023-01-04");
        Assert.assertArrayEquals(new String[]{"2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04"}, values.toArray(new String[0]));
    }

    @Test
    public void testCorrectlyGenerateDatesAcrossMonths() {
        List<String> values = SeriesExpressionParser.generateSeries("2023-01-30..2023-02-02");
        Assert.assertArrayEquals(new String[]{"2023-01-30", "2023-01-31", "2023-02-01", "2023-02-02"}, values.toArray(new String[0]));
    }

    @Test
    public void testCorrectlyGenerateDateWithFutureDateTimeExpressions() {
        List<String> values = SeriesExpressionParser.generateSeries("today..today+P2D");
        Assert.assertArrayEquals(new String[]{
                LocalDate.now().format(DateTimeFormatter.ISO_DATE),
                LocalDate.now().plusDays(1).format(DateTimeFormatter.ISO_DATE),
                LocalDate.now().plusDays(2).format(DateTimeFormatter.ISO_DATE)
        }, values.toArray(new String[0]));
    }

    @Test
    public void testCorrectlyGenerateDateWithPastDateTimeExpressions() {
        List<String> values = SeriesExpressionParser.generateSeries("today-P1D..today+P1D");
        Assert.assertArrayEquals(new String[]{
                LocalDate.now().minusDays(1).format(DateTimeFormatter.ISO_DATE),
                LocalDate.now().format(DateTimeFormatter.ISO_DATE),
                LocalDate.now().plusDays(1).format(DateTimeFormatter.ISO_DATE)
        }, values.toArray(new String[0]));
    }
}

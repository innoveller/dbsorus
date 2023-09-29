package com.innoveller.dbsorus.seedparser.md;

import com.innoveller.dbsorus.SeriesGenerator;
import org.junit.Assert;
import org.junit.Test;

import java.util.List;

public class SeriesGeneratorTest {

    @Test
    public void testCorrectlyGenerateIntegers() {
        List<String> values = SeriesGenerator.generateSeries("1..3");
        Assert.assertArrayEquals(new String[]{"1", "2", "3"}, values.toArray(new String[0]));
    }

    @Test
    public void testCorrectlyGenerateNegativeIntegers() {
        List<String> values = SeriesGenerator.generateSeries("-2..3");
        Assert.assertArrayEquals(new String[]{"-2", "-1", "0", "1", "2", "3"}, values.toArray(new String[0]));
    }

    @Test
    public void testCorrectlyGenerateDates() {
        List<String> values = SeriesGenerator.generateSeries("2023-01-01..2023-01-04");
        Assert.assertArrayEquals(new String[]{"2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04"}, values.toArray(new String[0]));
    }

    @Test
    public void testCorrectlyGenerateDatesAcrossMonths() {
        List<String> values = SeriesGenerator.generateSeries("2023-01-30..2023-02-02");
        Assert.assertArrayEquals(new String[]{"2023-01-30", "2023-01-31", "2023-02-01", "2023-02-02"}, values.toArray(new String[0]));
    }
}

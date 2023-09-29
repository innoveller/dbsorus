package com.innoveller.dbsorus;

import com.innoveller.dbsorus.utils.DataTypeUtils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

public class SeriesGenerator {

    // https://kotlinlang.org/docs/ranges.html
    public static List<String> generateSeries(String rangeClause) {
        String[] parts = rangeClause.split("\\.\\.");
        if(parts.length == 2) {
            String fromPart = parts[0];
            String toPart = parts[1];
            if(DataTypeUtils.isNumeric(fromPart) && DataTypeUtils.isNumeric(toPart)) {
                int fromNumber = Integer.parseInt(fromPart);
                int toNumber = Integer.parseInt(toPart);
                List<String> serialValues = new ArrayList<>();
                for(int i=fromNumber; i <= toNumber; i++) {
                    serialValues.add(String.valueOf(i));
                }
                return serialValues;
            } else if(DataTypeUtils.isISODate(fromPart) && DataTypeUtils.isISODate(toPart)) {
                try {
                    LocalDate fromLocalDate = LocalDate.parse(fromPart);
                    LocalDate toLocalDate = LocalDate.parse(toPart);
                    List<String> serialValues = new ArrayList<>();
                    for (LocalDate d = fromLocalDate; !d.isAfter(toLocalDate); d = d.plusDays(1)) {
                        serialValues.add(d.format(DateTimeFormatter.ISO_DATE));
                    }
                    return serialValues;
                } catch (DateTimeParseException e) {
                    throw new RuntimeException(e.getMessage());
                }
            }
        }
        throw new RuntimeException("Invalid range format : " + rangeClause);
    }
}

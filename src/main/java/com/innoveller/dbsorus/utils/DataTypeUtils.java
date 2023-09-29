package com.innoveller.dbsorus.utils;

import java.time.LocalDate;
import java.util.regex.Pattern;

public class DataTypeUtils {
    private static final Pattern ISO_DATE_PATTERN = Pattern.compile("^\\d{4}-\\d{2}-\\d{2}$");

    public static boolean isNumeric(final String cs) {
        if (cs == null || cs.trim().isEmpty()) {
            return false;
        }
        String csWithoutSign = cs.trim().replaceFirst("-", "");
        final int sz = csWithoutSign.length();
        for (int i = 0; i < sz; i++) {
            if (!Character.isDigit(csWithoutSign.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    public static boolean isISODate(final String value) {
        return ISO_DATE_PATTERN.matcher(value).matches();
    }
}

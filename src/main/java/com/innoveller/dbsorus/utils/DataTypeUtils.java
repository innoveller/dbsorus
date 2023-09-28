package com.innoveller.dbsorus.utils;

public class DataTypeUtils {
    public static boolean isNumeric(final CharSequence cs) {
        if (cs == null) {
            return false;
        }
        if (cs.length() == 0) {
            return false;
        }
        final int sz = cs.length();
        for (int i = 0; i < sz; i++) {
            if (!Character.isDigit(cs.charAt(i))) {
                return false;
            }
        }
        return true;
    }
}

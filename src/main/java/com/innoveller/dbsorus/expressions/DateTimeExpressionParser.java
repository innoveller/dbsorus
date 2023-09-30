package com.innoveller.dbsorus.expressions;

import java.time.*;

public class DateTimeExpressionParser {
    public static final String TERM_TODAY = "today";
    public static final String TERM_NOW = "now";

    /**
     *  Supports https://en.wikipedia.org/wiki/ISO_8601#Durations
     *  For example, the following are valid inputs:
     *
     *    "P2Y"             -- Period.ofYears(2)
     *    "P3M"             -- Period.ofMonths(3)
     *    "P4W"             -- Period.ofWeeks(4)
     *    "P5D"             -- Period.ofDays(5)
     *    "P1Y2M3D"         -- Period.of(1, 2, 3)
     *    "P1Y2M3W4D"       -- Period.of(1, 2, 25)
     *    "P-1Y2M"          -- Period.of(-1, 2, 0)
     *    "-P1Y2M"          -- Period.of(-1, -2, 0)
     *
     * @param expression
     * @return
     */
    public static LocalDate parseDate(String expression) {
        if(expression.contains(TERM_TODAY)) {
            if(expression.contains("+") || expression.contains("-")) {
                String periodPart = expression
                        .replace(TERM_TODAY, "")
                        .replace("+", "")
                        .replace(" ", "")
                        .trim();
                System.out.println(periodPart);
                return LocalDate.now().plus(Period.parse(periodPart));
            } else {
                return LocalDate.now();
            }

            /*if(expression.contains("+")) {
                String periodPart = expression.substring(expression.indexOf("+") + 1).replace(" ", "");
                return LocalDate.now().plus(Period.parse(periodPart));
            } else if(expression.contains("-")) {
                String periodPart = expression.substring(expression.indexOf("-")).replace(" ", "");
                return LocalDate.now().minus(Period.parse(periodPart.trim()));
            } else {
                return LocalDate.now();
            }*/
        }
        throw new RuntimeException("Unsupported date expression: " + expression);
    }

    /**
     *  Supports https://en.wikipedia.org/wiki/ISO_8601#Durations
     *  Examples:
     *
     *     "PT20.345S" -- parses as "20.345 seconds"
     *     "PT15M"     -- parses as "15 minutes" (where a minute is 60 seconds)
     *     "PT10H"     -- parses as "10 hours" (where an hour is 3600 seconds)
     *     "P2D"       -- parses as "2 days" (where a day is 24 hours or 86400 seconds)
     *     "P2DT3H4M"  -- parses as "2 days, 3 hours and 4 minutes"
     *
     * @param expression
     * @return
     */
    public static LocalDateTime parseDateTime(String expression) {
        if(expression.contains(TERM_NOW)) {
            if(expression.contains("+") || expression.contains("-")) {
                String durationPart = expression
                        .replace(TERM_NOW, "")
                        .replace("+", "")
                        .replace(" ", "")
                        .trim();
                //System.out.println(periodPart);
                return LocalDateTime.now().plus(Duration.parse(durationPart));
            } else {
                return LocalDateTime.now();
            }
        }
        throw new RuntimeException("Unsupported date time expression: " + expression);
    }

    public static Instant parseInstant(String expression) {
        if(expression.contains(TERM_NOW)) {
            if(expression.contains("+") || expression.contains("-")) {
                String durationPart = expression
                        .replace(TERM_NOW, "")
                        .replace("+", "")
                        .replace(" ", "")
                        .trim();
                //System.out.println(periodPart);
                return Instant.now().plus(Duration.parse(durationPart));
            } else {
                return Instant.now();
            }
        }
        throw new RuntimeException("Unsupported date time expression: " + expression);
    }
}

package com.innoveller.dbsorus.directives;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DirectiveExpressionExtractor {

    public List<String> extractDirectiveExpressions(String text) {
        String patternString = "@[\\w]*[\\s]*:[\\s]*[\\w\\+\\-.]+";
        Pattern pattern = Pattern.compile(patternString);

        List<String> directiveExpressions = new ArrayList<>();

        Matcher m = pattern.matcher(text);
        while (m.find()) {
            directiveExpressions.add(m.group());
        }
        return directiveExpressions;
    }
}

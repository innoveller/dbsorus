package com.innoveller.dbsorus.directives;

import java.util.Optional;

public class ColumnLevelDirectiveParser {
    public Optional<ColumnLevelDirective> parse(String value) {
        //System.out.println("Parsing: " + value);
        if(value != null && value.trim().startsWith("@") && value.contains(":")) {
            int indexOfFirstColon = value.trim().indexOf(":");
            String directiveCommand = value.trim().substring(0, indexOfFirstColon).trim().replace("@", "");
            //System.out.println("Command:" + directiveCommand);
            ColumnLevelDirective.DirectiveType type = getDirectiveType(directiveCommand);
            if(type != null) {
                String directiveValue = value.trim().substring(indexOfFirstColon + 1)
                        .trim().replace(String.valueOf(Character.SPACE_SEPARATOR), "");
                //System.out.println("Value: " + directiveValue);
                return Optional.of(new ColumnLevelDirective(type, directiveValue));
            }
        }
        return Optional.empty();
    }

    private static ColumnLevelDirective.DirectiveType getDirectiveType(String directiveCommand) {
        if(directiveCommand.equalsIgnoreCase("uuid")) {
            return ColumnLevelDirective.DirectiveType.UUID;
        } else if(directiveCommand.equalsIgnoreCase("int") || directiveCommand.equalsIgnoreCase("integer")) {
            return ColumnLevelDirective.DirectiveType.INTEGER;
        } else if(directiveCommand.equalsIgnoreCase("date")) {
            return ColumnLevelDirective.DirectiveType.DATE;
        } else if(directiveCommand.equalsIgnoreCase("datetime")) {
            return ColumnLevelDirective.DirectiveType.DATETIME;
        } else if(directiveCommand.equalsIgnoreCase("instant")) {
            return ColumnLevelDirective.DirectiveType.INSTANT;
        } else if(directiveCommand.equalsIgnoreCase("json")) {
            return ColumnLevelDirective.DirectiveType.JSON;
        } else {
            return null;
        }
    }
}

package com.innoveller.dbsorus.directives;

public class ColumnLevelDirective {
    public enum DirectiveType {
        UUID, INTEGER, DATE, DATETIME, INSTANT, JSON
    }

    private final DirectiveType type;
    private final String value;

    public ColumnLevelDirective(DirectiveType type, String value) {
        this.type = type;
        this.value = value;
    }

    public DirectiveType getType() {
        return type;
    }

    public String getValue() {
        return value;
    }
}

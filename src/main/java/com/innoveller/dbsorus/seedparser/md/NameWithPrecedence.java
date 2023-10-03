package com.innoveller.dbsorus.seedparser.md;

import java.util.Objects;

public class NameWithPrecedence {
    private final String name;
    private final int precedence;

    public NameWithPrecedence(String name, int precedence) {
        this.name = name;
        this.precedence = precedence;
    }

    public String getName() {
        return name;
    }

    public int getPrecedence() {
        return precedence;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NameWithPrecedence that = (NameWithPrecedence) o;
        return Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }
}

package com.innoveller.dbsorus.models;

public class PgTableColumnJavaDataType {
    private final Class<?> classType;
    private final Object defaultValue;

    public PgTableColumnJavaDataType(Class<?> classType, Object defaultValue) {
        this.classType = classType;
        this.defaultValue = defaultValue;
    }

    public Class<?> getClassType() {
        return classType;
    }

    public Object getDefaultValue() {
        return defaultValue;
    }
}

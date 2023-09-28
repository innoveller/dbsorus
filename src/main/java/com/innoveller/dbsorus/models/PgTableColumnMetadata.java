package com.innoveller.dbsorus.models;

import java.util.Optional;

public class PgTableColumnMetadata {
    private final String name;
    private final int dataTypeCode;

    private final boolean isPrimaryKey;
    private final PgTableColumnJavaDataType javaDataType;

    public PgTableColumnMetadata(String name, int dataTypeCode, boolean isPrimaryKey, PgTableColumnJavaDataType javaDataType) {
        this.name = name;
        this.dataTypeCode = dataTypeCode;
        this.isPrimaryKey = isPrimaryKey;
        this.javaDataType = javaDataType;
    }

    public String getName() {
        return name;
    }

    public int getDataTypeCode() {
        return dataTypeCode;
    }

    public boolean isPrimaryKey() {
        return isPrimaryKey;
    }

    public Optional<PgTableColumnJavaDataType> getJavaDataType() {
        return Optional.ofNullable(javaDataType);
    }
}

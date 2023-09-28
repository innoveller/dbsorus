package com.innoveller.dbsorus.models;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

public class PgTableMetadata {
    private final String tableName;
    private final Set<String> primaryKeys;
    private final Collection<PgTableColumnMetadata> columns;

    public PgTableMetadata(String tableName, Collection<PgTableColumnMetadata> columns, Set<String> primaryKeys) {
        this.tableName = tableName;
        this.primaryKeys = primaryKeys;
        this.columns = columns;
    }

    public String getTableName() {
        return tableName;
    }

    public Set<String> getPrimaryKeys() {
        return primaryKeys;
    }

    public List<PgTableColumnMetadata> getColumns() {
        return new ArrayList<>(columns);
    }
}

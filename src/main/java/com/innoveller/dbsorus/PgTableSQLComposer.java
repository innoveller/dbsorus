package com.innoveller.dbsorus;

import com.innoveller.dbsorus.models.PgTableColumnJavaDataType;
import com.innoveller.dbsorus.models.PgTableColumnMetadata;
import com.innoveller.dbsorus.models.PgTableMetadata;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

public class PgTableSQLComposer {

    public static String composeInsertStatement(PgTableMetadata metadata, Map<String, ? extends Object> givenRowData) throws Exception {
        List<PgTableColumnMetadata> sortedColumns =
                metadata.getColumns().stream()
                        .sorted((a, b) -> (a.isPrimaryKey() == b.isPrimaryKey()) ? 0 : (a.isPrimaryKey() ? -1 : 1))
                        .collect(Collectors.toList());

        Map<String, String> finalInsertingKeyValueMap = new LinkedHashMap<>();

        for(PgTableColumnMetadata columnMetadata: sortedColumns) {
            Optional<PgTableColumnJavaDataType> javaDataTypeOptional = columnMetadata.getJavaDataType();
            if(javaDataTypeOptional.isPresent()) {
                Object columnValue = givenRowData.containsKey(columnMetadata.getName())?
                        givenRowData.get(columnMetadata.getName()) : javaDataTypeOptional.get().getDefaultValue();
                finalInsertingKeyValueMap.put(columnMetadata.getName(), toSqlInsertValue(columnValue));
            } else {
                throw new Exception("Given data type (" + columnMetadata.getDataTypeCode() + ") for " +
                        columnMetadata.getName() + " in table (" + metadata.getTableName() + ") is not supported");
            }
        }

        String columnNameCsv = String.join(", ", finalInsertingKeyValueMap.keySet());
        String columnValueCsv = String.join(", ", finalInsertingKeyValueMap.values());

        return "INSERT INTO " + metadata.getTableName() + " (" + columnNameCsv + ") \nVALUES (" + columnValueCsv + ");";
    }

    private static String toSqlInsertValue(Object columnValue) {
        if(columnValue != null) {
            return (columnValue instanceof Number)?
                    columnValue.toString() : "'" + columnValue.toString() + "'";
        } else {
            return null;
        }
    }
}

package com.innoveller.dbsorus;

import com.innoveller.dbsorus.models.PgTableColumnJavaDataType;
import com.innoveller.dbsorus.models.PgTableColumnMetadata;
import com.innoveller.dbsorus.models.PgTableMetadata;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class PgTableInspector {
    static Map<Integer, PgTableColumnJavaDataType> typeToDefaultValueMap = new HashMap<>();
    static {
        // https://postgrespro.com/list/thread-id/1936959

        typeToDefaultValueMap.put(1, ofType(Integer.class, 0));
        typeToDefaultValueMap.put(2, ofType(Integer.class, 0));
        typeToDefaultValueMap.put(3, ofType(Integer.class, 0));
        typeToDefaultValueMap.put(4, ofType(Integer.class, 0));
        typeToDefaultValueMap.put(5, ofType(Double.class, 0.0));
        typeToDefaultValueMap.put(6, ofType(Double.class, 0.0));
        typeToDefaultValueMap.put(7, ofType(Float.class, 0.0f));
        typeToDefaultValueMap.put(8, ofType(Double.class, 0.0));
        typeToDefaultValueMap.put(9, ofType(Integer.class, 0));
        typeToDefaultValueMap.put(10, ofType(Double.class, 0.0));
        typeToDefaultValueMap.put(11, ofType(String.class, ""));
        typeToDefaultValueMap.put(12, ofType(String.class, ""));
        typeToDefaultValueMap.put(13, ofType(String.class, ""));
        typeToDefaultValueMap.put(14, ofType(Byte.class, Integer.valueOf(0).byteValue()));
        typeToDefaultValueMap.put(15, ofType(LocalDate.class, LocalDate.now().format(DateTimeFormatter.ISO_DATE)));
        typeToDefaultValueMap.put(16, ofType(LocalTime.class, LocalTime.now().format(DateTimeFormatter.ISO_LOCAL_TIME)));
        typeToDefaultValueMap.put(17, ofType(LocalTime.class, LocalTime.now().format(DateTimeFormatter.ISO_LOCAL_TIME)));
        typeToDefaultValueMap.put(18, ofType(Instant.class, Instant.now()));
        typeToDefaultValueMap.put(19, ofType(Instant.class, Instant.now()));
        typeToDefaultValueMap.put(20, ofType(Boolean.class, false));

        typeToDefaultValueMap.put(-7, ofType(Boolean.class, false));
        typeToDefaultValueMap.put(1111, ofType(UUID.class, UUID.randomUUID()));
        typeToDefaultValueMap.put(2003, ofType(String[].class, "{}"));
        typeToDefaultValueMap.put(91, ofType(LocalDate.class, LocalDate.now().format(DateTimeFormatter.ISO_DATE)));
        typeToDefaultValueMap.put(93, ofType(Instant.class, Instant.now()));
    }

    private static PgTableColumnJavaDataType ofType(Class<?> classType, Object defaultValue) {
        return new PgTableColumnJavaDataType(classType, defaultValue);
    }

    public static Optional<PgTableColumnJavaDataType> findDefaultValueByPgDataTypeCode(int code) {
        PgTableColumnJavaDataType pgDataTypeDefaultValue = typeToDefaultValueMap.get(code);
        if(pgDataTypeDefaultValue != null) {
            return Optional.of(pgDataTypeDefaultValue);
        }
        return Optional.empty();
    }

    public static PgTableMetadata inspectTable(Connection conn, String tableName) throws Exception {
        DatabaseMetaData databaseMetaData = conn.getMetaData();
        Set<String> primaryKeys = new HashSet<>();
        Map<String, PgTableColumnMetadata> columnMap = new HashMap<>();

        try(ResultSet primaryKeyResultSet = databaseMetaData.getPrimaryKeys(null, null, tableName)) {
            while(primaryKeyResultSet.next()) {
                String columnName = primaryKeyResultSet.getString("COLUMN_NAME");
                String primaryKeyName = primaryKeyResultSet.getString("PK_NAME");
                primaryKeys.add(columnName);
            }
        }

        try(ResultSet columns = databaseMetaData.getColumns(null,null, tableName, null)) {
            while (columns.next()) {
                String columnName = columns.getString("COLUMN_NAME");
                String columnSize = columns.getString("COLUMN_SIZE");
                String dataType = columns.getString("DATA_TYPE");
                String isNullable = columns.getString("IS_NULLABLE");
                String isAutoIncrement = columns.getString("IS_AUTOINCREMENT");

                Optional<PgTableColumnJavaDataType> pgDataTypeDefaultValueOptional =
                        PgTableInspector.findDefaultValueByPgDataTypeCode(Integer.parseInt(dataType));
                if(pgDataTypeDefaultValueOptional.isPresent()) {
                    PgTableColumnJavaDataType javaDataType = pgDataTypeDefaultValueOptional.get();
                    boolean isPrimaryKey = primaryKeys.contains(columnName);
                    PgTableColumnMetadata columnMetadata =
                            new PgTableColumnMetadata(columnName, Integer.parseInt(dataType), isPrimaryKey, javaDataType);
                    columnMap.put(columnName, columnMetadata);
                } else {
                    throw new Exception("Could not find java data type for " + tableName + "." + columnName + " of type (" + dataType + ")");
                }
            }
        }
        return new PgTableMetadata(tableName, columnMap.values(), primaryKeys);
    }
}

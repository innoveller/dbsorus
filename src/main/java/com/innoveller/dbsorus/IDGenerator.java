package com.innoveller.dbsorus;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

public class IDGenerator {
    private final Map<String, UUID> uuidMap = new HashMap<>();
    private final Map<String, Integer> integerMap = new HashMap<>();

    public UUID getOrGenerateUUID(String key) {
        if(uuidMap.containsKey(key)) {
            return uuidMap.get(key);
        } else {
            UUID uuid = UUID.randomUUID();
            uuidMap.put(key, uuid);
            return uuid;
        }
    }

    public Optional<UUID> retrieveGeneratedUUID(String key) {
        if(uuidMap.containsKey(key)) {
            return Optional.of(uuidMap.get(key));
        } else {
            return Optional.empty();
        }
    }

    public Integer getOrGenerateInteger(String key) {
        if(integerMap.containsKey(key)) {
            return integerMap.get(key);
        } else {
            Integer intValue = Double.valueOf(Math.random() * Integer.MAX_VALUE).intValue();
            integerMap.put(key, intValue);
            return intValue;
        }
    }

    public Optional<Integer> retrieveGeneratedInteger(String key) {
        if(integerMap.containsKey(key)) {
            return Optional.of(integerMap.get(key));
        } else {
            return Optional.empty();
        }
    }
}

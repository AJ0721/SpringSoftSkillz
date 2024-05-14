package com.softskillz.studentreservation.model;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonUtil {
    private static ObjectMapper objectMapper = new ObjectMapper();

    public static List<String> parseTimeSlots(String jsonTimeSlots) throws IOException {
        return objectMapper.readValue(jsonTimeSlots, new TypeReference<List<String>>() {});
    }
}

package com.innoveller.dbsorus.utils;

import java.io.*;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class IOUtils {
    public static List<String> readLines(InputStream input, Charset charset) throws IOException {
        final InputStreamReader reader = new InputStreamReader(input, charset);
        return readLines(reader);
    }

    public static List<String> readLines(final Reader input) throws IOException {
        final BufferedReader reader = toBufferedReader(input);
        final List<String> list = new ArrayList<>();
        String line = reader.readLine();
        while (line != null) {
            list.add(line);
            line = reader.readLine();
        }
        return list;
    }

    public static BufferedReader toBufferedReader(final Reader reader) {
        return reader instanceof BufferedReader ? (BufferedReader) reader : new BufferedReader(reader);
    }
}

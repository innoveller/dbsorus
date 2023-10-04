package com.innoveller.dbsorus.directives;

import org.junit.Assert;
import org.junit.Test;

import java.util.List;

public class DirectiveExpressionExtractorTest {

    @Test
    public void extractDirectivesFromArray() {
        DirectiveExpressionExtractor extractor = new DirectiveExpressionExtractor();
        List<String> expressions = extractor.extractDirectiveExpressions("{@uuid:x,@uuid:y}");
        Assert.assertEquals(expressions.get(0), "@uuid:x");
        Assert.assertEquals(expressions.get(1), "@uuid:y");
    }

    @Test
    public void extractDirectivesFromJson() {
        DirectiveExpressionExtractor extractor = new DirectiveExpressionExtractor();
        List<String> expressions = extractor.extractDirectiveExpressions(
                "{\n" +
                "        \"id\": \"@uuid:order-1\",\n" +
                "        \"name\": \"main_window\",\n" +
                "        \"due_date\": \"@date:today+P1D\",\n" +
                "        \"created_at\": \"@instant:now\"\n" +
                "    }");
        Assert.assertEquals(expressions.get(0), "@uuid:order-1");
        Assert.assertEquals(expressions.get(1), "@date:today+P1D");
        Assert.assertEquals(expressions.get(2), "@instant:now");
    }
}
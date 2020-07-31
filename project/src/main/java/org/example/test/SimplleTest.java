package org.example.test;

import org.junit.Test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SimplleTest {

    @Test
    public void testRegexp() {
        Pattern p = Pattern.compile("q(\\d+)-title");
        Matcher m = p.matcher("q1-title");
        m.find();
        System.out.println(m.group(1));
    }

    @Test
    public void testRegexp2() {

        Pattern pattern = Pattern.compile("q(\\d+)-title");
        Matcher matcher = pattern.matcher("q1-title");
        while (matcher.find()){
            System.out.println(matcher.group(1));
        }
    }

}

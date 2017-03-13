package eu.clarin.cmdi.vlo.mappings;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.regex.Pattern;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import static org.junit.Assert.*;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import org.reflections.Reflections;
import org.reflections.scanners.ResourcesScanner;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

/**
 * Tests the XML syntax for all uniform mapping definition files
 *
 * @author twagoo
 */
@RunWith(Parameterized.class)
public class MappingSyntaxTest {

    private static DocumentBuilderFactory dbFactory;
    private final String mappingResource;

    public MappingSyntaxTest(String mappingResource) {
        // class will be constructed once for each XML resource from the array constructed in the data() method
        this.mappingResource = mappingResource;
    }

    @Test
    public void validateMapping() throws SAXException, IOException, ParserConfigurationException {
        System.out.println("\nChecking XML resource " + mappingResource);
        final InputStream resourceStream = getClass().getClassLoader().getResourceAsStream(mappingResource);
        assertNotNull("Resource " + mappingResource + " should exist", resourceStream);
        try {
            final Document document = dbFactory.newDocumentBuilder().parse(resourceStream);
            assertNotNull("Parse result should not be null", document);
            System.out.println("Document " + mappingResource + " parsed successfully");
        } catch (SAXException ex) {
            ex.printStackTrace(System.out);
            fail("Failed to parse " + mappingResource + ": " + ex.getMessage());
        }
    }

    @Parameters
    public static Object[] data() {
        // use reflection to collect all XML resources
        final Reflections reflections = new Reflections("", new ResourcesScanner());

        // return an array of XML resources, i.e. the files that we want to validate
        final Object[] resources = reflections.getResources(Pattern.compile(".*\\.xml")).toArray();

        System.out.println("Files that will be tested: " + Arrays.toString(resources));
        return resources;
    }

    @BeforeClass
    public static void setupClass() {
        dbFactory = DocumentBuilderFactory.newInstance();
        dbFactory.setValidating(false);
        dbFactory.setNamespaceAware(false);
    }

}

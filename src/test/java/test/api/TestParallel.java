package test.api;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class TestParallel {

	@Test
	public void testParallel() {
// 		System.setProperty("mock.env", "karateTesting"); // ensure reset if other tests (e.g. mock) had set env in CI
		String tags = "@TEKInsuranceCompleteTest";
		Results results = Runner.builder().outputCucumberJson(true).path("classpath:features").tags(tags).parallel(1);
		generateReport(results.getReportDir());
		assertEquals(0, results.getFailCount(), results.getErrorMessages());
	}

	public static void generateReport(String karateOutputPath) {
		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
		List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		Configuration config = new Configuration(new File("target"), "karateTesting");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}
}

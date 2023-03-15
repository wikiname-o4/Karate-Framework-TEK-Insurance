package test.api;

import com.intuit.karate.Results;
import com.intuit.karate.junit5.Karate;

public class TestRunner {

	@Karate.Test
	public Results runTest() {
		return Karate.run("classpath:features").tags("@TEKInsuranceCompleteTest").reportDir("target/surefire-reports").parallel(1);
	}
	
}

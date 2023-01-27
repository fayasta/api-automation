package collections.pa_automation;

import com.intuit.karate.junit5.Karate;

public class PAAutomationRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("pa_automation").relativeTo(getClass());
    }    
}

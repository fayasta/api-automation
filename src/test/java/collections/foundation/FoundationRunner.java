package collections.foundation;

import com.intuit.karate.junit5.Karate;

class FoundationRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("foundation").relativeTo(getClass());
    }    
}

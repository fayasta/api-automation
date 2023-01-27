package collections.seeqer;

import com.intuit.karate.junit5.Karate;

class SeeqerRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("seeqer").relativeTo(getClass());
    }    

}

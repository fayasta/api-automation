package collections.portal;

import com.intuit.karate.junit5.Karate;

class PortalRuner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("portal").relativeTo(getClass());
    }    
}

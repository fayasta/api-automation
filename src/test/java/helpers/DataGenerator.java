package helpers;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.concurrent.TimeUnit;
import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {

    private final static String TIME_ZONE_ID = "America/New_York";
    
    public static String getRandomEmail(){
        Faker faker = new Faker();
        return faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "@email.com";
    }

    public static String getRandomUsername(){
        Faker faker = new Faker();
        return faker.name().username();
    }

    //Example when a JSON object is necessary
    public static JSONObject getRandomArticleInfo(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().house();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }

    public static String getRandomDate(){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
        Faker faker = new Faker();
        String nowAsISO = df.format(faker.date().past(2,1, TimeUnit.DAYS));
        return nowAsISO+getTimeZone(TIME_ZONE_ID); 
    }

    private static String getTimeZone(String timeZoneId){
        LocalDateTime dt = LocalDateTime.now();
        ZoneId zone = ZoneId.of(timeZoneId);
        ZonedDateTime zdt = dt.atZone(zone);
        ZoneOffset offset = zdt.getOffset();
        return offset.toString();
    }

    public static int getRandomLaborOrderId(){
        Faker faker = new Faker();
        return faker.number().numberBetween(1000,9999);
    }
}

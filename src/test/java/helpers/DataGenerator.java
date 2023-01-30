package helpers;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;
import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {
    
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
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        Faker faker = new Faker();
        String nowAsISO = df.format(faker.date().past(2,1, TimeUnit.DAYS));
        //in case we need to send a date before current date - change to: yyyy-MM-dd'T'00:00:00.000-00:00'Z'"
        return nowAsISO;
    }

    public static int getRandomLaborOrderId(){
        Faker faker = new Faker();
        return faker.number().numberBetween(1000,9999);
    }
}

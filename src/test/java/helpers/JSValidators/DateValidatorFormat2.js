function fn(dateString) {
    // var SimpleDateFormat = Java.type("java.text.SimpleDateFormat");
    // var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX")
    // try{
    //     sdf.parse(s).time;
    //     return true;
    // }catch(e){
    //     karate.log('***** invalid date string', s);
    //     return false;
    // }
    var dateFormat = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}[+-]\d{2}:\d{2}$/;
    if (dateFormat.test(dateString)) {
        return true;
      } else {
        return false;
      } 
}
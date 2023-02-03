// function fn(dateString) {
//     var sub_date_string = dateString.replace('-05:00','');
//     var dateFormat = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}[+-]\d{2}:\d{2}/;
//     if (dateFormat.test(dateString)) {
//         return true;
//       } else {
//         return false;
//       } 
// }

function fn(s) {
  var dateFormat = /\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])/;
  var subDate = s.match(dateFormat)[0];
  var SimpleDateFormat = Java.type("java.text.SimpleDateFormat");
  var sdf = new SimpleDateFormat("yyyy-MM-dd")
  try{
      sdf.parse(subDate).time;
      karate.log('***** valid date string', s);
      return true;
  }catch(e){
      karate.log('***** invalid date string', s);
      return false;
  }
}
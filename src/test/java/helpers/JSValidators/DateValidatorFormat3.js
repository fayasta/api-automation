function fn(dateString) {
    var dateFormat = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}[+-]\d{2}:\d{2}$/;
    if (dateFormat.test(dateString)) {
        return true;
      } else {
        return false;
      } 
}
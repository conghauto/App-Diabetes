class FormatDateTime{
  static String formatDay(int d){
    if(d<10){
      return "0"+d.toString();
    }
    return d.toString();
  }

  static String formatMinute(int m){
    if(m<10){
      return "0"+m.toString();
    }
    return m.toString();
  }

  static String formatHour(int h){
    if(h<10){
      return "0"+h.toString();
    }
    return h.toString();
  }

  static String convertDayOfWeek(int i) {
    String s = "Th 2";
    switch(i){
      case 1:{
        s = "Th 2";
      }
      break;
      case 2:{
        s = "Th 3";
      }
      break;
      case 3:{
        s = "Th 4";
      }
      break;
      case 4:{
        s = "Th 5";
      }
      break;
      case 5:{
        s = "Th 6";
      }
      break;
      case 6:{
        s = "Th 7";
      }
      break;
      case 1:{
        s = "CN";
      }
      break;
      default:{
        s = "CN";
      }
    }

    return s;
  }
}
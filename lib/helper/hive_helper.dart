
import 'package:hive/hive.dart';

class HiveHelper{

  static const  boxTaken="boxTaken";
  static const  keyTaken="keyTaken";

  static const  boxEmail="boxEmail";
  static const  keyEmail="keyEmail";

  static const  boxcart="boxcart";
  static const  keycart="keycart";


 static void setToken(String token)async{
   await Hive.box(boxTaken).put(keyTaken, token);
  }

  static String getToken() {
    if(Hive.box(boxTaken).isNotEmpty){
     return  Hive.box(boxTaken).get(keyTaken);
    }else{
      return "";
    }
  }

  static void removeToken()async{
    await Hive.box(boxTaken).delete(keyTaken);
  }

  static Future<void> setEmail(String? email) async {
    final box = Hive.box(boxEmail);
    await box.put(keyEmail, email);
  }

  static String getEmail() {
    final box = Hive.box(boxEmail);
    return box.get(keyEmail, defaultValue: "") ?? "";
  }






}
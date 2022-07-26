
import 'package:shared_preferences/shared_preferences.dart';


class CashHelper{
   static late  SharedPreferences sharedPreferences;

  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  static Future<bool> putData(String key,bool value)async{
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getData(String key)  {
      if(sharedPreferences ==null){}
      else{return sharedPreferences.get(key);}


  }

  static Future<bool> saveData(String key,dynamic value) async
  {
    if(value is int) {
      return await sharedPreferences.setInt(key, value) ;
    } else if(value is String) {
      return await sharedPreferences.setString(key, value) ;
    } else if(value is bool) {
      return await sharedPreferences.setBool(key, value) ;
    } else {
      return await sharedPreferences.setDouble(key, value) ;
    }

  }

  Future<bool> clearData(String key) async
  {
    return await sharedPreferences.remove(key);
  }



}

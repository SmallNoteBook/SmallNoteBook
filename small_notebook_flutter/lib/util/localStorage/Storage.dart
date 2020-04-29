import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static Future set(String key, dynamic value) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is String) {
       prefs.setString(key, value);

    } else if (value is int) {
       prefs.setInt(key, value);

    } else if (value is bool) {
       prefs.setBool(key, value);

    } else if (value is double) {
       prefs.setDouble(key, value);

    }else if((value is Map)||(value is List) ){
       prefs.setString(key, jsonEncode(value));

    }
  }


  static Future get (String key) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
     return _prefs.get(key);
  }

  static Future getJson (String key) async{

    SharedPreferences _prefs = await SharedPreferences.getInstance();

    return jsonDecode(_prefs.get(key)??'[]') ;
  }
}

import 'dart:convert';

import 'package:animal_safer_game/ob/player_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharePref{


  // Save Data
  static saveData(String key,PlayerData value)async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print("Saving....");
    _pref.setString(key, json.encode(value));
  }

  // Get Data
  static getData(String key)async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print("Getting....");
    return json.decode(_pref.getString(key)!);
  }
}
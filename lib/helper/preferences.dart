import 'package:shared_preferences/shared_preferences.dart';

enum UserPref {
  authToken,
}

class SharedPreferencesHelper {
  Future<bool> setAuthToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(UserPref.authToken.toString(), token);
  }

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(UserPref.authToken.toString());
  }

  Future<bool> removeAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(UserPref.authToken.toString());
  }
  // static shared_preferences.SharedPreferences? _pref;
  // static preferencesInstance() async {
  //   _pref = await shared_preferences.SharedPreferences.getInstance();
  // }

  // static setUserIdPreferences({String? id}) async {
  //   await _pref!.setString("id", id!);
  // }

  // static setEmailPreferences({String? email}) async {
  //   await _pref!.setString("email", email!);
  // }

  // static setNamePreferences({String? name}) async {
  //   await _pref!.setString("name", name!);
  // }

  // static String? get getUserIdPreferences {
  //   return _pref!.getString("id");
  // }

  // static String? get getEmailPreferences {
  //   return _pref!.getString("email");
  // }

  // static String? get getNamePreferences {
  //   return _pref!.getString("name");
  // }
}

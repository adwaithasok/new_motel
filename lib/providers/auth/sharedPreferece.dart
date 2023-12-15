import 'package:flutter/material.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/modules/login/sign_up_Screen.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String tokenKey = 'user_token';
  static const String useridkey = 'user_id'; // Use a suitable string as the key
  // Replace 42 with the actual user ID or another suitable value

  // static Future<bool> isFirstlogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  //   return isFirstLaunch;
  // }
  static const String isFirstLaunchKey = 'isFirstLaunch';

  static Future<bool> isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isFirstLaunch = prefs.getBool(isFirstLaunchKey);

    // If isFirstLaunch is null, it means the key is not set.
    // In that case, consider it as the first launch.
    return isFirstLaunch ?? true;
  }

  static Future<void> setFirstLaunch(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isFirstLaunchKey, value);
  }

  // Save token to SharedPreferences
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  } // Save userid to SharedPreferences

  static Future<void> saveUserId(int userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(useridkey, userid.toString());
    print('useridkey' '${userid}');
  } // Get user ID from SharedPreferences

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(useridkey);
  }

  // Get token from SharedPreferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // Check if the user is logged in
  static Future<bool> isLoggedIn() async {
    String? token = await getToken();
    print(token);

    return token != null;
  }

  // Remove token from SharedPreferences (logout)
  static Future<void> logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(useridkey);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => SignUpScreen()));

    // NavigationServices(context).gotoSignScreen();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.primaryColor,
        content: Text("User Logged out sucsessfully"),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

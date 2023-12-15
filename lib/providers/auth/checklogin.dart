import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/providers/auth/sharedPreferece.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLoginProvider extends ChangeNotifier {
  Future<void> checkLoggedIn(context) async {
    // Check if the user is logged in
    bool isLoggedIn = await SharedPreferencesHelper.isLoggedIn();

    if (isLoggedIn) {
      const String apiUrl =
          'https://posmab.com/project/booking/api/check-logged-in';

      // Retrieve the saved token from SharedPreferences
      String? token = await SharedPreferencesHelper.getToken();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.redErrorColor,
            content: Text('Authentication error. Please log in again.'),
            duration: Duration(seconds: 5),
          ),
        );
        // Redirect to the login screen
        NavigationServices(context).gotoLoginScreen();
        return;
      }

      // Prepare headers with the token
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      print(headers);

      try {
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: headers,
        );

        if (response.statusCode == 200) {
          handleCheckLoggedInSuccess(response);
        } else {
          handleCheckLoggedInFailure(response, context);
        }
      } catch (e) {
        print('Error during API call: $e');
      }
    } else {
      // User is not logged in, handle accordingly (maybe redirect to login screen)
      print('User is not logged in');
      // You can navigate to the login screen or perform other actions here
    }
  }

  void handleCheckLoggedInSuccess(http.Response response) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    print('Success message: ${jsonData['success']}');
    // Handle success response as needed
    // You can parse the response and perform actions based on it
  }

  void handleCheckLoggedInFailure(http.Response response, context) {
    try {
      final Map<String, dynamic> errorBody = json.decode(response.body);
      print('Error message: ${errorBody['error']}');
      // Handle failure response as needed
      // You can parse the response and perform actions based on it
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.primaryColor,
          content: Text(errorBody['error']),
          duration: Duration(seconds: 5), // Adjust duration as needed
        ),
      );
    } catch (e) {
      print('Error during API call: $e');
    }
  }
}

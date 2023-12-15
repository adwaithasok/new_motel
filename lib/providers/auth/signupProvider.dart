import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/providers/auth/sharedPreferece.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupProvider extends ChangeNotifier {
  bool isLoading = false;
  late String tempToken;
  var emailErrorMessage;
  var phoneErrorMessage;
  var nameErrorMessage;
  var mobilenumber;
  Future<void> signupUser(
    String firstName,
    String email,
    String phone,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    resetErrorMessages();

    final Map<String, dynamic> requestBody = {
      'name': firstName,
      'email': email,
      'phone': phone,
    };

    const String apiUrl = 'https://posmab.com/project/booking/api/register';

    try {
      final startTime = DateTime.now();
      final response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );
      final endTime = DateTime.now();
      print('Time taken: ${endTime.difference(startTime).inMilliseconds}ms');

      if (response.statusCode == 200) {
        tempToken = json.decode(response.body)['temporary_token'];
        print('Registration successful: $tempToken');
        NavigationServices(context).gotoOtpValidationScreen(this);
      } else if (response.statusCode == 403) {
        handleValidationErrors(response);
      } else {
        handleOtherErrors(response);
      }
    } catch (e) {
      print('Error during registration: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void handleValidationErrors(http.Response response) {
    final Map<String, dynamic> errorBody = json.decode(response.body);
    final List<dynamic> errors = errorBody['errors'];

    for (dynamic error in errors) {
      final String errorCode = error['code'];
      final String errorMessage = error['message'];

      switch (errorCode) {
        case 'email':
          emailErrorMessage = errorMessage;
          break;
        case 'phone':
          phoneErrorMessage = errorMessage;
          break;
        case 'name':
          nameErrorMessage = errorMessage;
          break;
        // Add more cases as needed
      }
    }

    notifyListeners();
    print('Error during registration: ${response.statusCode}');
    print('Error message: ${response.body}');
  }

  void handleOtherErrors(http.Response response) {
    print('Error during registration: ${response.statusCode}');
    print('Error message: ${response.body}');
  }

  Future<void> otpVerify(
    String otp,
    context,
  ) async {
    isLoading = true;
    notifyListeners();
    if (otp.isEmpty) {
      handleOtpMissingField(context);
      isLoading = false;
      notifyListeners();
      return;
    }

    if (otp.length != 4) {
      handleInvalidOtpLength(context);
      isLoading = false;
      notifyListeners();
      return;
    }

    final Map<String, dynamic> requestBody = {
      'temp_token': tempToken,
      'otp': otp,
    };

    const String apiUrl = 'https://posmab.com/project/booking/api/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        handleOtpVerificationSuccess(response, context);
      } else {
        handleOtpVerificationFailure(response, context);
      }
    } catch (e) {
      print('Error during OTP verification: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void handleOtpMissingField(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.primaryColor,
        content: Text("The OTP field is required."),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void handleInvalidOtpLength(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.primaryColor,
        content: Text("The OTP field must be 4 digits."),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void handleWrongOtpOrPhoneNumberNotFound(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.primaryColor,
        content: Text("Wrong OTP or phone number not found."),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void handleOtpVerificationSuccess(http.Response response, context) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.primaryColor,
        content: Text(responseData['success']),
        duration: Duration(seconds: 3),
      ),
    );

    String token = responseData['token'];
    int userId = responseData['user_id'];
    SharedPreferencesHelper.saveUserId(userId);
    print('userId: $userId');
    SharedPreferencesHelper.saveToken(token);
    print('Token: $token');

    NavigationServices(context).gotoTabScreen();
  }

  void handleOtpVerificationFailure(http.Response response, context) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.primaryColor,
        content: Text(responseData['error']),
        duration: Duration(seconds: 3),
      ),
    );

    print('Error during OTP verification: ${response.statusCode}');
    print('Error message: ${response.body}');
  }

  void resetErrorMessages() {
    emailErrorMessage = null;
    phoneErrorMessage = null;
    nameErrorMessage = null;
    mobilenumber = null;
  }

  Future<void> userLogin(
    String phone,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    resetErrorMessages();

    final Map<String, dynamic> requestBody = {
      'phone': phone,
    };

    const String apiUrl = 'https://posmab.com/project/booking/api/login-otp';

    try {
      final startTime = DateTime.now();
      final response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );
      final endTime = DateTime.now();
      // print('Time taken: ${endTime.difference(startTime).inMilliseconds}ms');

      if (response.statusCode == 200) {
        tempToken = json.decode(response.body)['temporary_token'];
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.primaryColor,
            content: Text(jsonData['success']),
            duration: Duration(seconds: 3),
          ),
        );
        // print('Login successful: $tempToken');
        // ignore: use_build_context_synchronously
        NavigationServices(context).gotoOtpValidationScreen(this);
      } else if (response.statusCode == 403) {
        handleLoginValidationErrors(response);
      } else {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // handleLoginOtherErrors(response);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.primaryColor,
            content: Text(jsonData['error']),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Error during registration: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void handleLoginOtherErrors(http.Response response) {
    print('Error during registration: ${response.statusCode}');
    print('Error message: ${response.body}');
  }

  void handleLoginValidationErrors(http.Response response) {
    final Map<String, dynamic> errorBody = json.decode(response.body);
    final List<dynamic> errors = errorBody['errors'];
    String error = errorBody['error'];

    for (dynamic error in errors) {
      final String errorCode = error['code'];
      final String errorMessage = error['message'];

      switch (errorCode) {
        case 'phone':
          mobilenumber = errorMessage;
          break;
      }
    }

    notifyListeners();
    print('Error during registration: ${response.statusCode}');
    print('Error message: ${response.body}');
  }
}

class NavigationServicess {
  final BuildContext context;

  NavigationServicess(this.context);

  void gotoOtpValidationScreen(SignupProvider signupProvider) {
    // Implement the navigation logic
  }

  void gotoTabScreen() {
    // Implement the navigation logic
  }
}

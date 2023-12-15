import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/models/villaDetails.dart';
import 'package:new_motel/modules/payment/bookingCornfirmation.dart';

class BookingProvider extends ChangeNotifier {
  Future<void> makeBooking(
    BuildContext context, {
    required VillaDetails villaDetails,
    required String villa_id,
    required String check_in_date,
    required String check_out_date,
    required String total_price,
    required String guest_name,
    required String guest_email,
    required String guest_contact_number,
    required String gst_number,
    required String gst_company_address,
    required dynamic user_id,
    required String gst_registered_company,
  }) async {
    // Print all parameters
    print('user_id: $user_id');
    print('villa_id: $villa_id');
    print('check_in_date: $check_in_date');
    print('check_out_date: $check_out_date');
    print('total_price: $total_price');
    print('guest_name: $guest_name');
    print('guest_email: $guest_email');
    print('guest_contact_number: $guest_contact_number');
    print('gst_number: $gst_number');
    print('gst_registered_company: $gst_registered_company');
    print('gst_company_address: $gst_company_address');

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var body = {
      'user_id': user_id,
      'villa_id': villa_id,
      'check_in_date': check_in_date,
      'check_out_date': check_out_date,
      'total_price': total_price,
      'guest_name': guest_name,
      'guest_email': guest_email,
      'guest_contact_number': guest_contact_number,
      'gst_number': gst_number ?? '',
      'gst_registered_company': gst_registered_company ?? "",
      'gst_company_address': gst_company_address ?? '',
    };

    try {
      // Send the request
      http.Response response = await http.post(
        Uri.parse('https://posmab.com/project/booking/api/bookings/'),
        headers: headers,
        body: body,
      );
      print(body);
      print(response.body);

      // Parse the response
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Extract the "success" key from the parsed JSON
      // Extract the "success" key from the parsed JSON
      String successMessage = jsonResponse['success'] as String? ?? '';
      print('successMessage: $successMessage');

      // Check the response status code
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BookingConfirmationScreen(
              villaDetails: villaDetails,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.primaryColor,
            content: Text('Booking not Confirmed: Something went wrong'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

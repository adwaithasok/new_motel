import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_motel/models/bookingslistmodel.dart';
import 'package:new_motel/providers/auth/sharedPreferece.dart';

class GetBookingsApi extends ChangeNotifier {
  static const String baseUrl = 'https://posmab.com/project/booking/api';

  Future<List<Booking>> getBookings() async {
    try {
      String? token = await SharedPreferencesHelper.getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/bookings/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('bookings')) {
          final List<dynamic> bookingsData = data['bookings'];
          print(bookingsData);

          // Explicitly cast to List<Booking>
          List<Booking> bookings = bookingsData
              .map((json) => Booking.fromJson(json as Map<String, dynamic>))
              .toList();

          return bookings;
        } else {
          throw Exception('No bookings data found');
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      // Handle exceptions here
      print('Error: $e');
      rethrow; // Rethrow the exception to propagate it to the caller
    }
  }
}

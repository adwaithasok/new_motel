import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_motel/models/villaDetails.dart';
import 'package:new_motel/providers/auth/sharedPreferece.dart';

class GetSingleVillaDetailsProvider extends ChangeNotifier {
  VillaDetails _villaDetails = VillaDetails();
  // late VillaDetails _villaDetails;
  VillaDetails get villaDetails => _villaDetails;

  Future<void> fetchVillaDetails(int villaId) async {
    final String apiUrl =
        'https://posmab.com/project/booking/api/villas/$villaId';
    String? token = await SharedPreferencesHelper.getToken();

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        _villaDetails = VillaDetails.fromJson(jsonResponse);
        print(_villaDetails);
        notifyListeners();
      } else {
        // Handle error
        print(
            'Failed to load villa details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network error
      print('Error fetching villa details: $error');
    }
  }
}

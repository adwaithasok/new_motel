import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_motel/models/searchvillaModel.dart';
import 'package:new_motel/providers/auth/sharedPreferece.dart';

class SearchVillaProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _villaList = [];
  List<Map<String, dynamic>> get villaList => _villaList;

  Future<void> fetchVillas() async {
    final String apiUrl =
        'https://posmab.com/project/booking/api/villas/search/title=moon';
    String? token = await SharedPreferencesHelper.getToken();

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        _villaList = List<Map<String, dynamic>>.from(jsonResponse);
        print(_villaList);
        notifyListeners();
      } else {
        // Handle error
        print('Failed to load villas. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network error
      print('Error fetching villas: $error');
    }
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_motel/models/homeVillaModel.dart';

class HomeVillaListProvider extends ChangeNotifier {
  List<HomeVillaModel> _villas = [];
  List<HomeVillaModel> get villas => _villas;

  Future<void> fetchVillaList() async {
    final String apiUrl = 'https://posmab.com/project/booking/api/villas/home/';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        _villas =
            jsonResponse.map((data) => HomeVillaModel.fromJson(data)).toList();
        notifyListeners();
      } else {
        // Handle error
        print('Failed to load villa list. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network error
      print('Error fetching villa list: $error');
    }
  }
}

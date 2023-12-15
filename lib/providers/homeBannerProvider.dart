import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_motel/models/homeBannerModel.dart';

class BannerProvider extends ChangeNotifier {
  BannerProvider();

  List<Bannermodel> _banners = [];

  List<Bannermodel> get banners => _banners;

  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse(
          'https://posmab.com/project/booking/api/banners?banner_type=all'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<Bannermodel> bannerList =
            jsonList.map((json) => Bannermodel.fromJson(json)).toList();
        _banners = bannerList;
        print(_banners);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}

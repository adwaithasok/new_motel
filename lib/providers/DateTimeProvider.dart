import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_motel/constants/helper.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/models/room_data.dart';
import 'package:new_motel/modules/hotel_booking/components/calendar_pop_up_view.dart';
import 'package:new_motel/modules/hotel_booking/components/room_pop_up_view.dart';
import 'package:provider/provider.dart';

class TimeDateViewStateProvider with ChangeNotifier {
  String? languageCode;
  // TimeDateViewStateProvider(this.languageCode);

  RoomData _roomData = RoomData(1, 2);
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 5));

  RoomData get roomData => _roomData;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  void updateDate(DateTime startData, DateTime endData) {
    _startDate = startData;
    _endDate = endData;
    notifyListeners();
  }

  void updateRoomData(RoomData data) {
    _roomData = data;
    notifyListeners();
  }
}

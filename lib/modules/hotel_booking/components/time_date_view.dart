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
import 'package:new_motel/providers/DateTimeProvider.dart';
import 'package:provider/provider.dart';

class TimeDateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeDateProvider = Provider.of<TimeDateViewStateProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _getDateRoomUi(
            context,
            Loc.alized.choose_date,
            "${DateFormat("dd, MMM", timeDateProvider.languageCode).format(timeDateProvider.startDate)} - ${DateFormat("dd, MMM", timeDateProvider.languageCode).format(timeDateProvider.endDate)}",
            () {
              _showDemoDialog(context, timeDateProvider);
            },
          ),
          Container(
            width: 1,
            height: 42,
            color: Colors.grey.withOpacity(0.8),
          ),
          _getDateRoomUi(
            context,
            Loc.alized.number_room,
            Helper.getRoomText(timeDateProvider.roomData),
            () {
              _showPopUp(context, timeDateProvider);
            },
          ),
        ],
      ),
    );
  }

  Widget _getDateRoomUi(
      context, String title, String subtitle, VoidCallback onTap) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
              onTap: onTap,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyles(context)
                          .getDescriptionStyle()
                          .copyWith(fontSize: 16, color: AppTheme.backColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      subtitle,
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(color: AppTheme.backColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDemoDialog(
      BuildContext context, TimeDateViewStateProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        maximumDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: provider.endDate,
        initialStartDate: provider.startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          provider.updateDate(startData, endData);
        },
        onCancelClick: () {},
      ),
    );
  }

  void _showPopUp(BuildContext context, TimeDateViewStateProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) => RoomPopupView(
        roomData: provider.roomData,
        barrierDismissible: true,
        onChnage: (data) {
          provider.updateRoomData(data);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_motel/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:new_motel/providers/auth/sharedPreferece.dart';
import 'package:new_motel/providers/bookingProvider.dart';
import 'package:provider/provider.dart';

import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/models/villaDetails.dart';
import 'package:new_motel/providers/DateTimeProvider.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:page_transition/page_transition.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final VillaDetails villaDetails;

  BookingConfirmationScreen({Key? key, required this.villaDetails})
      : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  Future<bool> IsLoggedIn() async {
    bool isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
    return isLoggedIn;
  }

  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: IsLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool isLoggedIn = snapshot.data ?? false;
          var timeDateProvider =
              Provider.of<TimeDateViewStateProvider>(context);
          bool isFinished = false;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 100, color: AppTheme.primaryColor),
                  const SizedBox(height: 16),
                  const Text(
                    'Booking Confirmed!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Thank you for your booking. Your reservation has been confirmed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 50),
                  // Placeholder for additional details or actions

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.villaDetails != null
                                    ? this
                                        .widget
                                        .villaDetails
                                        .villaTitle
                                        .toString()
                                    : "Hotel name",
                                style: TextStyle(
                                    color: AppTheme.backColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.locationDot,
                                size: 10,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.villaDetails.area.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles(context)
                                        .getDescriptionStyle()
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                  ),
                                  const Text(','),
                                  Text(
                                    widget.villaDetails.villaCity.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles(context)
                                        .getDescriptionStyle()
                                        .copyWith(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Check-in'.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: AppTheme.backColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${DateFormat("dd, MMM").format(timeDateProvider.startDate)}',
                                    style: TextStyle(
                                        color: AppTheme.backColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Check-out'.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: AppTheme.backColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${DateFormat("dd, MMM").format(timeDateProvider.endDate)}',
                                    style: TextStyle(
                                        color: AppTheme.backColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 220),

                  SwipeableButtonView(
                    buttonText: isLoggedIn
                        ? '  ' '     SLIDE TO CHECK YOUR BOOKINGS'
                        : 'SLIDE TO BACK',
                    buttonWidget: Container(
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    activeColor: AppTheme.primaryColor,
                    isFinished: isFinished,
                    onWaitingProcess: () async {
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          isFinished = true;
                        });
                      });
                      await Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const BottomTabScreen(
                                initialIndex: 1,
                              )));
                    },
                    onFinish: () async {
                      // await Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.fade,
                      //         child: BottomTabScreen(
                      //           initialIndex: 1,
                      //         )));

                      //TODO: For reverse ripple effect animation
                      setState(() {
                        isFinished = false;
                      });
                    },
                  )
                ],
              ),
            ),
          );
        } else {
          // return a loading indicator or placeholder while waiting for the result
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

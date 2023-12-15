// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_icon_dialog/flutter_icon_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:new_motel/constants/text_styles.dart';

import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/models/hotel_list_data.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CheckOutScreen extends StatelessWidget {
  String hotelame;
  String location;

  final HotelListData hotelListData;
  final String roomName;
  final int rate;
  final int? numberOfPeople;
  final int? numberOfDays;

  CheckOutScreen({
    Key? key,
    required this.hotelame,
    required this.location,
    required this.hotelListData,
    required this.roomName,
    required this.rate,
    this.numberOfPeople,
    this.numberOfDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.18, 0.18],
            colors: [
              Theme.of(context).primaryColor.withOpacity(.92),
              Colors.white
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      color: AppTheme.backColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Hotel Details
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "Stay information",
                              style: TextStyle(
                                  color: AppTheme.whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Nov-29 " +
                                            "(" +
                                            numberOfDays.toString() +
                                            " Night)",
                                        style: TextStyle(
                                            color: AppTheme.backColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // Icon(
                                  //   FontAwesomeIcons.locationDot,
                                  //   size: 12,
                                  //   color: Theme.of(context).primaryColor,
                                  // ),
                                  Text(
                                    numberOfPeople.toString() + " Guest",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles(context)
                                        .getDescriptionStyle()
                                        .copyWith(
                                          // color: AppTheme.backColor,
                                          fontSize: 14,
                                        ),
                                  ),
                                  // Text(
                                  //   Loc.alized.km_to_city,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: TextStyles(context)
                                  //       .getDescriptionStyle()
                                  //       .copyWith(
                                  //         fontSize: 14,
                                  //       ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.mail,
                                    color: AppTheme.backColor,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'adwaithdeva@gmail.com',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.backColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: AppTheme.backColor,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.backColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrival and Departure
                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 30, horizontal: 10),
                  //   child: Row(
                  //     children: <Widget>[
                  //       const Padding(
                  //         padding: EdgeInsets.only(right: 50.0),
                  //         child: RotatedBox(
                  //           quarterTurns: 3,
                  //           child: Text("Term"),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceEvenly,
                  //                   children: const [
                  //                     Text(
                  //                       'Arrival',
                  //                       style: TextStyle(fontSize: 10),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 10,
                  //                     ),
                  //                     Text(
                  //                       'Arrival Date',
                  //                       style: TextStyle(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceEvenly,
                  //                   children: const [
                  //                     Text(
                  //                       'Departure',
                  //                       style: TextStyle(fontSize: 10),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 10,
                  //                     ),
                  //                     Text(
                  //                       'Departure Date',
                  //                       style: TextStyle(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               child: Text(
                  //                 'Change Date',
                  //                 style: TextStyle(
                  //                     color: AppTheme.primaryColor,
                  //                     fontSize: 10,
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Room Details
                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 10, horizontal: 10),
                  //   child: Row(
                  //     children: <Widget>[
                  //       const Padding(
                  //         padding: EdgeInsets.only(right: 50.0),
                  //         child: RotatedBox(
                  //           quarterTurns: 3,
                  //           child: Text("Room Details"),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   this.roomName,
                  //                   style: TextStyle(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //                 Text(
                  //                   '$rate',
                  //                   style: const TextStyle(fontSize: 16),
                  //                 ),
                  //               ],
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             Text(
                  //               "See details",
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 10,
                  //                   color: AppTheme.primaryColor),
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               child: Container(
                  //                 color: AppTheme.primaryColor,
                  //                 width: MediaQuery.of(context).size.width,
                  //                 height: 50,
                  //                 child: Center(
                  //                     child: Text(
                  //                   "Change",
                  //                   style: TextStyle(color: Colors.white),
                  //                 )),
                  //               ),
                  //             )
                  //             // Row(
                  //             //   children: [
                  //             //     // You can add an Icon here if needed
                  //             //   ],
                  //             // ),
                  //             // const SizedBox(
                  //             //   height: 10,
                  //             // ),
                  //             // Row(
                  //             //   children: [
                  //             //     Text(
                  //             //       'Total Price: \$$rate * $numberOfDays',
                  //             //       style: const TextStyle(fontSize: 16),
                  //             //     ),
                  //             //     // You can add an Icon here if needed
                  //             //   ],
                  //             // ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Payment Summary
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "Order Summery",
                              style: TextStyle(
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Sub total :" + " " + rate.toString(),
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.normal),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sub Tota;l : ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.backColor,
                                    ),
                                  ),
                                  Text(
                                    '${rate}',
                                    style: TextStyle(
                                      color: AppTheme.backColor,
                                    ),
                                  )
                                  // You can add an Icon here if needed
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tax : ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.backColor,
                                    ),
                                  ),
                                  Text(
                                    '${"100"}',
                                    style: TextStyle(
                                      color: AppTheme.backColor,
                                    ),
                                  )
                                  // You can add an Icon here if needed
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  // You can add an Icon here if needed
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Payable',
                                    style: TextStyle(
                                        color: AppTheme.backColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${rate + 100}',
                                    style: TextStyle(
                                        color: AppTheme.backColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // You can add an Icon here if needed
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       'Total',
                              //       style: TextStyle(fontSize: 16),
                              //     ),
                              //     Text(
                              //       '${rate * numberOfDays + 100}', // Add your calculation here
                              //       style: TextStyle(
                              //           fontSize: 13,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     // You can add an Icon here if needed
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "customer information",
                              style: TextStyle(
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Sub total :" + " " + rate.toString(),
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.normal),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sub Tota;l : ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.backColor,
                                    ),
                                  ),
                                  Text(
                                    '${rate}',
                                    style: TextStyle(
                                      color: AppTheme.backColor,
                                    ),
                                  )
                                  // You can add an Icon here if needed
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tax : ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.backColor,
                                    ),
                                  ),
                                  Text(
                                    '${"100"}',
                                    style: TextStyle(
                                      color: AppTheme.backColor,
                                    ),
                                  )
                                  // You can add an Icon here if needed
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  // You can add an Icon here if needed
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Payable',
                                    style: TextStyle(
                                        color: AppTheme.backColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${rate + 100}',
                                    style: TextStyle(
                                        color: AppTheme.backColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // You can add an Icon here if needed
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       'Total',
                              //       style: TextStyle(fontSize: 16),
                              //     ),
                              //     Text(
                              //       '${rate * numberOfDays + 100}', // Add your calculation here
                              //       style: TextStyle(
                              //           fontSize: 13,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     // You can add an Icon here if needed
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Payment Button
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0),
              child: Container(
                color: Colors.amber,
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  // Example usage in your onPressed callback
                  onPressed: () {
                    // Check if the user is logged in
                    bool userLoggedIn = false;

                    if (userLoggedIn) {
                      // User is logged in, proceed with the desired action
                      // Add your payment logic or any other action here
                    } else {
                      // User is not logged in, show the login popup
                      QuickAlert.show(
                        title: 'This section is lockeed',
                        showCancelBtn: true,
                        context: context,
                        type: QuickAlertType.error,
                        text: 'go',
                        confirmBtnText: 'Yes',
                        cancelBtnText: 'No',
                        confirmBtnColor: AppTheme.primaryColor,
                      );
                    }
                  },

                  child: Text(
                    'BOOK NOW',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}

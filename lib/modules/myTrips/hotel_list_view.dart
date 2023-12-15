import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_motel/constants/helper.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/models/bookingslistmodel.dart';
import 'package:new_motel/models/hotel_list_data.dart';
import 'package:new_motel/widgets/common_card.dart';
import 'package:new_motel/widgets/list_cell_animation_view.dart';

class HotelListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final Booking hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  const HotelListView(
      {Key? key,
      required this.hotelData,
      required this.animationController,
      required this.animation,
      required this.callback,
      this.isShowDate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 16),
        child: Column(
          children: <Widget>[
            // isShowDate
            //     ? Padding(
            //         padding: const EdgeInsets.only(top: 12, bottom: 12),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Text(
            //               DateFormat("dd, MMM")
            //                   .format(DateTime.parse(hotelData.checkInDate)),
            //               style: TextStyles(context).getRegularStyle().copyWith(
            //                   fontSize: 14, fontWeight: FontWeight.bold),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(top: 2.0, left: 20),
            //               child: Text(
            //                 DateFormat("dd, MMM")
            //                     .format(DateTime.parse(hotelData.checkOutDate)),
            //                 style: TextStyles(context)
            //                     .getRegularStyle()
            //                     .copyWith(
            //                         fontSize: 14, fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //     : const SizedBox(),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Adjust the radius as needed
                side: BorderSide(
                    color: AppTheme.primaryColor,
                    width: 1.0), // Specify border color and width
              ),
              elevation: 4,
              color: AppTheme.backgroundColor,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 2,
                          child: Image.asset(
                            'assets/images/city_4.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, bottom: 8, right: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      hotelData.villaTitle,
                                      textAlign: TextAlign.left,
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(fontSize: 22),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          hotelData.villaCity,
                                          style: TextStyles(context)
                                              .getDescriptionStyle(),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 12,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                          hotelData.villaArea,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles(context)
                                              .getDescriptionStyle(),
                                        ),
                                        Expanded(
                                          child: Text(
                                            Loc.alized.km_to_city,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles(context)
                                                .getDescriptionStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, top: 8, left: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "\₹${hotelData.totalPrice.toString()}",
                                    textAlign: TextAlign.left,
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(fontSize: 22),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Get.find<Loc>().isRTL ? 2.0 : 0.0),
                                    child: Text(
                                      'Total price',
                                      style: TextStyles(context)
                                          .getDescriptionStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 17, right: 17),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Chek-in : '.toUpperCase() +
                                      DateFormat("dd, MMM").format(
                                          DateTime.parse(
                                              hotelData.checkInDate)),
                                  style: TextStyles(context)
                                      .getRegularStyle()
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2.0, left: 20),
                                  child: Text(
                                    'chek-out : '.toUpperCase() +
                                        DateFormat("dd, MMM").format(
                                            DateTime.parse(
                                                hotelData.checkOutDate)),
                                    style: TextStyles(context)
                                        .getRegularStyle()
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: const Color.fromARGB(255, 213, 213, 213),
                          elevation: 10,
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //         width: 1, color: AppTheme.primaryColor)),
                          // width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              top: 5, bottom: 15, left: 15, right: 15),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Guest Details :',
                                      style: TextStyles(context)
                                          .getDescriptionStyle()
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(hotelData.guestName,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(hotelData.guestEmail,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

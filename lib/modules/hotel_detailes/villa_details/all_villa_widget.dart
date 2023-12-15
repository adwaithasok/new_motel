import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:new_motel/constants/helper.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/models/hotel_list_data.dart';
import 'package:new_motel/modules/hotel_detailes/villa_details/villa_details.dart';
import 'package:new_motel/widgets/common_card.dart';
import 'package:new_motel/widgets/list_cell_animation_view.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class VillaListView extends StatefulWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final Map<String, dynamic> hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  const VillaListView(
      {Key? key,
      required this.hotelData,
      required this.animationController,
      required this.animation,
      required this.callback,
      this.isShowDate = false})
      : super(key: key);

  @override
  State<VillaListView> createState() => _VillaListViewState();
}

class _VillaListViewState extends State<VillaListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
  }

  final shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _launchMaps() async {
      final String mapUrl = widget.hotelData['villa_google_location'];

      if (Platform.isIOS) {
        // Use Apple Maps on iOS
        launch('https://maps.apple.com/?q=${Uri.encodeQueryComponent(mapUrl)}');
      } else {
        // Use Google Maps on Android or other platforms
        launch(mapUrl);
      }
    }

    return ListCellAnimationView(
      animation: widget.animation,
      animationController: widget.animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 16),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                shakeKey.currentState?.shake();
              },
              child: CommonCard(
                color: AppTheme.backgroundColor,
                radius: 16,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 2,
                            child: Image.network(
                              'https://posmab.com/' +
                                  widget.hotelData['folder'] +
                                  widget.hotelData['villa_image'],
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
                                      left: 16, top: 8, bottom: 8, right: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.hotelData['villa_title'],
                                        textAlign: TextAlign.left,
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(fontSize: 22),
                                      ),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  widget.hotelData[
                                                              'villa_city'] +
                                                          ',' ??
                                                      '',
                                                  style: TextStyles(context)
                                                      .getDescriptionStyle()
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: AppTheme
                                                              .primaryColor),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  widget.hotelData['area'] ??
                                                      '',
                                                  style: TextStyles(context)
                                                      .getDescriptionStyle()
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: AppTheme
                                                              .primaryColor),
                                                ),
                                                const SizedBox(
                                                  width: 0,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    launch(
                                                        'https://maps.app.goo.gl/78m2N5Va1x353qmi8');
                                                  },
                                                  child: ShakeMe(
                                                    // pass the GlobalKey as an argument
                                                    key: shakeKey,
                                                    // configure the animation parameters
                                                    shakeCount: 3,
                                                    shakeOffset: 3,
                                                    shakeDuration: Duration(
                                                        milliseconds: 500),
                                                    // Add the child widget that will be animated
                                                    child: Icon(
                                                        FontAwesomeIcons
                                                            .locationDot,
                                                        size: 12,
                                                        color: AppTheme
                                                            .primaryColor),
                                                  ),
                                                ),
                                                // Text(
                                                //   'Click for location',
                                                //   style: TextStyles(context)
                                                //       .getDescriptionStyle()
                                                //       .copyWith(
                                                //           color: Colors.blue),
                                                // ),
                                              ],
                                            ),

                                            //  Row(
                                            //   children: <Widget>[
                                            //     Helper.ratingStar(),
                                            //     Text(
                                            //       " ${80}",
                                            //       style: TextStyles(context)
                                            //           .getDescriptionStyle(),
                                            //     ),
                                            //     Text(
                                            //       Loc.alized.reviews,
                                            //       style: TextStyles(context)
                                            //           .getDescriptionStyle(),
                                            //     ),
                                            //   ],
                                            // ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          widget.hotelData[
                                                      'villa_discount_price'] >
                                                  0
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text.rich(TextSpan(
                                                      text:
                                                          '₹${widget.hotelData['villa_basic_price']}',
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        // Add any other styles you want for the strikethrough text
                                                      ),
                                                    )),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "₹${widget.hotelData['villa_discount_price']}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyles(
                                                                  context)
                                                              .getBoldStyle()
                                                              .copyWith(
                                                                  fontSize: 22),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: Get.find<
                                                                          Loc>()
                                                                      .isRTL
                                                                  ? 2.0
                                                                  : 0.0),
                                                          child: Text(
                                                            Loc.alized
                                                                .per_night,
                                                            style: TextStyles(
                                                                    context)
                                                                .getDescriptionStyle(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "₹${widget.hotelData['villa_basic_price']}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyles(
                                                                  context)
                                                              .getBoldStyle()
                                                              .copyWith(
                                                                  fontSize: 22),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: Get.find<
                                                                          Loc>()
                                                                      .isRTL
                                                                  ? 2.0
                                                                  : 0.0),
                                                          child: Text(
                                                            Loc.alized
                                                                .per_night,
                                                            style: TextStyles(
                                                                    context)
                                                                .getDescriptionStyle(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          VillaDetailesScreen(
                                                            imageName: widget
                                                                    .hotelData[
                                                                'villa_image'],
                                                            id: widget
                                                                    .hotelData[
                                                                'id'],
                                                          )));
                                              // Handle button press
                                              // You can add your logic here
                                            },
                                            child: const Text('Book Now'),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   bottom: 0,
                      //   left: 0,
                      //   child: Material(
                      //     color: Colors.transparent,
                      //     child: InkWell(
                      //         highlightColor: Colors.transparent,
                      //         splashColor:
                      //             Theme.of(context).primaryColor.withOpacity(0.1),
                      //         borderRadius: const BorderRadius.all(
                      //           Radius.circular(16.0),
                      //         ),
                      //         onTap: () {
                      //           shakeKey.currentState?.shake();
                      //         }),
                      //   ),
                      // ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              shape: BoxShape.circle),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

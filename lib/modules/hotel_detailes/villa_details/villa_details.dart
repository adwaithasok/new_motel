// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:new_motel/constants/helper.dart';
import 'package:new_motel/constants/localfiles.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/models/hotel_list_data.dart';
import 'package:new_motel/models/villaDetails.dart';
import 'package:new_motel/modules/hotel_detailes/hotel_roome_list.dart';
import 'package:new_motel/modules/hotel_detailes/rating_view.dart';
import 'package:new_motel/modules/hotel_detailes/review_data_view.dart';
import 'package:new_motel/modules/payment/paymetScreen.dart';
import 'package:new_motel/providers/getSingleVillaDetailsProvider.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:new_motel/widgets/common_button.dart';
import 'package:new_motel/widgets/common_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class VillaDetailesScreen extends StatefulWidget {
  dynamic id;
  String? imageName;

  VillaDetailesScreen({Key? key, required this.id, this.imageName})
      : super(key: key);
  @override
  State<VillaDetailesScreen> createState() => _VillaDetailesScreenState();
}

class _VillaDetailesScreenState extends State<VillaDetailesScreen>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  bool isFav = false;
  bool isReadless = false;
  late AnimationController animationController;
  var imageHieght = 0.0;
  late AnimationController _animationController;

  @override
  void initState() {
    Provider.of<GetSingleVillaDetailsProvider>(context, listen: false)
        .fetchVillaDetails(widget.id);

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    animationController.forward();
    scrollController.addListener(() {
      if (mounted) {
        if (scrollController.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < imageHieght) {
          // we need around half scrolling values
          if (scrollController.offset < ((imageHieght / 1.2))) {
            _animationController
                .animateTo((scrollController.offset / imageHieght));
          } else {
            // we static set the just above half scrolling values "around == 0.22"
            _animationController.animateTo((imageHieght / 1.2) / imageHieght);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var getSingleVillaDetailsProvider =
        Provider.of<GetSingleVillaDetailsProvider>(context);
    var villaDetails = getSingleVillaDetailsProvider.villaDetails;
    var villadesc = villaDetails.villaDesc;
    var hoteltext1 = (villadesc.toString().length / 3).round();
    String firstHalf = villadesc.toString().substring(0, hoteltext1);

    var hoteltext2 = villadesc;
    imageHieght = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CommonCard(
            radius: 0,
            color: AppTheme.scaffoldBackgroundColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 24 + imageHieght),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  // Hotel title and animation view
                  child: getHotelDetails(
                      isInList: true, villaDetails: villaDetails),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Loc.alized.summary,
                          style: TextStyles(context).getBoldStyle().copyWith(
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 4, bottom: 8),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Html(
                              data: !isReadless
                                  ? firstHalf.toString()
                                  : hoteltext2),
                        ),
                        TextSpan(
                          text: !isReadless
                              ? Loc.alized.read_more
                              : Loc.alized.less,
                          style: TextStyles(context).getRegularStyle().copyWith(
                              color: AppTheme.primaryColor, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isReadless = !isReadless;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                    bottom: 16,
                  ),
                  // overall rating view
                  // child: RatingView(hotelData: widget.hotelData),
                ),
                _getPhotoReviewUi(Loc.alized.room_photo, Loc.alized.view_all,
                    Icons.arrow_forward, () {}),

                // Hotel inside photo view
                HotelRoomeList(
                  Folder: villaDetails.imageFolder.toString(),
                  imageList: villaDetails.images,
                ),
                // _getPhotoReviewUi(Loc.alized.reviews, Loc.alized.view_all,
                //     Icons.arrow_forward, () {
                //   NavigationServices(context).gotoReviewsListScreen();
                // }
                // ),

                // feedback&Review data view
                // for (var i = 0; i < 2; i++)
                //   ReviewsView(
                //     reviewsList: HotelListData.reviewsList[i],
                //     animation: animationController,
                //     animationController: animationController,
                //     callback: () {},
                //   ),

                // const SizedBox(
                //   height: 16,
                // ),
                // Stack(
                //   alignment: Alignment.center,
                //   children: <Widget>[
                //     AspectRatio(
                //       aspectRatio: 1.5,
                //       child: Image.asset(
                //         Localfiles.mapImage,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(top: 34, right: 10),
                //       child: CommonCard(
                //         color: AppTheme.primaryColor,
                //         radius: 36,
                //         child: Padding(
                //           padding: const EdgeInsets.all(12.0),
                //           child: Icon(
                //             FontAwesomeIcons.mapPin,
                //             color: Theme.of(context).backgroundColor,
                //             size: 28,
                //           ),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 56, top: 16),
                  child: CommonButton(
                    buttonText: Loc.alized.book_now,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MyPaymentScreen(
                                    villaDetails: villaDetails,
                                  )));
                    },
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),

          // backgrouund image and Hotel name and thier details and more details animation view
          _backgraoundImageUI(villaDetails),

          // Arrow back Ui
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              height: AppBar().preferredSize.height,
              child: Row(
                children: <Widget>[
                  _getAppBarUi(Theme.of(context).disabledColor.withOpacity(0.4),
                      Icons.arrow_back, AppTheme.backgroundColor, () {
                    if (scrollController.offset != 0.0) {
                      scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 480),
                          curve: Curves.easeInOutQuad);
                    } else {
                      Navigator.pop(context);
                    }
                  }),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // like and unlike view
                  _getAppBarUi(
                      AppTheme.backgroundColor,
                      isFav ? Icons.favorite : Icons.favorite_border,
                      AppTheme.primaryColor, () {
                    setState(() {
                      isFav = !isFav;
                    });
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getAppBarUi(
      Color color, IconData icon, Color iconcolor, VoidCallback onTap) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Container(
          width: AppBar().preferredSize.height - 8,
          height: AppBar().preferredSize.height - 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: iconcolor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPhotoReviewUi(
      String title, String view, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          // Expanded(
          //   child: Text(
          //     title,
          //     style: TextStyles(context).getBoldStyle().copyWith(
          //           fontSize: 14,
          //         ),
          //   ),
          // ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      view,
                      textAlign: TextAlign.left,
                      style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 26,
                      child: Icon(
                        icon,
                        //Icons.arrow_forward,
                        size: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _backgraoundImageUI(VillaDetails villaDetails) {
    // print(widget.imageName);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          print('.................');

          print(
              'https://posmab.com${villaDetails.imageFolder}${widget.imageName.toString()}');
          print('.................');
          var opecity = 1.0 -
              (_animationController.value >= ((imageHieght / 1.9) / imageHieght)
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: imageHieght * (1.0 - _animationController.value),
            child: Stack(
              children: <Widget>[
                IgnorePointer(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          top: 0,
                          child: villaDetails.imageFolder != null
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    'https://posmab.com${villaDetails.imageFolder}${widget.imageName.toString()}',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Container(
                                      height: 40,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )),
                                )),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: opecity,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 20.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, top: 8),
                                      child: getHotelDetails(
                                          villaDetails: villaDetails),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 16,
                                          top: 16),
                                      child: CommonButton(
                                          buttonText: Loc.alized.book_now,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        MyPaymentScreen(
                                                          villaDetails:
                                                              villaDetails,
                                                        )));
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (_) =>
                                            //             MyPaymentScreen(
                                            //               hotelame: widget
                                            //                   .hotelData
                                            //                   .titleTxt,
                                            //               location: widget
                                            //                   .hotelData.subTxt
                                            //                   .toString(),
                                            //               rate: widget.hotelData
                                            //                   .perNight,
                                            //               roomName: widget
                                            //                   .hotelData
                                            //                   .titleTxt,
                                            //               hotelListData:
                                            //                   widget.hotelData,
                                            //             )));
                                            // NavigationServices(context)
                                            //     .gotoRoomBookingScreen(
                                            //         widget.hotelData.titleTxt,
                                            //         widget.hotelData.subTxt);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(38)),
                                    onTap: () {
                                      try {
                                        scrollController.animateTo(
                                            MediaQuery.of(context).size.height -
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.fastOutSlowIn);
                                      } catch (_) {}
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 4,
                                          bottom: 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            Loc.alized.more_details,
                                            style: TextStyles(context)
                                                .getBoldStyle()
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getHotelDetails(
      {bool isInList = false, required VillaDetails villaDetails}) {
    // ignore: non_constant_identifier_names
    var Discountprice = villaDetails.villaDiscountPrice;

    // dynamic discountPrice = String.pa(Discountprice);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                villaDetails.villaTitle.toString(),
                textAlign: TextAlign.left,
                style: TextStyles(context).getBoldStyle().copyWith(
                      fontSize: 22,
                      color: isInList ? AppTheme.fontcolor : Colors.white,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    villaDetails.villaCity.toString(),
                    style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 10,
                          color: isInList
                              ? Theme.of(context).disabledColor.withOpacity(0.5)
                              : Colors.white,
                        ),
                  ),
                  Text(
                    ',',
                    style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 10,
                          color: isInList
                              ? Theme.of(context).disabledColor.withOpacity(0.5)
                              : Colors.white,
                        ),
                  ),
                  Text(
                    villaDetails.area.toString(),
                    style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 10,
                          color: isInList
                              ? Theme.of(context).disabledColor.withOpacity(0.5)
                              : Colors.white,
                        ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.locationDot,
                    size: 10,
                    color: Theme.of(context).primaryColor,
                  ),
                  // Text(
                  //   widget.hotelData['villa_title'],
                  //   overflow: TextOverflow.ellipsis,
                  //   style: TextStyles(context).getRegularStyle().copyWith(
                  //         fontSize: 14,
                  //         color: isInList
                  //             ? Theme.of(context).disabledColor.withOpacity(0.5)
                  //             : Colors.white,
                  //       ),
                  // ),
                ],
              ),
              isInList
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: const <Widget>[
                          // Helper.ratingStar(),
                          // Text(
                          //   widget.hotelData['villa_title'],
                          //   style:
                          //       TextStyles(context).getRegularStyle().copyWith(
                          //             fontSize: 14,
                          //             color: isInList
                          //                 ? Theme.of(context)
                          //                     .disabledColor
                          //                     .withOpacity(0.5)
                          //                 : Colors.white,
                          //           ),
                          // ),
                          // Text(
                          //   Loc.alized.reviews,
                          //   style:
                          //       TextStyles(context).getRegularStyle().copyWith(
                          //             fontSize: 14,
                          //             color: isInList
                          //                 ? Theme.of(context).disabledColor
                          //                 : Colors.white,
                          //           ),
                          // ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Discountprice != null && Discountprice > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(
                            text: '₹${villaDetails.villaBasicPrice}',
                            style: TextStyle(
                              color: isInList
                                  ? Theme.of(context).textTheme.bodyText1!.color
                                  : Colors.white,
                              decoration: TextDecoration.lineThrough,
                              // Add any other styles you want for the strikethrough text
                            ),
                          )),
                          Row(
                            children: [
                              Text(
                                "₹${villaDetails.villaDiscountPrice}",
                                textAlign: TextAlign.left,
                                style:
                                    TextStyles(context).getBoldStyle().copyWith(
                                          fontSize: 22,
                                          color: isInList
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color
                                              : Colors.white,
                                        ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Get.find<Loc>().isRTL ? 2.0 : 0.0),
                                child: Text(
                                  '/night',
                                  style:
                                      TextStyles(context).getDescriptionStyle(),
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
                                "₹${villaDetails.villaBasicPrice}",
                                textAlign: TextAlign.left,
                                style:
                                    TextStyles(context).getBoldStyle().copyWith(
                                          fontSize: 22,
                                          color: isInList
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color
                                              : Colors.white,
                                        ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Get.find<Loc>().isRTL ? 2.0 : 0.0),
                                child: Text(
                                  Loc.alized.per_night,
                                  style:
                                      TextStyles(context).getDescriptionStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

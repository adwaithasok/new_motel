import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/models/homeVillaModel.dart';
import 'package:new_motel/modules/explore/view_all_villas.dart';
import 'package:new_motel/modules/hotel_booking/components/time_date_view.dart';
import 'package:new_motel/modules/hotel_detailes/villa_details/all_villa_widget.dart';
import 'package:new_motel/modules/hotel_detailes/villa_details/villa_details.dart';
import 'package:new_motel/modules/myTrips/hotel_list_view_page.dart';
import 'package:new_motel/providers/GetAllVillaDataProvider.dart';
import 'package:new_motel/providers/homeVillasProvider.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';
import 'package:new_motel/widgets/common_button.dart';
import 'package:new_motel/widgets/common_card.dart';
import 'package:new_motel/widgets/common_search_bar.dart';
import 'package:provider/provider.dart';
import '../../models/hotel_list_data.dart';
import 'home_explore_slider_view.dart';
import 'popular_list_view.dart';
import 'title_view.dart';

class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeExploreScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<HomeExploreScreen> createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen>
    with TickerProviderStateMixin {
  var hotelList = HotelListData.hotelList;
  late ScrollController controller;
  late AnimationController _animationController;
  var sliderImageHieght = 0.0;

  @override
  void initState() {
    Provider.of<HomeVillaListProvider>(context, listen: false).fetchVillaList();
    Provider.of<VillaProvider>(context, listen: false).fetchVillas();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
      if (mounted) {
        if (controller.offset < 0) {
          _animationController.animateTo(0.0);
        } else if (controller.offset > 0.0 &&
            controller.offset < sliderImageHieght) {
          if (controller.offset < ((sliderImageHieght / 1.5))) {
            _animationController
                .animateTo((controller.offset / sliderImageHieght));
          } else {
            _animationController
                .animateTo((sliderImageHieght / 1.5) / sliderImageHieght);
          }
        }
      }
    });
    super.initState();
  }

  String selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    var HomevillaProvider = Provider.of<HomeVillaListProvider>(context);

    sliderImageHieght = MediaQuery.of(context).size.width * 1.3;
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Stack(
        children: <Widget>[
          Container(
            color: Color.fromARGB(255, 255, 251, 251),
            child: ListView.builder(
              controller: controller,
              itemCount: 4,
              padding:
                  EdgeInsets.only(top: sliderImageHieght - 150, bottom: 16),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var count = 4;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                if (index == 0) {
                  return TitleView(
                    titleTxt: '',
                    subTxt: '',
                    animation: animation,
                    animationController: widget.animationController,
                    click: () {},
                  );
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: PopularListView(
                      animationController: widget.animationController,
                      callBack: (index) {},
                    ),
                  );
                } else if (index == 2) {
                  return TitleView(
                    titleTxt: Loc.alized.best_deal,
                    subTxt: Loc.alized.view_all,
                    animation: animation,
                    isLeftButton: true,
                    animationController: widget.animationController,
                    click: () {},
                  );
                } else {
                  return getDealListView(
                    index,
                    HomevillaProvider,
                  );
                }
              },
            ),
          ),
          _sliderUI(_animationController),

          // viewHotels Button UI for click event
          // _viewHotelsButton(_animationController),

          //just gradient for see the time and battry Icon on "TopBar"
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).backgroundColor.withOpacity(0.4),
                    Theme.of(context).backgroundColor.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: serachUI(),
          ),
        ],
      ),
    );
  }

  Widget _viewHotelsButton(AnimationController animationControllerData) {
    return AnimatedBuilder(
      animation: animationControllerData,
      builder: (BuildContext context, Widget? child) {
        var opacity = 1.0 -
            (animationControllerData.value > 0.64
                ? 1.0
                : animationControllerData.value);
        return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: sliderImageHieght * (0.7 - animationControllerData.value),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 32,
                left: Get.find<Loc>().isRTL ? null : 24,
                right: Get.find<Loc>().isRTL ? 24 : null,
                child: Opacity(
                  opacity: opacity,
                  child: CommonButton(
                    onTap: () {
                      if (opacity != 0) {
                        NavigationServices(context).gotoHotelHomeScreen();
                      }
                    },
                    buttonTextWidget: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Text(
                        'View Villas',
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sliderUI(AnimationController animationControllerData) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: animationControllerData,
        builder: (BuildContext context, Widget? child) {
          var opacity = 1.0 -
              (animationControllerData.value > 0.64
                  ? 1
                  : animationControllerData.value);
          var sliderHeight =
              sliderImageHieght * (0.7 - animationControllerData.value);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sliderHeight,
                child: HomeExploreSliderView(
                  opValue: opacity,
                  click: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 15, bottom: 5),
                child: Opacity(
                  opacity: opacity,
                  child: Text(
                    'Unlock Your Hotel Adventure',
                    style: TextStyles(context).getBoldStyle().copyWith(
                          color: AppTheme.backColor,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
              Opacity(
                opacity: opacity,
                child: Container(
                  color: Colors.white,
                  // height: 160,
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      TimeDateView(),
                      InkWell(
                        onTap: () {
                          NavigationServices(context).gotoHotelHomeScreen();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              'Search',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget getDealListView(
    int index,
    HomeVillaListProvider villaListProvider,
  ) {
    List<HomeVillaModel> villaList = villaListProvider
        .villas; // Assuming villaListProvider is an instance of VillaListProvider

    List<Widget> list = [];

    for (var villa in villaList) {
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: widget.animationController,
          curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );

      list.add(
        VillaListViewPage(
          callback: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => VillaDetailesScreen(
                          imageName: villa.villaImage,
                          id: villa.id,
                        )));
            // Pass appropriate data to your callback
            // NavigationServices(context).gotoHotelDetailes(villa);
          },
          homevillalist: villa,
          animation: animation,
          animationController: widget.animationController,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: list,
      ),
    );
  }

  Widget serachUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 25),
      child: CommonCard(
        radius: 36,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(38)),
          onTap: () {
            NavigationServices(context).gotoSearchScreen();
          },
          child: CommonSearchBar(
            iconData: FontAwesomeIcons.magnifyingGlass,
            enabled: false,
            text: Loc.alized.where_are_you_going,
          ),
        ),
      ),
    );
  }
}

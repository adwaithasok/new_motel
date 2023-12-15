import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_motel/constants/localfiles.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/models/homeBannerModel.dart';
import 'package:new_motel/modules/hotel_detailes/villa_details/villa_details.dart';
import 'package:new_motel/modules/splash/components/page_pop_view.dart';
import 'package:new_motel/providers/homeBannerProvider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeExploreSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const HomeExploreSliderView(
      {Key? key, this.opValue = 0.0, required this.click})
      : super(key: key);
  @override
  State<HomeExploreSliderView> createState() => _HomeExploreSliderViewState();
}

class _HomeExploreSliderViewState extends State<HomeExploreSliderView> {
  var pageController = PageController(initialPage: 0);
  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    Provider.of<BannerProvider>(context, listen: false).fetchBanners();

    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        if (currentShowIndex == 0) {
          pageController.animateTo(MediaQuery.of(context).size.width,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        } else {
          if (currentShowIndex == 1) {
            pageController.animateTo(MediaQuery.of(context).size.width * 2,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn);
          } else if (currentShowIndex == 2) {
            pageController.animateTo(MediaQuery.of(context).size.width * 3,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn);
          } else if (currentShowIndex == 3) {
            pageController.animateTo(MediaQuery.of(context).size.width * 4,
                duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
          } else if (currentShowIndex == 4) {
            pageController.animateTo(0,
                duration: Duration(seconds: 1), curve: Curves.bounceIn);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var homeBannerProvider = Provider.of<BannerProvider>(context);
    List<Bannermodel> data = homeBannerProvider.banners;

    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: PageView(
              controller: pageController,
              pageSnapping: true,
              onPageChanged: (index) {
                currentShowIndex = index;
              },
              scrollDirection: Axis.horizontal,
              children: data.map((banner) {
                var url =
                    '${'https://posmab.com' + banner.folder + banner.photo}';
                // print(banner.photo);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => VillaDetailesScreen(
                                  id: banner.id,
                                )));
                  },
                  child: PagePopup(
                    imageData: PageViewData(
                      id: banner.id,
                      titleText: banner.villatitle,
                      subText: banner.bannerType,
                      assetsImage: url,
                    ),
                    opValue: widget.opValue,
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 32,
            right: Get.find<Loc>().isRTL ? null : 32,
            left: Get.find<Loc>().isRTL ? 32 : null,
            child: SmoothPageIndicator(
              controller: pageController,
              count: data.length,
              effect: WormEffect(
                activeDotColor: Theme.of(context).primaryColor,
                dotColor: Theme.of(context).dividerColor,
                dotHeight: 10.0,
                dotWidth: 10.0,
                spacing: 5.0,
              ),
              onDotClicked: (
                index,
              ) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => VillaDetailesScreen(
                              id: 1,
                            )));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;

  const PagePopup({Key? key, required this.imageData, this.opValue = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => VillaDetailesScreen(
                          id: imageData.id,
                          imageName: imageData.assetsImage,
                        )));
          },
          child: SizedBox(
            height: (MediaQuery.of(context).size.width * 1.3),
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              imageData.assetsImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          right: 24,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  imageData.titleText,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getTitleStyle().copyWith(
                    color: AppTheme.whiteColor,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  imageData.subText,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getRegularStyle().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.whiteColor,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

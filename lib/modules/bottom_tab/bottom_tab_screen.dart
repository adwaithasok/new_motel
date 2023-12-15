import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/modules/bottom_tab/components/tab_button_ui.dart';
import 'package:new_motel/widgets/common_card.dart';
import '../explore/home_explore.dart';
import '../myTrips/my_trips_screen.dart';
import '../profile/profile_screen.dart';

class BottomTabScreen extends StatefulWidget {
  final int initialIndex; // Initial index for the bottom navigation bar
  const BottomTabScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  BottomBarType bottomBarType = BottomBarType.explore;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      _isFirstTime = false;
      _indexView = _buildScreenByIndex(widget.initialIndex);
      bottomBarType = _getBottomBarType(widget.initialIndex);
    });
    _animationController.forward();
  }

  BottomBarType _getBottomBarType(int index) {
    switch (index) {
      case 0:
        return BottomBarType.explore;
      case 1:
        return BottomBarType.trips;
      case 2:
        return BottomBarType.profile;
      default:
        return BottomBarType.explore; // Default to explore if index is unknown
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60 + MediaQuery.of(context).padding.bottom,
        child: getBottomBarUI(bottomBarType),
      ),
      body: _isFirstTime
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : _indexView,
    );
  }

  void tabClick(BottomBarType tabType, {int index = -1}) {
    if (index != -1) {
      // Use the provided index to determine the BottomBarType
      if (index == 0) {
        tabType = BottomBarType.explore;
      } else if (index == 1) {
        tabType = BottomBarType.trips;
      } else if (index == 2) {
        tabType = BottomBarType.profile;
      }
    }

    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((f) {
        setState(() {
          _indexView = _buildScreenByIndex(index);
        });
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: 0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TabButtonUI(
                icon: Icons.search,
                isSelected: tabType == BottomBarType.explore,
                text: Loc.alized.explore ?? 'Explore',
                onTap: () {
                  tabClick(BottomBarType.explore, index: 0);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.heart,
                isSelected: tabType == BottomBarType.trips,
                text: Loc.alized.trips ?? 'Trips',
                onTap: () {
                  tabClick(BottomBarType.trips, index: 1);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.user,
                isSelected: tabType == BottomBarType.profile,
                text: Loc.alized.profile ?? 'Profile',
                onTap: () {
                  tabClick(BottomBarType.profile, index: 2);
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  Widget _buildScreenByIndex(int index) {
    switch (index) {
      case 0:
        return HomeExploreScreen(animationController: _animationController);
      case 1:
        return MyTripsScreen(animationController: _animationController);
      case 2:
        return ProfileScreen(animationController: _animationController);
      default:
        return Container();
    }
  }
}

enum BottomBarType { explore, trips, profile }

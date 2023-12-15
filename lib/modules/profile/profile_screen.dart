import 'package:flutter/material.dart';
import 'package:new_motel/constants/localfiles.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/providers/auth/sharedPreferece.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:new_motel/widgets/bottom_top_move_animation_view.dart';
import '../../models/setting_list_data.dart';
import 'package:cool_alert/cool_alert.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;

  const ProfileScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SettingsListData> userSettingsList = [];

  @override
  void initState() {
    super.initState();
    _loadUserSettingsList();
    widget.animationController.forward();
  }

  Future<void> _loadUserSettingsList() async {
    userSettingsList = await SettingsListData.userSettingsList;
    setState(() {}); // Trigger a rebuild after loading the data
  }

  Widget _buildButton(
      {VoidCallback? onTap, required String text, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: MaterialButton(
        color: color,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    if (userSettingsList == null) {
      return const CircularProgressIndicator(); // Replace with your loading indicator
    }

    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(child: appBar()),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: userSettingsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    handleTap(index, context);
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  userSettingsList[index].titleTxt,
                                  style: TextStyles(context)
                                      .getRegularStyle()
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                userSettingsList[index].iconData,
                                color: AppTheme.secondaryTextColor
                                    .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Divider(
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Icon(
                Icons.info_rounded,
                color: AppTheme.primaryColor,
                size: 50,
              ),
              const SizedBox(width: 10),
              // Text(
              //   'Logout Confirmation',
              //   style: TextStyle(
              //     color: Colors.red,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 15,
              //   ),
              // ),
            ],
          ),
          content: const Text(
            'Are you sure\n you want to log out?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel logout
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                SharedPreferencesHelper.logout(context);
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: AppTheme.primaryColor,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void handleTap(int index, context) async {
    if (index == 3 && await SharedPreferencesHelper.isLoggedIn()) {
      showLogoutConfirmationDialog(context);
      // CoolAlert.show(
      //   onConfirmBtnTap: () {
      //     SharedPreferencesHelper.logout(context);
      // NavigationServices(context).gotoSignScreen();
      //   },
      //   // showCancelBtn: true,
      //   autoCloseDuration: Duration(seconds: 4),
      //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //   // animType: CoolAlertAnimType.slideInDown,
      //   context: context,
      //   type: CoolAlertType.confirm,
      //   text: 'Do you want to logout',
      //   confirmBtnText: 'Yes',
      //   cancelBtnText: 'No',
      //   confirmBtnColor: AppTheme.primaryColor,
      //   // lottieAsset: 'assets/json/Animation - 1702037851608.json'
      // );
    }
    if (index == 3 && !await SharedPreferencesHelper.isLoggedIn()) {
      NavigationServices(context).gotoSignScreen();

      //   setState(() {});
    }
    //setting screen view
    // if (index == 5) {
    //   NavigationServices(context).gotoSettingsScreen();

    //   //   setState(() {});
    // }
    //help center screen view

    if (index == 2) {
      NavigationServices(context).gotoHeplCenterScreen();
    }
    //Chage password  screen view

    // if (index == 0) {
    //   NavigationServices(context).gotoChangepasswordScreen();
    // }
    //Invite friend  screen view

    if (index == 0) {
      NavigationServices(context).gotoInviteFriend();
    }
  }

  Widget appBar() {
    return InkWell(
      onTap: () {
        NavigationServices(context).gotoEditProfile();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Loc.alized.amanda_text,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    Loc.alized.view_edit,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 24, top: 16, bottom: 16, left: 24),
            child: SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                child: Image.asset(Localfiles.userImage),
              ),
            ),
          )
        ],
      ),
    );
  }
}

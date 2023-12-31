import 'package:flutter/material.dart';
import 'package:new_motel/models/hotel_list_data.dart';
import 'package:new_motel/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:new_motel/modules/hotel_booking/filter_screen/filters_screen.dart';
import 'package:new_motel/modules/hotel_booking/hotel_home_screen.dart';
import 'package:new_motel/modules/hotel_detailes/hotel_detailes.dart';
import 'package:new_motel/modules/hotel_detailes/reviews_list_screen.dart';
import 'package:new_motel/modules/hotel_detailes/room_booking_screen.dart';
import 'package:new_motel/modules/hotel_detailes/search_screen.dart';
import 'package:new_motel/modules/login/change_password.dart';
import 'package:new_motel/modules/login/forgot_password.dart';
import 'package:new_motel/modules/login/login_screen.dart';
import 'package:new_motel/modules/login/otp_validation.dart';
import 'package:new_motel/modules/login/sign_up_screen.dart';
import 'package:new_motel/modules/payment/paymetScreen.dart';
import 'package:new_motel/modules/profile/country_screen.dart';
import 'package:new_motel/modules/profile/currency_screen.dart';
import 'package:new_motel/modules/profile/edit_profile.dart';
import 'package:new_motel/modules/profile/hepl_center_screen.dart';
import 'package:new_motel/modules/profile/how_do_screen.dart';
import 'package:new_motel/modules/profile/invite_screen.dart';
import 'package:new_motel/modules/profile/settings_screen.dart';
import 'package:new_motel/routes/routes.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  Future<dynamic> _pushMaterialPageRouteTwo(Widget widget,
      {bool fullscreenDialog = false}) async {
    return await Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }

  Future gotoSplashScreen() async {
    await Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.splash, (Route<dynamic> route) => false);
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.introductionScreen,
        (Route<dynamic> route) => false);
  }

  // void gotoOtpValidationScreen() {
  //   Navigator.pushNamedAndRemoveUntil(context, RoutesName.OTPValidationScreen,
  //       (Route<dynamic> route) => false);
  // }
  //OTPValidationScreen

  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(const LoginScreen());
  }

  Future<dynamic> gotoOtpValidationScreen(signupProvider) async {
    return await _pushMaterialPageRoute(OTPValidationScreen(
      signupProvider: signupProvider,
    ));
  }

  Future<dynamic> gotoTabScreen() async {
    return await _pushMaterialPageRouteTwo(const BottomTabScreen());
  }

  Future<dynamic> gotoSignScreen() async {
    return await _pushMaterialPageRoute(const SignUpScreen());
  }

  Future<dynamic> gotoForgotPassword() async {
    return await _pushMaterialPageRoute(const ForgotPasswordScreen());
  }

  Future<dynamic> gotoHotelDetailes(HotelListData hotelData) async {
    return await _pushMaterialPageRoute(HotelDetailes(
      hotelData: hotelData,
    ));
  }

  Future<dynamic> gotoSearchScreen() async {
    return await _pushMaterialPageRoute(const SearchScreen());
  }

  Future<dynamic> gotoHotelHomeScreen() async {
    return await _pushMaterialPageRoute(const HotelHomeScreen());
  }

  Future<dynamic> gotoFiltersScreen() async {
    return await _pushMaterialPageRoute(const FiltersScreen());
  }

  Future<dynamic> gotoRoomBookingScreen(
      String hotelname, String location) async {
    return await _pushMaterialPageRoute(RoomBookingScreen(
      location: location,
      hotelName: hotelname,
    ));
  }

  // Future<dynamic> gotoPaymentScreen(
  //   String hotelname,
  //   dynamic location,
  //   dynamic hotelData,
  //   int numberOfDays,
  //   String villaDetails,
  //   int rate,
  //   int numberOfPeople,
  // ) async {
  //   return await _pushMaterialPageRoute(MyPaymentScreen(
  //     location: location,
  //     hotelame: hotelname,
  //     numberOfDays: numberOfDays,
  //     roomName: villaDetails, // Joining list elements into a string
  //     rate: rate,
  //     numberOfPeople: numberOfPeople, hotelListData: hotelData,
  //   ));
  // }

  Future<dynamic> gotoReviewsListScreen() async {
    return await _pushMaterialPageRoute(const ReviewsListScreen());
  }

  Future<dynamic> gotoEditProfile() async {
    return await _pushMaterialPageRoute(const EditProfile());
  }

  Future<dynamic> gotoSettingsScreen() async {
    return await _pushMaterialPageRoute(const SettingsScreen());
  }

  Future<dynamic> gotoHeplCenterScreen() async {
    return await _pushMaterialPageRoute(const HeplCenterScreen());
  }

  Future<dynamic> gotoChangepasswordScreen() async {
    return await _pushMaterialPageRoute(const ChangepasswordScreen());
  }

  Future<dynamic> gotoInviteFriend() async {
    return await _pushMaterialPageRoute(const InviteFriend());
  }

  Future<dynamic> gotoCurrencyScreen() async {
    return await _pushMaterialPageRoute(const CurrencyScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoCountryScreen() async {
    return await _pushMaterialPageRoute(const CountryScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoHowDoScreen() async {
    return await _pushMaterialPageRoute(const HowDoScreen());
  }

//   void gotoHotelDetailesPage(String hotelname) async {
//     await _pushMaterialPageRoute(HotelDetailes(hotelName: hotelname));
//   }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/logic/controllers/google_map_pin_controller.dart';
import 'package:new_motel/logic/controllers/theme_provider.dart';
import 'package:new_motel/modules/login/sign_up_Screen.dart';
import 'package:new_motel/motel_app.dart';
import 'package:new_motel/providers/DateTimeProvider.dart';
import 'package:new_motel/providers/GetAllVillaDataProvider.dart';
import 'package:new_motel/providers/auth/checklogin.dart';
import 'package:new_motel/providers/auth/signupProvider.dart';
import 'package:new_motel/providers/bookingProvider.dart';
import 'package:new_motel/providers/getSingleVillaDetailsProvider.dart';
import 'package:new_motel/providers/getbookings.dart';
import 'package:new_motel/providers/homeBannerProvider.dart';
import 'package:new_motel/providers/homeVillasProvider.dart';
import 'package:new_motel/providers/serchVillaProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<Loc>(() => Loc().init(), permanent: true);
  await Get.putAsync<ThemeController>(() => ThemeController.init(),
      permanent: true);

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TimeDateViewStateProvider(),
          // child: SignUpScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignupProvider(),
          child: SignUpScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckLoginProvider(),
          // child: (),
        ),
        ChangeNotifierProvider(
          create: (context) => VillaProvider(),
          // child: (),
        ),
        ChangeNotifierProvider(
          create: (context) => GetSingleVillaDetailsProvider(),
          // child: (),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeVillaListProvider(),
          // child: (),
        ),
        ChangeNotifierProvider(
          create: (context) => BannerProvider(),
          // child: (),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchVillaProvider(),
          // child: (),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingProvider(),
          // child: (),
        ),
        ChangeNotifierProvider(
          create: (context) => GetBookingsApi(),
          // child: (),
        ),
      ],
      child: MotelApp(),
    ),
  );
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleMapPinController>(GoogleMapPinController());
  }
}

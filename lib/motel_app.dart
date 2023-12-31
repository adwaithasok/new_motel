import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_motel/common/common.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/logic/controllers/theme_provider.dart';
import 'package:new_motel/main.dart';
import 'package:new_motel/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:new_motel/modules/login/login_screen.dart';
import 'package:new_motel/modules/splash/introduction_screen.dart';
import 'package:new_motel/modules/splash/splash_screen.dart';
import 'package:new_motel/providers/auth/checklogin.dart';
import 'package:new_motel/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class MotelApp extends StatefulWidget {
  const MotelApp({Key? key}) : super(key: key);

  @override
  State<MotelApp> createState() => _MotelAppState();
}

class _MotelAppState extends State<MotelApp> {
  final CheckLoginProvider _checkLoginProvider = CheckLoginProvider();
  @override
  void initState() {
    _checkLoginProvider.checkLoggedIn(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Loc>(
      builder: (locController) {
        return GetBuilder<ThemeController>(
          builder: (controller) {
            final ThemeData theme = AppTheme.getThemeData;
            return GetMaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: const [
                Locale('en'), // English
                Locale('fr'), // French
                Locale('ja'), // Japanises
                Locale('ar'), // Arebic
              ],
              navigatorKey: navigatorKey,
              locale: locController.locale,
              title: 'villabooking',
              debugShowCheckedModeBanner: false,
              theme: theme,
              routes: _buildRoutes(),
              initialBinding: AppBinding(),
              builder: (BuildContext context, Widget? child) {
                _setFirstTimeSomeData(context, theme);
                return Directionality(
                  textDirection: locController.locale.languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: MediaQuery(
                    key: ValueKey(
                        'languageCode ${locController.locale.languageCode}'),
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: MediaQuery.of(context).size.width > 360
                          ? 1.0
                          : MediaQuery.of(context).size.width >= 340
                              ? 0.9
                              : 0.8,
                    ),
                    child: child ?? const SizedBox(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

// when this application open every time on that time we check and update some theme data
  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    _setStatusBarNavigationBarTheme(theme);
    //we call some theme basic data set in app like color, font, theme mode, language
    Get.find<ThemeController>()
        .checkAndSetThemeMode(MediaQuery.of(context).platformBrightness);
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final brightness = !kIsWeb && Platform.isAndroid
        ? themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light
        : themeData.brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      systemNavigationBarColor: themeData.backgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RoutesName.splash: (BuildContext context) => const SplashScreen(),
      // RoutesName.introductionScreen: (BuildContext context) =>
      //     const IntroductionScreen(),
      // RoutesName.home: (BuildContext context) => const BottomTabScreen(),
      // RoutesName.login: (BuildContext context) => const LoginScreen(),
    };
  }
}

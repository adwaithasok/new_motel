import 'package:flutter/material.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/providers/auth/signupProvider.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:new_motel/widgets/common_appbar_view.dart';
import 'package:new_motel/widgets/common_button.dart';
import 'package:new_motel/widgets/common_text_field_view.dart';
import 'package:new_motel/widgets/remove_focuse.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errormobileNumber = '';
  final TextEditingController _mobilenumbercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer<SignupProvider>(
          builder: (context, signupProvider, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonAppbarView(
                    iconData: Icons.arrow_back,
                    titleText: Loc.alized.login,
                    onBackClick: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CommonTextFieldView(
                            controller: _mobilenumbercontroller,
                            errorText: _errormobileNumber,
                            titleText: 'Mobile number',
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, bottom: 16),
                            hintText: 'Enter your mobile number',
                            keyboardType: TextInputType.number,
                            onChanged: (String txt) {},
                          ),
                          signupProvider.isLoading
                              ? CircularProgressIndicator()
                              : CommonButton(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, bottom: 16),
                                  buttonText: 'Get otp',
                                  onTap: () {
                                    if (_allValidation()) {
                                      print('login button pressed');
                                      signupProvider.userLogin(
                                          _mobilenumbercontroller.text,
                                          context);
                                      // NavigationServices(context).gotoOtpValidationScreen();
                                    }
                                    // NavigationServices(context).gotoOtpValidationScreen();
                                  },
                                ),
                          CommonButton(
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, bottom: 16),
                            buttonText: 'Continue as guest',
                            textColor: Theme.of(context).primaryColor,
                            onTap: () {
                              if (_allValidation()) {
                                // NavigationServices(context).gotoTabScreen();
                              }
                              NavigationServices(context).gotoTabScreen();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ]);
          },
        ),
      ),
    );
  }

  bool _allValidation() {
    bool isValid = true;
    if (_mobilenumbercontroller.text.trim().isEmpty) {
      _errormobileNumber = 'Mobile number cannot be empty';
      isValid = false;
    } else if (_mobilenumbercontroller.text.trim().length < 10 ||
        _mobilenumbercontroller.text.trim().length > 10) {
      _errormobileNumber = 'Please enter valid 10 digits number';
      isValid = false;
    } else {
      _errormobileNumber = '';
    }

    setState(() {});
    return isValid;
  }
}

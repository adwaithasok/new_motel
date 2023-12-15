import 'package:flutter/material.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/modules/login/facebook_twitter_button_view.dart';
import 'package:new_motel/providers/auth/signupProvider.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:new_motel/utils/validator.dart';
import 'package:new_motel/widgets/common_appbar_view.dart';
import 'package:new_motel/widgets/common_button.dart';
import 'package:new_motel/widgets/common_text_field_view.dart';
import 'package:new_motel/widgets/remove_focuse.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _errorEmail = '';
  final TextEditingController _emailController = TextEditingController();
  String _errormobileNumber = '';
  final TextEditingController _mobailenumberController =
      TextEditingController();
  String _errorFName = '';
  final TextEditingController _fnameController = TextEditingController();

  // final SignupProvider _signupProvider = SignupProvider();
  @override
  void initState() {
    // TODO: implement initState
    // final signupProvider = Provider.of<SignupProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final SignupProvider _signupProvider = SignupProvider();

    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _appBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<SignupProvider>(
                    builder: (context, signupProvider, child) {
                  // String emailerror = signupProvider.emailErrorMessage;
                  // final signupProvider = context.watch<SignupProvider>();

                  // print(emailerror);
                  return Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      CommonTextFieldView(
                        controller: _fnameController,
                        errorText:
                            signupProvider.nameErrorMessage ?? _errorFName,
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 24, right: 24),
                        titleText: 'Name',
                        hintText: 'Enter your name',
                        keyboardType: TextInputType.name,
                        onChanged: (String txt) {},
                      ),
                      CommonTextFieldView(
                        controller: _emailController,
                        errorText:
                            signupProvider.emailErrorMessage ?? _errorEmail,
                        titleText: Loc.alized.your_mail,
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 16),
                        hintText: Loc.alized.enter_your_email,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String txt) {},
                      ),
                      CommonTextFieldView(
                        keyboardType: TextInputType.number,
                        titleText: 'Mobile number',
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 24),
                        hintText: 'Mobile number',
                        isObscureText: false,
                        onChanged: (String txt) {},
                        errorText: signupProvider.phoneErrorMessage ??
                            _errormobileNumber,
                        controller: _mobailenumberController,
                      ),
                      signupProvider.isLoading
                          ? CircularProgressIndicator()
                          : CommonButton(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, bottom: 8),
                              buttonText: Loc.alized.sign_up,
                              onTap: () {
                                if (_allValidation()) {
                                  print("object");
                                  signupProvider.signupUser(
                                    _fnameController.text.trim(),
                                    _emailController.text.trim(),
                                    _mobailenumberController.text.trim(),
                                    context,
                                  );
                                  // NavigationServices(context)
                                  //     .gotoOtpValidationScreen(_signupProvider);
                                }
                              },
                            ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Loc.alized.terms_agreed,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Loc.alized.already_have_account,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                          InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            onTap: () {
                              NavigationServices(context).gotoLoginScreen();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                Loc.alized.login,
                                style: TextStyles(context)
                                    .getRegularStyle()
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 24,
                      )
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return CommonAppbarView(
      iconData: Icons.arrow_back,
      titleText: Loc.alized.sign_up,
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  bool _allValidation() {
    bool isValid = true;

    if (_fnameController.text.trim().isEmpty) {
      _errorFName = 'Name cannot be empty';
      isValid = false;
    } else if (_fnameController.text.contains(RegExp(r'\d'))) {
      // Check if the first name contains numbers using a regular expression
      _errorFName = 'Name should not contain numbers';
      isValid = false;
    } else {
      _errorFName = '';
    }

    if (_emailController.text.trim().isEmpty) {
      _errorEmail = Loc.alized.email_cannot_empty;
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail = Loc.alized.enter_valid_email;
      isValid = false;
    } else {
      _errorEmail = '';
    }

    if (_mobailenumberController.text.trim().isEmpty) {
      _errormobileNumber = 'Mobile number cannot be empty';
      isValid = false;
    } else if (_mobailenumberController.text.trim().length < 10) {
      _errormobileNumber = 'Please enter valid 10 digits number';
      isValid = false;
    } else {
      _errormobileNumber = '';
    }
    setState(() {});
    return isValid;
  }
}

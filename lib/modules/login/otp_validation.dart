import 'package:flutter/material.dart';
import 'package:new_motel/providers/auth/signupProvider.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPValidationScreen extends StatefulWidget {
  final SignupProvider signupProvider;

  const OTPValidationScreen({required this.signupProvider, Key? key})
      : super(key: key);

  @override
  _OTPValidationScreenState createState() => _OTPValidationScreenState();
}

class _OTPValidationScreenState extends State<OTPValidationScreen> {
  final OtpFieldController _otpFieldController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Validation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OTPTextField(
              controller: _otpFieldController,
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 60,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                widget.signupProvider.otpVerify(pin, context);
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                widget.signupProvider
                    .otpVerify(_otpFieldController.toString(), context);
              },
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

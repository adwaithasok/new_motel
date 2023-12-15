import 'package:flutter/material.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';

class CommonTextFieldView extends StatelessWidget {
  final String? titleText;
  final String hintText;
  final String? errorText;
  final bool isObscureText, isAllowTopTitleView;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const CommonTextFieldView({
    Key? key,
    this.hintText = '',
    this.isObscureText = false,
    this.padding = const EdgeInsets.only(),
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isAllowTopTitleView = true,
    this.errorText,
    this.titleText = '',
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAllowTopTitleView && titleText != '')
            Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 16, top: 4, bottom: 4),
              child: Text(
                titleText ?? "",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          Card(
            // color: Color.fromARGB(255, 228, 228, 228),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              // Add border here
              // side: BorderSide(
              //   color: Color.fromARGB(
              //       255, 149, 149, 149), // Adjust the color as needed
              //   width: 1.0, // Adjust the width as needed
              // ),
            ),
            shadowColor: Colors.black12.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.2,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: SizedBox(
                height: 48,
                child: Center(
                  child: TextField(
                    controller: controller,
                    maxLines: 1,
                    onChanged: onChanged,
                    style: TextStyles(context).getRegularStyle(),
                    obscureText: isObscureText,
                    cursorColor: Theme.of(context).primaryColor,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme
                              .primaryColor, // Border color when focused
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey, // Default border color
                          width: 1.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red, // Default border color
                          width: 1.0,
                        ),
                      ),
                      errorText: null,
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle:
                          TextStyle(color: Theme.of(context).disabledColor),
                    ),
                    keyboardType: keyboardType,
                  ),
                ),
              ),
            ),
          ),
          if (errorText != null && errorText != '')
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              child: Text(
                errorText ?? "",
                style: TextStyles(context).getDescriptionStyle().copyWith(
                      color: AppTheme.redErrorColor,
                    ),
              ),
            )
        ],
      ),
    );
  }
}

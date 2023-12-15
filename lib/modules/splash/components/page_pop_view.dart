import 'package:flutter/material.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/modules/hotel_detailes/villa_details/villa_details.dart';

class PagePopup extends StatefulWidget {
  final PageViewData imageData;
  final double opValue;
  final VoidCallback onTap;

  const PagePopup({
    Key? key,
    required this.imageData,
    this.opValue = 0.0,
    required this.onTap,
  }) : super(key: key);

  @override
  _PagePopupState createState() => _PagePopupState();
}

class _PagePopupState extends State<PagePopup> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: (MediaQuery.of(context).size.width * 1.3),
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.imageData.assetsImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 80,
            left: 24,
            right: 24,
            child: Opacity(
              opacity: widget.opValue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.imageData.titleText,
                    textAlign: TextAlign.left,
                    style: TextStyles(context)
                        .getTitleStyle()
                        .copyWith(color: AppTheme.whiteColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.imageData.subText,
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.whiteColor,
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
      ),
    );
  }
}

class PageViewData {
  final String titleText;
  final String subText;
  final String assetsImage;
  final dynamic id;

  PageViewData({
    required this.titleText,
    required this.subText,
    required this.assetsImage,
    required this.id,
  });
}

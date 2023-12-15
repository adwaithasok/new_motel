import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/language/app_localizations.dart';
import 'package:new_motel/models/homeVillaModel.dart';
import 'package:new_motel/providers/homeVillasProvider.dart';
import 'package:new_motel/widgets/list_cell_animation_view.dart';
import 'package:provider/provider.dart';

class VillaListViewPage extends StatefulWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HomeVillaModel homevillalist;
  final AnimationController animationController;
  final Animation<double> animation;

  VillaListViewPage(
      {Key? key,
      required this.animationController,
      required this.animation,
      required this.callback,
      required this.homevillalist,
      this.isShowDate = false})
      : super(key: key);

  @override
  State<VillaListViewPage> createState() => _VillaListViewPageState();
}

class _VillaListViewPageState extends State<VillaListViewPage> {
  @override
  void initState() {
    Provider.of<HomeVillaListProvider>(context, listen: false).fetchVillaList();

    // TODO: implement initState
    super.initState();
  }

  bool isInList = true;
  @override
  Widget build(BuildContext context) {
    // var HomevillaProvider = Provider.of<HomeVillaListProvider>(context);
    // var list = HomevillaProvider.villas;
    return ListCellAnimationView(
      animation: widget.animation,
      animationController: widget.animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: Container(
          // height: 150,
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // shadow color
                spreadRadius: 5, // how much the shadow spreads
                blurRadius: 7, // how blurry the shadow is
                offset: const Offset(0, 3), // offset in the x and y direction
              ),
            ],
            color: AppTheme.whiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            // border: Border.all(width: 1, color: Colors.grey)
          ),
          // elevation: 10,
          child: ClipRRect(
            child: AspectRatio(
              aspectRatio: 3,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        child: AspectRatio(
                          aspectRatio: 1.10,
                          child: Image.network(
                            'https://posmab.com/' +
                                widget.homevillalist.folder +
                                widget.homevillalist.villaImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          // color: Colors.white,
                          // padding: EdgeInsets.all(
                          //     MediaQuery.of(context).size.width >= 360
                          //         ? 12
                          //         : 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.homevillalist.villaTitle,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(
                                            fontSize: 16,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 12,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            widget.homevillalist.area
                                                .toString(),
                                            style: TextStyles(context)
                                                .getDescriptionStyle()
                                                .copyWith(
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        widget.homevillalist
                                                    .villaDiscountPrice >
                                                0
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(TextSpan(
                                                    text:
                                                        "₹${widget.homevillalist.villaBasicPrice}",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,

                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      // Add any other styles you want for the strikethrough text
                                                    ),
                                                  )),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "₹${widget.homevillalist.villaDiscountPrice}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            TextStyles(context)
                                                                .getBoldStyle()
                                                                .copyWith(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: Get.find<Loc>()
                                                                    .isRTL
                                                                ? 2.0
                                                                : 0.0),
                                                        child: Text(
                                                          '/night',
                                                          style: TextStyles(
                                                                  context)
                                                              .getDescriptionStyle(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "₹${widget.homevillalist.villaBasicPrice}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            TextStyles(context)
                                                                .getBoldStyle()
                                                                .copyWith(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: Get.find<Loc>()
                                                                    .isRTL
                                                                ? 2.0
                                                                : 0.0),
                                                        child: Text(
                                                          Loc.alized.per_night,
                                                          style: TextStyles(
                                                                  context)
                                                              .getDescriptionStyle(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      onTap: () {
                        try {
                          widget.callback();
                        } catch (_) {}
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

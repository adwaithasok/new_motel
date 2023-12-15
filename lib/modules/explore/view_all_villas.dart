import 'package:flutter/material.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/modules/hotel_detailes/villa_details/all_villa_widget.dart';
import 'package:new_motel/modules/hotel_detailes/hotel_detailes.dart';
import 'package:new_motel/modules/myTrips/hotel_list_view.dart';
import 'package:new_motel/providers/GetAllVillaDataProvider.dart';
import 'package:provider/provider.dart';

class ViewAllVillas extends StatefulWidget {
  ViewAllVillas({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewAllVillas> createState() => _ViewAllVillasState();
}

class _ViewAllVillasState extends State<ViewAllVillas>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);

    // Fetch data from the provider
    Provider.of<VillaProvider>(context, listen: false).fetchVillas();
  }

  @override
  Widget build(BuildContext context) {
    // Access the list from the provider
    var villaProvider = Provider.of<VillaProvider>(context);
    var list = villaProvider.villaList;

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button click
              Navigator.pop(context);
            },
          ),
        ),
        body: list != null
            ? Container(
                margin: EdgeInsets.only(top: 50),
                color: AppTheme.scaffoldBackgroundColor,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: list.length,
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var count = list.length > 10 ? 10 : list.length;
                    var animation =
                        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ));
                    animationController.forward();
                    return list != null
                        ? VillaListView(
                            callback: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => HotelDetailes(
                              //       hotelData: list[index],
                              //     ),
                              //   ),
                              // );
                            },
                            hotelData: list[index],
                            animation: animation,
                            animationController: animationController,
                          )
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

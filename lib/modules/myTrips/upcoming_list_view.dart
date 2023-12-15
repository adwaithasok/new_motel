import 'package:flutter/material.dart';
import 'package:new_motel/models/bookingslistmodel.dart';
import 'package:new_motel/modules/myTrips/hotel_list_view.dart';
import 'package:new_motel/providers/getbookings.dart';
import 'package:new_motel/providers/homeVillasProvider.dart';
import 'package:new_motel/routes/route_names.dart';
import 'package:provider/provider.dart';
import '../../models/hotel_list_data.dart';

class UpcomingListView extends StatefulWidget {
  final AnimationController animationController;

  const UpcomingListView({Key? key, required this.animationController})
      : super(key: key);

  @override
  State<UpcomingListView> createState() => _UpcomingListViewState();
}

class _UpcomingListViewState extends State<UpcomingListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Booking>>(
      future: Provider.of<GetBookingsApi>(context).getBookings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Container(
                  height: 30,
                  child:
                      const CircularProgressIndicator())); // or a loading indicator
        } else if (snapshot.hasError) {
          // return Text('Error: ${snapshot.error}');
          return Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('No bookings available.'),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  // decoration: BoxDecoration(
                  //     color: AppTheme.whiteColor,
                  //     border: Border.all(
                  //         color: Colors
                  //             .lightBlueAccent)),

                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.lightBlueAccent,
                    ),

                    borderRadius: BorderRadius.circular(
                        0.0), // Adjust the radius as needed
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5, top: 5, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(
                          child: Text(
                            'Log in to view your saved customer details and unlock amazing deals and much more.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 8),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.login,
                              size: 20, color: Colors.lightBlueAccent),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No bookings available.');
        } else {
          List<Booking> hotelList = snapshot.data!;

          return ListView.builder(
            itemCount: hotelList.length,
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var count = hotelList.length > 10 ? 10 : hotelList.length;
              var animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn),
                ),
              );
              widget.animationController.forward();

              return HotelListView(
                callback: () {
                  NavigationServices(context).gotoRoomBookingScreen(
                    hotelList[index].userId.toString(),
                    '',
                  );
                },
                hotelData: hotelList[index],
                animation: animation,
                animationController: widget.animationController,
                isShowDate: true,
              );
            },
          );
        }
      },
    );
  }
}

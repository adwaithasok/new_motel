// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_motel/providers/auth/sharedPreferece.dart';
import 'package:new_motel/providers/bookingProvider.dart';
import 'package:new_motel/widgets/common_text_field_view.dart';
import 'package:provider/provider.dart';

import 'package:new_motel/constants/text_styles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/models/villaDetails.dart';
import 'package:new_motel/providers/DateTimeProvider.dart';

class MyPaymentScreen extends StatefulWidget {
  final VillaDetails villaDetails;

  MyPaymentScreen({
    Key? key,
    required this.villaDetails,
  }) : super(key: key);

  @override
  State<MyPaymentScreen> createState() => _MyPaymentScreenState();
}

class _MyPaymentScreenState extends State<MyPaymentScreen> {
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  int count = 2;
  bool hasGdtNumber = false;
  String selectedTitle = 'Mr'; // Default selected title
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController registrationNumberController =
      TextEditingController();
  final TextEditingController registeredCompanyController =
      TextEditingController();
  final TextEditingController companyAddressController =
      TextEditingController();
  String _errorFName = '';
  String _errorEmail = '';
  String _errormobileNumber = '';
  String _errorlname = '';
// Add more variables for other fields if needed
  dynamic userId = '';
  bool isLoggedIn = false;

  Future<void> checkLoginStatus() async {
    bool userLoggedIn = await SharedPreferencesHelper.isLoggedIn();
    setState(() {
      isLoggedIn = userLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    var timeDateProvider = Provider.of<TimeDateViewStateProvider>(context);
    bool isFinished;
// Assuming startDate and endDate are DateTime objects representing check-in and check-out dates
    DateTime startDate = timeDateProvider.startDate; // Set your check-in date
    DateTime endDate = timeDateProvider.endDate; // Set your check-out date

// Calculate the difference between check-out and check-in
    Duration difference = endDate.difference(startDate);

// Get the number of nights
    int numberOfNights = difference.inDays;

    // print(
    //   '${widget.villaDetails.villaDiscountPrice * numberOfNights}',
    // );

    var Discountprice = widget.villaDetails.villaDiscountPrice;
// Calculate room price for the selected number of nights
    var roomPrice = Discountprice != null && Discountprice > 0
        ? Discountprice
        : widget.villaDetails.villaBasicPrice;

// Calculate total room price
    var totalRoomPrice = roomPrice! * numberOfNights;

// Administration Fee
    var administrationFee = 100;

// Calculate total price including administration fee
    var finalPrice = totalRoomPrice + administrationFee;
    var bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    print(DateFormat('yyyy-MM-dd').format(timeDateProvider.endDate));
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.13, 0.13],
            colors: [
              Theme.of(context).primaryColor.withOpacity(.72),
              Colors.white
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 20.0, right: 10, top: 20),
                children: [
                  // Hotel Details
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "Hotel Details",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.villaDetails != null
                                              ? this
                                                  .widget
                                                  .villaDetails
                                                  .villaTitle
                                                  .toString()
                                              : "Hotel name",
                                          style: TextStyle(
                                              color: AppTheme.backColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.locationDot,
                                        size: 12,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.villaDetails.area.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles(context)
                                                .getDescriptionStyle()
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                          ),
                                          const Text(','),
                                          Text(
                                            widget.villaDetails.villaCity
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles(context)
                                                .getDescriptionStyle()
                                                .copyWith(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Chek-in'.toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: AppTheme.backColor),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            DateFormat("dd, MMM").format(
                                                timeDateProvider.startDate),
                                            style: TextStyle(
                                                color: AppTheme.backColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'chek-out'.toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: AppTheme.backColor),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            DateFormat("dd, MMM").format(
                                                timeDateProvider.endDate),
                                            style: TextStyle(
                                                color: AppTheme.backColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrival and Departure
                  const SizedBox(height: 20),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "Summary",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: AppTheme.primaryColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          this
                                              .widget
                                              .villaDetails
                                              .villaTitle
                                              .toString(),
                                          style: TextStyle(
                                              color: AppTheme.backColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Discountprice != null &&
                                                      Discountprice > 0
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text.rich(TextSpan(
                                                          text:
                                                              '₹${widget.villaDetails.villaBasicPrice}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            // Add any other styles you want for the strikethrough text
                                                          ),
                                                        )),
                                                        Text(
                                                          "₹${Discountprice}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyles(
                                                                  context)
                                                              .getBoldStyle()
                                                              .copyWith(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "₹${widget.villaDetails.villaBasicPrice}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyles(
                                                                      context)
                                                                  .getBoldStyle()
                                                                  .copyWith(
                                                                    fontSize:
                                                                        22,
                                                                    color: Colors
                                                                        .black,
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
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "One room x $numberOfNights Nights",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.backColor),
                                      ),
                                      Text(
                                        totalRoomPrice.toString(),
                                        style: TextStyle(
                                            color: AppTheme.backColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: const [
                                      // You can add an Icon here if needed
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Administration Fee',
                                        style: TextStyle(
                                            color: AppTheme.backColor),
                                      ),
                                      Text(
                                        '100',
                                        style: TextStyle(
                                            color: AppTheme.backColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      // You can add an Icon here if needed
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: AppTheme.backColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        finalPrice.toString(),
                                        // '${rate * numberOfDays + 100}', // Add your calculation here
                                        style: TextStyle(
                                            color: AppTheme.backColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // You can add an Icon here if needed
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              " information",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: AppTheme.primaryColor,
                                    )),
                                color: Colors.white,
                                elevation: 19,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.0, top: 10),
                                      child: Text(
                                        'Primary Guest Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (isLoggedIn)
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
                                                    left: 5.0,
                                                    right: 5,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: const [
                                                    Expanded(
                                                      child: Text(
                                                        'Log in to view your saved customer details and unlock amazing deals and much more.',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 8),
                                                      ),
                                                    ),
                                                    Icon(Icons.login,
                                                        size: 20,
                                                        color: Colors
                                                            .lightBlueAccent),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          const SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              DropdownButton<String>(
                                                elevation: 0,
                                                underline: Container(),
                                                value: selectedTitle,
                                                items: ['Mr', 'Ms']
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedTitle =
                                                        value ?? 'Mr';
                                                  });
                                                },
                                              ),
                                              Expanded(
                                                child: CommonTextFieldView(
                                                  keyboardType:
                                                      TextInputType.name,
                                                  titleText: 'First name',
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24,
                                                          right: 24,
                                                          bottom: 25),
                                                  hintText: 'First name',
                                                  isObscureText: false,
                                                  onChanged: (String txt) {},
                                                  errorText: _errorFName,
                                                  controller:
                                                      firstNameController,
                                                  // decoration: InputDecoration(
                                                  //   labelText: 'First Name',
                                                  //   border: OutlineInputBorder(
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(
                                                  //             10.0),
                                                  //     borderSide:
                                                  //         const BorderSide(
                                                  //       color: Colors
                                                  //           .blue, // Set the border color here
                                                  //       width:
                                                  //           2.0, // Set the border width here
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 0),
                                          CommonTextFieldView(
                                            keyboardType: TextInputType.name,
                                            titleText: 'Last name',
                                            padding: const EdgeInsets.only(
                                                left: 24,
                                                right: 24,
                                                bottom: 25),
                                            hintText: 'Last name',
                                            isObscureText: false,
                                            onChanged: (String txt) {},
                                            errorText: _errorlname,
                                            controller: lastNameController,
                                            // decoration: InputDecoration(
                                            //   border: OutlineInputBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(10.0),
                                            //     borderSide: const BorderSide(
                                            //       color: Colors
                                            //           .blue, // Set the border color here
                                            //       width:
                                            //           2.0, // Set the border width here
                                            //     ),
                                            //   ),
                                            //   labelText: 'Last Name',
                                            // ),
                                          ),
                                          const SizedBox(height: 0),
                                          CommonTextFieldView(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            titleText: 'Email id',
                                            padding: const EdgeInsets.only(
                                                left: 24,
                                                right: 24,
                                                bottom: 25),
                                            hintText: 'Email id',
                                            isObscureText: false,
                                            onChanged: (String txt) {},
                                            errorText: _errorEmail,
                                            controller: emailController,
                                            // decoration: InputDecoration(
                                            //   labelText: 'Email',
                                            //   border: OutlineInputBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(10.0),
                                            //     borderSide: const BorderSide(
                                            //       color: Colors
                                            //           .blue, // Set the border color here
                                            //       width:
                                            //           2.0, // Set the border width here
                                            //     ),
                                            //   ),
                                            // ),
                                          ),
                                          const SizedBox(height: 0),
                                          CommonTextFieldView(
                                            keyboardType: TextInputType.number,
                                            titleText: 'Mobile number',
                                            padding: const EdgeInsets.only(
                                                left: 24, right: 24, bottom: 5),
                                            hintText: 'Mobile number',
                                            isObscureText: false,
                                            onChanged: (String txt) {},
                                            errorText: _errormobileNumber,
                                            controller: contactNumberController,
                                            // decoration: InputDecoration(
                                            //   labelText: 'Contact Number',
                                            //   border: OutlineInputBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(10.0),
                                            //     borderSide: const BorderSide(
                                            //       color: Colors
                                            //           .blue, // Set the border color here
                                            //       width:
                                            //           2.0, // Set the border width here
                                            //     ),
                                            //   ),
                                            // ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value:
                                                    hasGdtNumber, // Change this based on GDT number availability
                                                onChanged: (value) {
                                                  setState(() {
                                                    hasGdtNumber =
                                                        value ?? false;
                                                  });
                                                },
                                              ),
                                              const Text('I have a GDT number'),
                                            ],
                                          ),
                                          hasGdtNumber
                                              ? // Check GDT number availability
                                              Column(
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          registrationNumberController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Registration Number',
                                                      ),
                                                    ),
                                                    const SizedBox(height: 0),
                                                    TextField(
                                                      controller:
                                                          registeredCompanyController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Registered Company',
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    TextField(
                                                      controller:
                                                          companyAddressController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Company Address',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50.0, right: 0, bottom: 40),
                    child: Container(
                      margin: const EdgeInsets.only(right: 0),
                      height: 50,
                      // width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.primaryColor),
                        ),
                        onPressed: () async {
                          var userId =
                              await SharedPreferencesHelper.getUserId();
                          print('userId: $userId');

                          if (_allValidation()) {
                            // If the form is valid, proceed with the booking
                            // ignore: use_build_context_synchronously
                            bookingProvider.makeBooking(context,
                                user_id: userId ??
                                    '', // Use an empty string if userId is null
                                villa_id: widget.villaDetails.id.toString(),
                                check_in_date:
                                    '${DateFormat('yyyy-MM-dd').format(timeDateProvider.startDate)}',
                                check_out_date:
                                    '${DateFormat('yyyy-MM-dd').format(timeDateProvider.endDate)}',
                                total_price: finalPrice.toString(),
                                guest_name: firstNameController.text +
                                    lastNameController.text,
                                guest_email: emailController.text,
                                guest_contact_number:
                                    contactNumberController.text,
                                gst_number: registrationNumberController.text,
                                gst_registered_company:
                                    registeredCompanyController.text,
                                gst_company_address:
                                    companyAddressController.text,
                                villaDetails: widget.villaDetails);
                          }
                        }

                        // Handle button press
                        // payment
                        ,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'BOOK NOW',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                            // const Icon(Icons.arrow_right_rounded)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Payment Button
          ],
        ),
      ),
    );
  } // Add this method to your class

  bool _allValidation() {
    bool isValid = true;

    if (firstNameController.text.trim().isEmpty) {
      _errorFName = 'First name cannot be empty';
      isValid = false;
    } else if (firstNameController.text.contains(RegExp(r'\d'))) {
      _errorFName = 'First name should not contain numbers';
      isValid = false;
    } else {
      _errorFName = '';
    }
    if (lastNameController.text.trim().isEmpty) {
      _errorlname = 'Last name cannot be empty';
      isValid = false;
    } else if (firstNameController.text.contains(RegExp(r'\d'))) {
      _errorlname = 'Last name should not contain numbers';
      isValid = false;
    } else {
      _errorlname = '';
    }

    if (emailController.text.trim().isEmpty) {
      _errorEmail = 'Email cannot be empty';
      isValid = false;
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(emailController.text.trim())) {
      _errorEmail = 'Please enter a valid email';
      isValid = false;
    } else {
      _errorEmail = '';
    }

    if (contactNumberController.text.trim().isEmpty) {
      _errormobileNumber = 'Contact number cannot be empty';
      isValid = false;
    } else if (!RegExp(r'^[0-9]{10}$')
        .hasMatch(contactNumberController.text.trim())) {
      _errormobileNumber = 'Please enter a valid 10-digit number';
      isValid = false;
    } else {
      _errormobileNumber = '';
    }

    // Add more validation for other fields if needed

    setState(() {});
    return isValid;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CustomBookingWidget extends StatefulWidget {
  @override
  _CustomBookingWidgetState createState() => _CustomBookingWidgetState();
}

class _CustomBookingWidgetState extends State<CustomBookingWidget> {
  late DateTime _checkInDate;
  late DateTime _checkOutDate;
  int _adultsCount = 1;
  int _childrenCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Check-In Date:'),
          ElevatedButton(
            onPressed: () => _selectDate(context, isCheckIn: true),
            child: Text(_checkInDate == null
                ? 'Select Check-In Date'
                : DateFormat('yyyy-MM-dd').format(_checkInDate)),
          ),
          SizedBox(height: 16.0),
          Text('Check-Out Date:'),
          ElevatedButton(
            onPressed: () => _selectDate(context, isCheckIn: false),
            child: Text(_checkOutDate == null
                ? 'Select Check-Out Date'
                : DateFormat('yyyy-MM-dd').format(_checkOutDate)),
          ),
          SizedBox(height: 16.0),
          Text('Guests:'),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (_adultsCount > 1) {
                    setState(() {
                      _adultsCount--;
                    });
                  }
                },
              ),
              Text('Adults: $_adultsCount'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _adultsCount++;
                  });
                },
              ),
              SizedBox(width: 16.0),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (_childrenCount > 0) {
                    setState(() {
                      _childrenCount--;
                    });
                  }
                },
              ),
              Text('Children: $_childrenCount'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _childrenCount++;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _onSearch,
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isCheckIn}) async {
    DateTime currentDate = DateTime.now();
    DateTime initialDate =
        isCheckIn ? _checkInDate ?? currentDate : _checkOutDate ?? currentDate;

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 1),
    );

    if (picked != null &&
        picked != (isCheckIn ? _checkInDate : _checkOutDate)) {
      setState(() {
        isCheckIn ? _checkInDate = picked : _checkOutDate = picked;
      });
    }
  }

  void _onSearch() {
    // Implement your search functionality here
    print('Search Button Clicked');
    print('Check-In Date: $_checkInDate');
    print('Check-Out Date: $_checkOutDate');
    print('Adults: $_adultsCount');
    print('Children: $_childrenCount');
  }
}

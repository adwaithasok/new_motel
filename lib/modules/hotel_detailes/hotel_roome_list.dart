// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:new_motel/constants/localfiles.dart';
import 'package:new_motel/constants/themes.dart';
import 'package:new_motel/models/villaDetails.dart';
import 'package:new_motel/widgets/common_card.dart';

// ... (your existing imports)

class HotelRoomeList extends StatefulWidget {
  String Folder;
  List<VillaImage>? imageList;
  HotelRoomeList({
    Key? key,
    required this.Folder,
    required this.imageList,
  }) : super(key: key);

  @override
  State<HotelRoomeList> createState() => _HotelRoomeListState();
}

class _HotelRoomeListState extends State<HotelRoomeList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0, bottom: 8, right: 16, left: 16),
        itemCount: widget.imageList?.length ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _showImagePopup(context, index);
              },
              child: CommonCard(
                color: AppTheme.backgroundColor,
                radius: 8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      'https://posmab.com/' +
                          widget.Folder +
                          (widget.imageList?[index].villaImage ?? ''),
                      fit: BoxFit.cover,
                    ),

                    // Image.network(
                    //   'https://posmab.com/' +
                    //       widget.Folder +
                    //       (widget.imageList?[index].villaImage ?? ''),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showImagePopup(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              'https://posmab.com/' +
                  widget.Folder +
                  (widget.imageList?[index].villaImage ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

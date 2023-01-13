import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';

class SearchDateTime extends StatefulWidget {
  @override
  _SearchDateTimeState createState() => _SearchDateTimeState();
}

class _SearchDateTimeState extends State<SearchDateTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Any Time',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: themeColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

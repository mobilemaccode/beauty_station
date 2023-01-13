import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';

class SearchHairCut extends StatefulWidget {
  @override
  _SearchHairCutState createState() => _SearchHairCutState();
}

class _SearchHairCutState extends State<SearchHairCut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 1,
        title: TextField(
          // controller: searchController,
          cursorColor: Colors.black,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            hintText: 'Search shop, hair cut',
            filled: true,
            fillColor: Colors.grey[300],
            hintStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              decoration: TextDecoration.none,
            ),
            prefixStyle: TextStyle(color: Colors.black),
            // border: InputBorde,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 1.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.1),
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 1.0,
              ),
            ),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
              onPressed: null,
            ),
          ),
          // onChanged: onSearchTextChanged,
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

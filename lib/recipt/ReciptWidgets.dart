import 'package:beauty_station/Config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget topData(recipt) {
  return Row(
    children: [
      wBox(20.0),
      CircleAvatar(
        radius: 20.0,
        child: CircleAvatar(
          radius: 20.0,
          foregroundImage: NetworkImage(''),
        ),
      ),
      wBox(10.0),
      Column(
        children: [
          Text(
           recipt['shop_name'],
            style: TextStyle(fontSize: 17.0, color: Colors.grey.shade900),
          ),
          hBox(10.0),
          Text(
            '${recipt['treatment_name']} - ${recipt['variation_name']}',
            style: TextStyle(fontSize: 13.0, color: Colors.grey.shade500),
          ),
          hBox(10.0),

        ],
      )
    ],
  );
}

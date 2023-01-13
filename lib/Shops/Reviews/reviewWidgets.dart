import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget peopleReview(
  context,
  formKey,
  GetDitald,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Peoples Review',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      for (int i = 0; i < GetDitald.length; i++) ...[
        ListTile(
          contentPadding: EdgeInsets.only(top: 1.0),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  GetDitald[i]['customer_name'],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        GetDitald[i]['rating'],
                      ),
                    ),
                    RatingBar(
                      initialRating: double.parse(GetDitald[i]['rating']),
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 16.0,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        empty: Icon(
                          Icons.star,
                          color: Colors.black54,
                        ),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                    )
                  ],
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetDitald[i]['review'] == null
                ? Container()
                : Text(
                    GetDitald[i]['review'],
                  ),
          ),
          // trailing: Icon(
          //   Icons.add_circle_outline,
          //   color: redColor,
          // ),
        ),
      ],
    ],
  );
}

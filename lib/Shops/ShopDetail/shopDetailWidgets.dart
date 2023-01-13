import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Shops/Reviews/review.dart';
import 'package:beauty_station/Shops/VenueDetail/venueDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget shopNameAndRating(
    context, shopDetail, addFav, isFav, shop_id, isArabic, shop) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              shopDetail['shop_name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: isFav ? redColor : greyColor,
              ),
              onPressed: () => addFav(),
            )
          ],
        ),
      ),
      ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Reviews(shop_id: shop),
          ),
        ),
        // contentPadding: EdgeInsets.only(top: 1.0, left: 15.0, right: 15.0),
        title: Row(
          children: [
            Text(
              shopDetail['rating'],
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            RatingBar(
              initialRating: double.parse(shopDetail['rating']),
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 18.0,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                empty: Icon(
                  Icons.star,
                  color: Colors.black54,
                ),
              ),
              itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
            ),
            wBox(8.0),
            Text(
              isArabic ? '0 المراجعات' : '0 Reviews',
              style: TextStyle(color: Colors.indigo),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
        ),
      ),
    ],
  );
}

Widget venueDetail(context, shopDetail, isArabic) {
  return ListTile(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VenueDetail(shop_id: shopDetail['shop_id']),
      ),
    ),
    title: Text(
      isArabic ? 'عرض تفاصيل المكان' : 'View Venue Details',
      style: TextStyle(color: Colors.indigo),
    ),
    subtitle: Text(
      shopDetail['address'],
      style: TextStyle(color: Colors.indigo),
    ),
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
    ),
  );
}

Widget hairCutDetail(
    shopDetail, selectedStyle, addRemoveStyle, type, isArabic) {
  int value = type == 'top'
      ? shopDetail.length >= 3
          ? 3
          : shopDetail.length
      : shopDetail.length ?? 0;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var i = type == 'top' ? 0 : 3; i < value; i++) ...[
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${shopDetail[i]['treat_name']} - ${shopDetail[i]['name']}",
              ),
              Text(
                '€${shopDetail[i]['price']}',
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.adjust_sharp,
                size: 14,
                color: Colors.indigo,
              ),
              Text(
                isArabic ? '\t\tتفاصيل' : '\t\tDetails',
                style: TextStyle(color: Colors.indigo),
              ),
              wBox(5.0),
              Text(
                shopDetail[i]['duration'],
              ),
              Text(isArabic ? '\t\tدقيقة' : '\t\tmins')
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: IconButton(
              onPressed: () => addRemoveStyle(shopDetail[i]),
              icon: Icon(
                selectedStyle.length == 0
                    ? Icons.add_circle_outline
                    : selectedStyle.contains(shopDetail[i]['id'])
                        ? Icons.check_circle
                        : Icons.add_circle_outline,
                color: Color.fromARGB(255, 236, 103, 70),
              ),
            ),
          ),
        ),
      ],
    ],
  );
}

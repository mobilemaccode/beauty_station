import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Login/login.dart';
import 'package:beauty_station/Shops/ShopDetail/shopDetail.dart';
import 'package:beauty_station/SignUp/signup.dart';
import 'package:flutter/material.dart';

Widget favoritesList(favorites, isArabic) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: favorites.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: ListTile(
          leading: SizedBox(
            height: 100,
            width: 100,
            child: Image.network(
              'http://tenspark.com/beauty_station/upload_shop/images/${favorites[index]['shop_image'].split(',')[0]}',
              fit: BoxFit.fill,
            ),
          ),
          title: Text(
            favorites[index]['shop_name'],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\t${favorites[index]['rating']}',
                          style: TextStyle(color: Colors.orange),
                        ),
                        TextSpan(
                          text: '\t\t${favorites[index]['reviews']} Reviews',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                favorites[index]['address'],
              ),
            ],
          ),
          trailing: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShopDetail(
                    lat: favorites[index]['latitude'],
                    long: favorites[index]['longitude'],
                    catName: favorites[index]['longitude'],
                    shopName: favorites[index]['shop_name'],
                    shop_id: favorites[index]['vendor_id'] ?? ''),
              ),
            )
          },
        ),
      );
    },
  );
}

Widget loginSignUp(context, selectedLocation, isArabic) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Login(isBooking: false, selectedLocation: selectedLocation),
            ),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
        ),
        Text(
          'or',
          style: TextStyle(
            fontSize: 15.0,
            color: greyColor,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUp(),
            ),
          ),
          child: Text(
            'Create an Account',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
        ),
      ],
    ),
  );
}

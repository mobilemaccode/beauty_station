import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Shops/ShopDetail/shopDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

bool isChecked = false;
bool topRated = false;

Widget filterShow(context, getShop, isShowList, reload, isFillterAply,
    priceMethod, ratingMethod, popularityMethod, isArabic) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    height: 350.0,
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        hBox(10.0),
                        /*  GestureDetector(
                            child: Text(
                              'Recommended',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 236, 103, 70)),
                            ),
                            onTap: () => getShop()),
                        Divider(),
                        hBox(10.0),*/
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: FlatButton(
                            onPressed: () {
                              popularityMethod('1');
                              Navigator.pop(context);
                            },
                            child: isArabic
                                ? Text(
                                    'شعبية',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 236, 103, 70)),
                                  )
                                : Text(
                                    'Popularty',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 236, 103, 70)),
                                  ),
                          ),
                        ),
                        Divider(),
                        hBox(10.0),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: FlatButton(
                            onPressed: () {
                              ratingMethod('1');
                              Navigator.pop(context);
                            },
                            child: isArabic
                                ? Text(
                                    'أعلى تقييم',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 236, 103, 70)),
                                  )
                                : Text(
                                    'Highest rating',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 236, 103, 70)),
                                  ),
                          ),
                        ),

                        Divider(),
                        hBox(10.0),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: FlatButton(
                              onPressed: () {
                                priceMethod('2');
                                Navigator.pop(context);
                              },
                              child: isArabic
                                  ? Text(
                                      'أقل سعر',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 236, 103, 70)),
                                    )
                                  : Text(
                                      'Lowest price',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 236, 103, 70)),
                                    )),
                        ),
                        // GestureDetector(
                        //     child: Text(
                        //       'Lowest price',
                        //       style: TextStyle(
                        //           fontSize: 16,
                        //           color: Color.fromARGB(255, 236, 103, 70)),
                        //     ),
                        //     onTap: () {
                        //       priceMethod('2');
                        //       Navigator.pop(context);
                        //     }),
                        Divider(),
                        hBox(10.0),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: FlatButton(
                            onPressed: () {
                              priceMethod('1');
                              Navigator.pop(context);
                            },
                            child: isArabic
                                ? Text(
                                    'اغلى سعر',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 236, 103, 70)),
                                  )
                                : Text(
                                    'Highest price',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 236, 103, 70)),
                                  ),
                          ),
                        ),
                        Divider(),
                        hBox(10.0),

                        // ListTile(
                        //   leading: Icon(
                        //     Icons.swap_vert_outlined,
                        //   ),
                        //   title: Text(
                        //     'Sort',
                        //     style: TextStyle(
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                        //   trailing: Text(
                        //     'Recommended',
                        //     style: TextStyle(
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                        // ),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.note,
                        //   ),
                        //   title: Text(
                        //     'Max. Price',
                        //     style: TextStyle(
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                        //   trailing: Text(
                        //     'Any price',
                        //     style: TextStyle(
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                        // ),
                        // RangeSlider(
                        //   values: _currentSliderValue,
                        //   min: 0,
                        //   max: 1000,
                        //   inactiveColor: Colors.grey,
                        //   activeColor: Colors.red,
                        //   divisions: 50,
                        //   labels: RangeLabels(
                        //     _currentSliderValue.start.round().toString(),
                        //     _currentSliderValue.end.round().toString(),
                        //   ),
                        //   onChanged: (RangeValues values) {
                        //     setState(() {
                        //       _currentSliderValue = values;
                        //     });
                        //   },
                        // ),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.star_border,
                        //   ),
                        //   title: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'Min Rating',
                        //         style: TextStyle(
                        //           color: Colors.black54,
                        //         ),
                        //       ),
                        //       RatingBar(
                        //         initialRating: 0,
                        //         direction: Axis.horizontal,
                        //         allowHalfRating: false,
                        //         itemCount: 5,
                        //         itemSize: 20.0,
                        //         ratingWidget: RatingWidget(
                        //           full: Icon(
                        //             Icons.star,
                        //             color: Colors.yellow,
                        //           ),
                        //           empty: Icon(
                        //             Icons.star,
                        //             color: Colors.black54,
                        //           ),
                        //         ),
                        //         itemPadding:
                        //             EdgeInsets.symmetric(horizontal: 1.0),
                        //         onRatingUpdate: (rating) {
                        //           Mainrating = rating;
                        //         },
                        //       ),
                        //       // Row(
                        //       //   children: [
                        //       //     Icon(
                        //       //       Icons.star,
                        //       //       color: Colors.black54,
                        //       //     ),
                        //       //     Icon(
                        //       //       Icons.star,
                        //       //       color: Colors.black54,
                        //       //     ),
                        //       //     Icon(
                        //       //       Icons.star,
                        //       //       color: Colors.black54,
                        //       //     ),
                        //       //     Icon(
                        //       //       Icons.star,
                        //       //       color: Colors.black54,
                        //       //     ),
                        //       //     Icon(
                        //       //       Icons.star,
                        //       //       color: Colors.black54,
                        //       //     ),
                        //       //   ],
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.swap_vert_outlined,
                        //   ),
                        //   title: Text(
                        //     'Only off peak and last minute discount',
                        //     style: TextStyle(
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                        //   trailing: GestureDetector(
                        //     onTap: () {
                        //       setState(
                        //         () {
                        //           isChecked = !isChecked;
                        //         },
                        //       );
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 6.0,
                        //           ),
                        //         ],
                        //       ),
                        //       child: CustomSwitchButton(
                        //         backgroundColor: Colors.white,
                        //         unCheckedColor: Colors.grey,
                        //         animationDuration: Duration(milliseconds: 400),
                        //         checkedColor: themeColor,
                        //         checked: isChecked,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.swap_vert_outlined,
                        //   ),
                        //   title: Text(
                        //     'Only top rated venues',
                        //     style: TextStyle(
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                        //   trailing: GestureDetector(
                        //     onTap: () {
                        //       setState(
                        //         () {
                        //           topRated = !topRated;
                        //         },
                        //       );
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         /*  boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 6.0,
                        //           ),
                        //         ],*/
                        //       ),
                        //       child: CustomSwitchButton(
                        //         backgroundColor: Colors.white,
                        //         unCheckedColor: Colors.grey,
                        //         animationDuration: Duration(milliseconds: 400),
                        //         checkedColor: themeColor,
                        //         checked: topRated,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            // isFillterAply();
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Color.fromARGB(255, 236, 103, 70),
                            ),
                            child: isArabic
                                ? Text(
                                    'يلغي',
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  )
                                : Text(
                                    'Cancel',
                                    // 'Apply Filter',
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: Row(
          children: [
            wBox(15.0),
            Icon(
              Icons.add_road_outlined,
              color: Colors.red,
            ),
            wBox(8.0),
            Text(
              isArabic
                  ? 'ترتيب حسب السعر ، التصنيف ...'
                  : 'Order by price, rating ...',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      /*StatefulBuilder(builder:  (context, setState) {return */
      GestureDetector(
        onTap: () {
          reload();
        },
        child: Row(
          children: [
            Icon(
              isShowList ? Icons.add_location_alt_sharp : Icons.list,
              color: Colors.red,
            ),
            wBox(5.0),
            Text(
              isShowList
                  ? isArabic
                      ? 'خريطة'
                      : 'Map'
                  : isArabic
                      ? 'قائمة'
                      : 'List',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            wBox(15.0),
          ],
        ),
      ) /*;})*/
    ],
  );
}

Widget shopView(context, shopList, widget, isArabic) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.85,
    child: shopList.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: shopList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopDetail(
                        lat: shopList[index]['latitude'],
                        long: shopList[index]['longitude'],
                        catName: widget.catName,
                        shopName: shopList[index]['shop_name'],
                        shop_id: shopList[index]['user_id'] ?? ''),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  // color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 250.0,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Image.network(
                          'http://tenspark.com/beauty_station/upload_shop/images/${shopList[index]['shop_image'].split(',')[0]}',
                          fit: BoxFit.fill,
                        ),
                      ),
                      hBox(10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          shopList[index]['shop_name'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      hBox(5.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          shopList[index]['address'],
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                      ),
                      hBox(5.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          children: [
                            Text(
                              shopList[index]['rating'],
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                            RatingBar(
                              initialRating:
                                  double.parse(shopList[index]['rating']),
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
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 0.5),
                            ),
                            Text(
                              '${shopList[index]['view']} Reviews',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      for (var item in shopList[index]['treatment_array'])
                        ListTile(
                          title: Text(
                            "${shopList[index]['treatment_name']} - ${item['name']}",
                          ),
                          subtitle: Text(
                            '${item['duration']} min',
                          ),
                          trailing: Text(
                            '€${item['price']}',
                          ),
                        ),
                      /*  ListTile(
                        title: Text(
                          '3A sainath colony, indore, mp',
                        ),
                        subtitle: Text(
                          '15 min',
                        ),
                        trailing: Text(
                          '€42.0',
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: isArabic
                            ? Text(
                                'عرض كل الخدمات ...',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : Text(
                                'Show all services ...',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                      ),
                      hBox(20.0)
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: isArabic ? Text('المتجر غير موجود') : Text('Shop Not Found'),
          ),
  );
}

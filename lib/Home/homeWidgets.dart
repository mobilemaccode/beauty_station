import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Search/searchTreatmentAndVenue.dart';
import 'package:beauty_station/Shops/ShopList/shops.dart';
import 'package:flutter/material.dart';

Widget searchBox(context, isArabic) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchTreatmentAndVenue(),
      ),
    ),
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10.0),
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
          ),
          wBox(MediaQuery.of(context).size.width * 0.02),
          Text(
            isArabic ? 'ابحث عن العلاج والمكان' : 'Find a treatment and venue',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget heading(isArabic) {
  return Text(
    isArabic ? 'تصفح العلاج' : 'Browse Treatment',
    style: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

bool c1 = false;
bool c2 = false;
bool c3 = false;
bool c4 = false;
bool c5 = false;
bool c6 = false;
bool c7 = false;
bool c8 = false;

int indexs;

Widget categoryTreatment(
  context,
  treatmentList,
  vvv,
) {
  return StatefulBuilder(
    builder: (context, setState) {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.71,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: treatmentList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (indexs == index) {
                          indexs = -1;
                        } else {
                          indexs = index;
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage(
                            treatmentList[index]['image'],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  indexs == index
                      ? Container(
                          margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          // height: 185.0,
/*                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: whiteColor,
                            border: Border.all(
                              color: greyColor,
                              width: 0.0,
                            ),
                          ),*/
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int a = 0;
                                  a < vvv[index]['category'].length;
                                  a++) ...[
                                GestureDetector(
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Shops(
                                                catId: vvv[index]['category'][a]
                                                    ['id'],
                                                catName: vvv[index]['category']
                                                    [a]['category']),
                                            // ReciptScreen(),
                                          ),
                                        ),
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        vvv[index]['category'][a]['category'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )),
                                hBox(15.0),
                              ],
                            ],
                          ),
                        )
                      : Text(''),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

Widget dcf(
  context,
  treatmentList,
  vvv,
) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.72,
    child: StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      c1 == true ? c1 = false : c1 = true;
                      c2 = false;
                      c3 = false;
                      c4 = false;
                      c5 = false;
                      c6 = false;
                      c7 = false;
                      c8 = false;
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        treatmentList[0]['image'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              c1
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 185.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(
                          color: greyColor,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Men\'s Haircut',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Shops(),
                              ),
                            ),
                            child: Text(
                              'Ladies Haircut',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          hBox(15.0),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Shops(),
                              ),
                            ),
                            child: Text(
                              'ladies Hair Colouring',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          hBox(15.0),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Shops(),
                              ),
                            ),
                            child: Text(
                              'Ladies Root Colouring',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          hBox(15.0),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Shops(),
                              ),
                            ),
                            child: Text(
                              'Ladies Highlights',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          hBox(15.0),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Shops(),
                              ),
                            ),
                            child: Text(
                              'All Treatments',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(''),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      c1 = false;
                      c2 == true ? c2 = false : c2 = true;
                      c3 = false;
                      c4 = false;
                      c5 = false;
                      c6 = false;
                      c7 = false;
                      c8 = false;
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        treatmentList[1]['image'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              c2
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 185.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(
                          color: greyColor,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Men\'s haircut',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Haircut',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'ladies Hair Colouring',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Root Colouring',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Highlights',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'All Treatments',
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  : Text(''),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      c1 = false;
                      c2 = false;
                      c3 == true ? c3 = false : c3 = true;
                      c4 = false;
                      c5 = false;
                      c6 = false;
                      c7 = false;
                      c8 = false;
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        treatmentList[2]['image'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              c3
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 185.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(
                          color: greyColor,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hair removal',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Hair color',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // hBox(15.0),
                          // Text(
                          //   'ladies Hair Colouring',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Root Colouring',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Highlights',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'All Treatments',
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  : Text(''),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      c1 = false;
                      c2 = false;
                      c3 = false;
                      c4 == true ? c4 = false : c4 = true;
                      c5 = false;
                      c6 = false;
                      c7 = false;
                      c8 = false;
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        treatmentList[3]['image'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              c4
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 185.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(
                          color: greyColor,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nail art',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Nail polish',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // hBox(15.0),
                          // Text(
                          //   'ladies Hair Colouring',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Root Colouring',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Highlights',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'All Treatments',
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  : Text(''),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      c1 = false;
                      c2 = false;
                      c3 = false;
                      c4 = false;
                      c5 == true ? c5 = false : c5 = true;
                      c6 = false;
                      c7 = false;
                      c8 = false;
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        treatmentList[4]['image'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              c5
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 185.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(
                          color: greyColor,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Face spa',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Face cleanup',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // hBox(15.0),
                          // Text(
                          //   'ladies Hair Colouring',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Root Colouring',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'Ladies Highlights',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // hBox(15.0),
                          // Text(
                          //   'All Treatments',
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  : Text(''),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      c1 = false;
                      c2 = false;
                      c3 = false;
                      c4 = false;
                      c5 = false;
                      c6 == true ? c6 = false : c6 = true;
                      c7 = false;
                      c8 = false;
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        treatmentList[5]['image'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              c6
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 185.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(
                          color: greyColor,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Men\'s Haircut',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Haircut',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'ladies Hair Colouring',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Root Colouring',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Highlights',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'All Treatments',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(''),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      c1 = false;
                      c2 = false;
                      c3 = false;
                      c4 = false;
                      c5 = false;
                      c6 = false;
                      c7 == true ? c7 = false : c7 = true;
                      c8 = false;
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        treatmentList[6]['image'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              c7
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 185.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(
                          color: greyColor,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Men\'s Haircut',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Haircut',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'ladies Hair Colouring',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Root Colouring',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Highlights',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'All Treatments',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(''),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      c1 = false;
                      c2 = false;
                      c3 = false;
                      c4 = false;
                      c5 = false;
                      c6 = false;
                      c7 = false;
                      c8 == true ? c8 = false : c8 = true;
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        treatmentList[7]['image'],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              c8
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 185.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        border: Border.all(
                          color: greyColor,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Men\'s Haircut',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Haircut',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'ladies Hair Colouring',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Root Colouring',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'Ladies Highlights',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hBox(15.0),
                          Text(
                            'All Treatments',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(''),
            ],
          ),
        );
      },
    ),
  );
}

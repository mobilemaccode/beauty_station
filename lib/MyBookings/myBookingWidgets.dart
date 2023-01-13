import 'package:beauty_station/BookingConfirm/bookingConfirm.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Login/login.dart';
import 'package:beauty_station/RateReview/ratereview.dart';
import 'package:beauty_station/SignUp/signup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget headingView(context, isArabic) {
  return Column(
    children: [
      Text(
        isArabic ? 'سيظهر الحجز الخاص بك هنا' : 'Your Booking will appear here',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      hBox(20.0),
      Text(
        isArabic
            ? 'إذا كنت تبحث عن حجز قمت به من قبل ، فيمكنك استيراده وإدارته هنا.'
            : 'If you\'re looking for a booking you\'ve made before, you can import and manage it here.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    ],
  );
}

Widget mybooking(context, isArabic) {
  return GestureDetector(
    onTap: () {
      // isFillterAply();
      // Navigator.pop(context);
    },
    child: Container(
      alignment: Alignment.center,
      height: 40,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        border: Border.all(
          color: themeColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Text(
        isArabic ? 'استيراد الحجز الخاص بي' : 'Import my booking',
        // 'Apply Filter',
        style: TextStyle(
          color: themeColor,
        ),
      ),
    ),
  );
}

Widget loginSignUp(
  context,
  selectedLocation,
  isArabic,
) {
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
            isArabic ? 'تسجيل الدخول' : 'Login',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
        ),
        Text(
          isArabic ? 'أو' : 'or',
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
            isArabic ? 'انشئ حساب' : 'Create an Account',
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

Widget bookingItem(context, bookingList, isArabic) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.85,
    child: bookingList.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: bookingList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      // color: Colors.green,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          hBox(10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingConfirm(
                                      lat: bookingList[index]['latitude'],
                                      long: bookingList[index]['longitude'],
                                      shop_id2: bookingList[index]['shop_id'],
                                      address: bookingList[index]['address'],
                                      // catName: widget.catName,
                                      // shop_id: widget.shop_id,
                                      shopName: bookingList[index]['shop_name'],
                                      // treatmentId: widget.treatmentId,
                                      // variationId: widget.variationId,
                                      // staff_id: widget.staff_id,
                                      price: bookingList[index]['price1'],
                                      time: bookingList[index]['time'],
                                      date: bookingList[index]['date'],
                                      bookingId: bookingList[index]
                                          ['bookingId'],
                                      selectedServiceNames: bookingList[index]
                                          ['ServiceNames'],
                                      selectedEmployeList: bookingList[index]
                                          ['treatment_name'],
                                      // selectedEmployeIdList: widget.selectedEmployeIdList,
                                      // selectedDateList: widget.selectedDateList,
                                      // selectedTimeIdList: widget.selectedTimeIdList,
                                      selectedSerDuration: bookingList[index]
                                          ['Duration'],
                                      employeImageList: bookingList[index]
                                          ['employeImageList'],
                                      pagename: 'booking',
                                      priceList: bookingList[index]['price']),
                                ),
                              );
                            },
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${bookingList[index]['date'] ?? ''} ${bookingList[index]['time'] ?? ''}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hBox(10.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${bookingList[index]['treatment_name1'] ?? ''} - ${bookingList[index]['variation_name1'] ?? ''}",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.black26,
                                        )
                                      ],
                                    ),
                                  ),
                                  hBox(5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Text(
                                      bookingList[index]['shop_name'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                  hBox(10.0),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 15.0, right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      DateFormat('yyyy-MM-dd HH:mm')
                                              .parse(
                                                  '${bookingList[index]['date']} ${bookingList[index]['time']}')
                                              .isBefore(DateTime.now())
                                          ? isArabic
                                              ? 'معدل ومراجعة'
                                              : "Rate and Review"
                                          : isArabic
                                              ? 'يلغي'
                                              : "Cancel",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: DateFormat('yyyy-MM-dd HH:mm')
                                                .parse(
                                                    '${bookingList[index]['date']} ${bookingList[index]['time']}')
                                                .isBefore(DateTime.now())
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RateReview(
                                            bookingList[index]['shop_id'] ??
                                                ''),
                                      ),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   child: Text(
                                  //     "Book Again",
                                  //     style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.red,
                                  //       fontSize: 13.0,
                                  //     ),
                                  //   ),
                                  //   onTap: () => Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => Dashboard(
                                  //         currentTab: 0,
                                  //       ),
                                  //     ),
                                  //     (route) => false,
                                  //   ),
                                  // )
                                ],
                              ))
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
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child:
                Text(isArabic ? 'الحجوزات غير موجودة' : 'Bookings Not Found'),
          ),
  );
}

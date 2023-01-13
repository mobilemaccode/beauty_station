import 'package:beauty_station/Apis/Request/WsRecipt.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/WidgetLoader.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ReciptWidgets.dart';

class ReciptScreen extends StatefulWidget {
  final bookingId;

  ReciptScreen(this.bookingId);

  @override
  _ReciptScreenState createState() => _ReciptScreenState();
}

class _ReciptScreenState extends State<ReciptScreen> {
  var isLoadingAndResponse = 0;
  var reciptData = {};

  bool isArabic = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  @override
  void initState() {
    getReciptData();
    getLang();
    super.initState();
  }

  @override //i work on android and i did not test it on ios so...
  void getReciptData() async {
    var membershipRequest = WsRecipt(
      endPoint: APIManagerForm.endpoint,
      // customerId: '',
      bookingId: widget.bookingId.toString(),
    );
    await APIManagerForm.performRequest(membershipRequest, showLog: true);

    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        // progressHUD.state.dismiss();
        isLoadingAndResponse = 2;
        setState(() {
          reciptData = dataResponse['data'];
        });
      } else {
        // progressHUD.state.dismiss();
        // Constants.showToast('Server Error');
        setState(() {
          isLoadingAndResponse = 1;
        });
        var messages = dataResponse['message'];
      }
    } catch (e) {
      setState(() {
        isLoadingAndResponse = 1;
      });
      print('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            isArabic ? 'تفاصيل الطلب' : 'Order Details',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: 20.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: isLoadingAndResponse == 0
                    ? shoLoader()
                    : reciptData.length > 0
                        ? Column(children: [
                            topData(reciptData),
                            hBox(10.0),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${reciptData['variation_duration']} min',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.grey.shade500),
                                  ),
                                  Text(
                                    '€${reciptData['variation_price']}',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.grey.shade500),
                                  )
                                ]),
                            hBox(20.0),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      isArabic ? 'قسط' : "Payment ",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.grey.shade900,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            hBox(10.0),
                            Container(
                              height: 50.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        isArabic
                                            ? 'دفع المكان'
                                            : "Payment of Venue",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '€${reciptData['variation_price']}',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.white),
                                      )
                                    ]),
                              ),
                              color: Colors.indigo.shade900,
                            ),
                            hBox(20.0),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      isArabic
                                          ? 'معلومات الطلب'
                                          : "Order information",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.grey.shade900),
                                    ))),
                            hBox(10.0),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      isArabic ? 'تاريخ الحجز' : "Date booked",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey.shade500),
                                    ))),
                            hBox(5.0),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '${reciptData['booked_date']} ${reciptData['booked_time']}',
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.grey.shade800),
                                    ))),
                            hBox(10.0),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      isArabic
                                          ? 'مصدر الحجز'
                                          : "Booking source",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey.shade500),
                                    ))),
                            hBox(5.0),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      reciptData['shop_name'],
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.grey.shade800),
                                    ))),
                            hBox(10.0),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      isArabic
                                          ? 'مكان الاتصال'
                                          : "Venue Contact",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey.shade500),
                                    ))),
                            hBox(5.0),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      reciptData['shop_contact'] ?? '',
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.grey.shade800),
                                    ))),
                          ])
                        : Center(
                            child: Text(isArabic ? 'لا فاتورة' : 'No Recipt'))),
            progressHUD,
          ],
        ),
      ),
    );
  }
}

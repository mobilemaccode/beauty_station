import 'dart:async';

import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Dashboard/dashboard.dart';
import 'package:beauty_station/ManageBooking/manageBooking.dart';
import 'package:beauty_station/Shops/VenueDetail/venueDetail.dart';
import 'package:beauty_station/recipt/ReciptScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingConfirm extends StatefulWidget {
  final shop_id2;
  final address;
  // final shop_id;
  // final treatmentId;
  // final variationId;
  // final staff_id;
  var price;
  final time;
  final date;
  // final catName;
  final shopName;
  final lat;
  final long;
  final bookingId;
  final selectedServiceNames;
  final selectedEmployeList;
  // final selectedEmployeIdList;
  // final selectedDateList;
  // final selectedTimeIdList;
  final selectedSerDuration;
  final employeImageList;
  var pagename;
  final priceList;
  BookingConfirm({
    this.lat,
    this.long,
    this.shop_id2,
    this.address,
    // this.catName,
    // this.shop_id,
    this.shopName,
    // this.treatmentId,
    // this.variationId,
    // this.staff_id,
    this.price,
    this.time,
    this.date,
    this.bookingId,
    this.selectedServiceNames,
    this.selectedEmployeList,
    // this.selectedEmployeIdList,
    // this.selectedDateList,
    // this.selectedTimeIdList,
    this.selectedSerDuration,
    this.employeImageList,
    this.pagename,
    this.priceList,
  });

  @override
  _BookingConfirmState createState() => _BookingConfirmState();
}

class _BookingConfirmState extends State<BookingConfirm> {
  LatLng currentPostion;
  bool isLogin = false;

  bool isArabic = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        isLogin = prefs.getBool("isLoggedIn") ?? false;
        setState(() {});
        await getLocation();
      },
    );
    getLang();
    super.initState();
  }

  getLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          // appBar: AppBar(
          //   leading: Padding(
          //     padding: const EdgeInsets.only(top: 15.0, left: 15.0),
          //     child: GestureDetector(
          //       child: Text(
          //         'Close',
          //         style: TextStyle(
          //           color: whiteColor,
          //         ),
          //       ),
          //       onTap: () => Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => Dashboard(
          //             currentTab: 2,
          //           ),
          //         ),
          //         (route) => false,
          //       ),
          //     ),
          //   ),
          //   automaticallyImplyLeading: false,
          //   backgroundColor: Colors.teal[200],
          // ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/bg.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 25.0,
                          ),
                          child: GestureDetector(
                            child: Text(
                              isArabic ? 'يغلق' : 'Close',
                              style: TextStyle(
                                fontSize: 15,
                                color: whiteColor,
                              ),
                            ),
                            onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(
                                  currentTab: 2,
                                ),
                              ),
                              (route) => false,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 140.0,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/bookingCnf.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      hBox(20.0),
                      Text(
                        widget.shopName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                      hBox(30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.time,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 30.0,
                            ),
                          ),
                          wBox(12.0),
                          SizedBox(
                            height: 32.0,
                            child: VerticalDivider(
                              thickness: 2.0,
                              color: Colors.black,
                              width: 2.0,
                              endIndent: 2.0,
                              indent: 2.0,
                            ),
                          ),
                          wBox(12.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.pagename == 'checkout'
                                  ? Text(
                                      DateFormat('MMM-dd, EEEE')
                                          .format(widget.date),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      ),
                                    )
                                  : Text(
                                      widget.date,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      ),
                                    ),
                              Text(
                                isArabic
                                    ? 'موعد ${widget.selectedSerDuration[0]} دقيقة'
                                    : '${widget.selectedSerDuration[0]} mins appoinment',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      hBox(25.0),
                      SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            for (var i = 0;
                                i <
                                        (widget.selectedEmployeList as List)
                                            .length ??
                                    0;
                                i++) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: greyColor,
                                    foregroundImage: NetworkImage(
                                        widget.employeImageList[i]),
                                  ),
                                  wBox(8.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /* Text(
                              widget.shopName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                            hBox(5.0),*/
                                      Text(
                                        (widget.selectedEmployeList as List)[i],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      hBox(5.0),
                                      Text(
                                        (widget.selectedServiceNames
                                            as List)[i],
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      hBox(5.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isArabic
                                                ? ' دقيقة' +
                                                    widget
                                                        .selectedSerDuration[i]
                                                : '${widget.selectedSerDuration[i]} mins',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          wBox(10.0),
                                          Text(
                                            '€${(widget.priceList as List)[i]}',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ]
                          ])),
                      hBox(30.0),
                      Container(
                        height: 40,
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        color: Colors.orangeAccent.withOpacity(0.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.credit_card_rounded,
                              color: Colors.black,
                            ),
                            wBox(8.0),
                            Text(
                              isArabic
                                  ? 'للدفع في المكان €${widget.price}'
                                  : 'To pay at venue €${widget.price}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      hBox(15.0),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ManageBooking(widget.bookingId),
                          ),
                        ),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: themeColor,
                          ),
                          child: Text(
                            isArabic ? 'إدارة الحجز' : 'Manage Booking',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      hBox(15.0),
                      // Container(
                      //   height: 40,
                      //   width: double.infinity,
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.only(
                      //     left: 15.0,
                      //     right: 15.0,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: themeColor,
                      //       width: 2.0,
                      //     ),
                      //   ),
                      //   child: Text(
                      //     isArabic
                      //         ? 'أضف إلى التقويم الخاص بي'
                      //         : 'Add to my calender',
                      //     style: TextStyle(
                      //       color: themeColor,
                      //       fontSize: 14.0,
                      //     ),
                      //   ),
                      // ),
                      hBox(25.0),
                      SizedBox(
                        height: 8.0,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/divider.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      hBox(25.0),
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: currentPostion != null
                            ? GoogleMap(
                                myLocationEnabled: true,
                                mapType: MapType.normal,
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  target: currentPostion,
                                  zoom: 8,
                                ),
                                onMapCreated:
                                    (GoogleMapController controller) {},
                              )
                            : Center(
                                child: Text(
                                  isArabic ? 'تحميل ...' : 'Loading ...',
                                ),
                              ),
                      ),
                      GestureDetector(
                          onTap: () => MapsLauncher.launchCoordinates(
                              double.parse(widget.lat),
                              double.parse(widget.long),
                              widget.shopName),
                          child: Container(
                            alignment: Alignment.center,
                            height: 70.0,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            padding: EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              top: 15.0,
                            ),
                            color: whiteColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.shopName,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.indigo.shade900,
                                      ),
                                    ),
                                    Text(
                                      widget.address,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                )
                              ],
                            ),
                          )),
                      GestureDetector(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ReciptScreen(widget.bookingId),
                                ),
                              ),
                          child: isLogin
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 15.0),
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                  ),
                                  color: whiteColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isArabic ? 'إيصال' : 'Receipt',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.indigo.shade900),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                      )
                                    ],
                                  ),
                                )
                              : Text("")),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VenueDetail(shop_id: widget.shop_id2),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0),
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          color: whiteColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isArabic ? 'عرض المكان' : 'View venue',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.indigo.shade900),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            _launchURL();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 15.0),
                            padding: EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                            ),
                            color: whiteColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic ? 'مكان الدعوة' : 'Call venue',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.indigo.shade900),
                                ),
                                Text(
                                  '07314056267',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              progressHUD
            ],
          ),
        ),
        onWillPop: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(
              currentTab: 2,
            ),
          ),
          (route) => false,
        ),
      ),
    );
  }

  void _launchURL() async => await canLaunch("tel://07314056267")
      ? await launch("tel://07314056267")
      : throw 'Could not launch tel://07314056267';
}

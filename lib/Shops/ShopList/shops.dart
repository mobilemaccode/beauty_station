import 'package:beauty_station/Apis/Request/WSGetShopByCat.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/WidgetLoader.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/GoogleSearchScreen.dart';
import 'package:beauty_station/Search/searchTreatmentAndVenue.dart';
import 'package:beauty_station/Shops/ShopDetail/shopDetail.dart';
import 'package:beauty_station/Shops/ShopList/shopWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shops extends StatefulWidget {
  final catId;
  final catName;

  Shops({this.catId, this.catName});

  @override
  _ShopsState createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  List shopList = [];
  var isLoadingAndResponse = 0;
  var price = '';
  var rating = '';
  var popularity = '';
  var selectedLocationName = 'Select Address';
  final Set<Marker> markers = new Set();
  var isShowList = true;
  LatLng currentPostion = LatLng(0, 0);
  var isFillterAply = false;
  var selectedTime = null;
  var bookingDate = null;
  var latVal = null;
  var longVal = null;
  var selectlanguage = 'en';
  @override
  void initState() {
    getLang();
    getShop();
    //  _nameRetriever();
    super.initState();
  }

  bool isArabic = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
      selectlanguage = isArabic == true ? 'ar' : 'en';
      //print('isArabic.......${selectlanguage}');
    });
  }

  // void _nameRetriever() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var name = prefs.getString('country_name') ?? '';
  //   print('country_name1....${name}');
  // }

  void isFillterAplyFunc() {
    isFillterAply = true;
    getShop();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 236, 103, 70),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? Text(""),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    bookingDate = picked;
    isFillterAplyFunc();
    // dayName = '${DateFormat('EEEE').format(DateTime.now())}'.toLowerCase();
  }

  @override //i work on android and i did not test it on ios so...
  void getShop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var country_name = prefs.getString('country_name') ?? '';
    setState(() {
      isLoadingAndResponse = 0;
    });
    // progressHUD.state.show();

    var membershipRequest = WSGetShopByCat(
      endPoint: APIManagerForm.endpoint,
      cat_id: widget.catId,
      price: price,
      rating: rating,
      isFilterApply: isFillterAply,
      latVal: latVal == null ? '' : latVal.toString(),
      longVal: longVal == null ? '' : longVal.toString(),
      date: bookingDate == null
          ? null
          : '${DateFormat('yyyy-MM-dd').format(bookingDate)}',
      popularity: popularity,
      country_name: country_name.toString(),
      lang: selectlanguage.toString(),
    );
    await APIManagerForm.performRequest(membershipRequest, showLog: true);

    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        // progressHUD.state.dismiss();
        isLoadingAndResponse = 2;
        setState(() {
          shopList = dataResponse['data'];
          for (var i = 0; i < shopList.length; i++) {
            currentPostion = LatLng(double.parse(shopList[i]['latitude']),
                double.parse(shopList[i]['longitude']));
            var showLocation = LatLng(double.parse(shopList[i]['latitude']),
                double.parse(shopList[i]['longitude']));
            markers.add(Marker(
              //add first marker
              markerId: MarkerId(shopList[i]['user_id']),
              position: showLocation, //position of marker
              infoWindow: InfoWindow(
                  //popup info
                  title: shopList[i]['shop_name'],
                  snippet: shopList[i]['address'],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopDetail(
                            lat: shopList[i]['latitude'],
                            long: shopList[i]['longitude'],
                            catName: widget.catName,
                            shopName: shopList[i]['shop_name'],
                            shop_id: shopList[i]['user_id'] ?? ''),
                      ),
                    );
                  }),
              icon: BitmapDescriptor.defaultMarker, //Icon for Marker
            ));
          }
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(161.0),
          child: AppBar(
            backgroundColor: whiteColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.orange,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 45, right: 20.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchTreatmentAndVenue(),
                        ),
                      );
                    },
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
                          wBox(MediaQuery.of(context).size.width * 0.1),
                          Text(
                            widget.catName,
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
                  ),
                  hBox(5.0),
                  GestureDetector(
                    onTap: () {
                      _navigateLogin(context);
                    },
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
                            Icons.location_on_outlined,
                          ),
                          wBox(MediaQuery.of(context).size.width * 0.1),
                          Text(
                            isArabic ? 'حدد العنوان' : selectedLocationName,
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
                  ),
                  hBox(5.0),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context).then(
                        (result) => setState(
                          () {
                            selectedTime = bookingDate;
                          },
                        ),
                      );
                    },
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
                            Icons.calendar_today,
                          ),
                          wBox(MediaQuery.of(context).size.width * 0.1),
                          Text(
                            selectedTime == null
                                ? isArabic
                                    ? 'في أي وقت'
                                    : 'Any Time'
                                : '${DateFormat('yyyy-MM-dd').format(selectedTime)}',
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
                  ),
                  hBox(1.0),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: isLoadingAndResponse == 0
                  ? shoLoader()
                  : isLoadingAndResponse == 1
                      ? Center(
                          child: Text(isArabic
                              ? 'البيانات غير متوفرة'
                              : "data not available"))
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              hBox(20.0),
                              filterShow(
                                context,
                                getShop,
                                isShowList,
                                reload,
                                isFillterAplyFunc,
                                priceMethod,
                                ratingMethod,
                                popularityMethod,
                                isArabic,
                              ),
                              hBox(10.0),
                              isShowList
                                  ? shopView(
                                      context, shopList, widget, isArabic)
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.70,
                                      child: GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: currentPostion,
                                          zoom: 8,
                                        ), //Map widget from google_maps_flutter package
                                        markers:
                                            markers, //markers to show on map
                                      )),
                            ],
                          ),
                        ),
            ),
            progressHUD,
          ],
        ),
      ),
    );
  }

  void priceMethod(String value) {
    isFillterAply = true;
    price = value;
    getShop();
  }

  void popularityMethod(String value) {
    isFillterAply = true;
    popularity = value;
    getShop();
  }

  void ratingMethod(String value) {
    isFillterAply = true;
    rating = value;
    getShop();
  }

  void _navigateLogin(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return GoogleSearchScreen();
    })).then((value) {
      var detailsResult = value as DetailsResult;
      latVal = detailsResult.geometry.location.lat;
      longVal = detailsResult.geometry.location.lng;
      selectedLocationName = detailsResult.formattedAddress;
      setState(() {});
      isFillterAplyFunc();
    });
  }

  void reload() {
    setState(() {
      isShowList = !isShowList;
    });
  }
}

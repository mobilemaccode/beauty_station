import 'package:beauty_station/Apis/Request/WsStaffDetail.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/WidgetLoader.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Shops/VenueDetail/venueDetailWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VenueDetail extends StatefulWidget {
  final shop_id;

  VenueDetail({this.shop_id});

  @override
  _VenueDetailState createState() => _VenueDetailState();
}

class _VenueDetailState extends State<VenueDetail> {
  LatLng currentPostion;
  var isLoadingAndResponse = 0;
  var baseUrl = '';

  bool isArabic = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  @override //i work on android and i did not test it on ios so...
  void getShopDetail() async {
    // progressHUD.state.show();
    var membershipRequest = WsStaffDetail(
      endPoint: APIManagerForm.endpoint,
      shop_id: widget.shop_id,
    );
    await APIManagerForm.performRequest(membershipRequest, showLog: true);

    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        isLoadingAndResponse = 2;
        // progressHUD.state.dismiss();
        setState(() {
          baseUrl = dataResponse['img_url'];
          addressMap = (dataResponse["data"] as List)[0];
        });
      } else {
        // progressHUD.state.dismiss();
        // Constants.showToast('Server Error');
        isLoadingAndResponse = 1;
        var messages = dataResponse['message'];
      }
    } catch (e) {
      isLoadingAndResponse = 1;
      print('Error: ${e.toString()}');
    }
  }

  var addressMap = {
    'venue': '14-a new golden gate, hawda',
    'city': 'lucknow',
    'open': [
      {
        'day': 'monday',
        'status': 'o',
        'time': '11:00-8:00',
      },
      {
        'day': 'tuesday',
        'status': 'c',
        'time': 'closed',
      },
      {
        'day': 'wednesday',
        'status': 'o',
        'time': '11:00-8:00',
      },
      {
        'day': 'thursday',
        'status': 'o',
        'time': '11:00-8:00',
      },
      {
        'day': 'friday',
        'status': 'o',
        'time': '11:00-8:00',
      },
      {
        'day': 'saturday',
        'status': 'o',
        'time': '11:00-8:00',
      },
      {
        'day': 'sunday',
        'status': 'o',
        'time': '8:00-8:00',
      },
    ],
    'team': [
      {
        'name': 'javed shekh',
        'rating': '4.2',
        'reviews': '13',
        'about': 'Expert for army haircut',
      },
      {
        'name': 'subnam tripathi',
        'rating': '4.5',
        'reviews': '25',
        'about': 'Expert for semons haircut',
      },
      {
        'name': 'jatin khan',
        'rating': '3.9',
        'reviews': '18',
        'about': 'Expert for full body massage',
      },
      {
        'name': 'boss',
        'rating': '5.0',
        'reviews': '45',
        'about': 'Expert for foot massage',
      },
    ]
  };

  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        await getLocation();
      },
    );
    getLang();
    getShopDetail();
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
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      currentPostion != null
                          ? GoogleMap(
                              myLocationEnabled: true,
                              mapType: MapType.normal,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: currentPostion,
                                zoom: 8,
                              ),
                              onMapCreated: (GoogleMapController controller) {},
                            )
                          : Center(
                              child: Text(
                                isArabic ? 'تحميل ...' : 'Loading ...',
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.orange,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                isLoadingAndResponse == 0
                    ? shoLoader()
                    : isLoadingAndResponse == 1
                        ? Center(
                            child: Text(isArabic
                                ? 'البيانات غير متوفرة'
                                : "data not available"))
                        : Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  addressMap['venue'],
                                ),
                                hBox(10.0),
                                Text(
                                  addressMap['city'],
                                ),
                                hBox(10.0),
                                divider(1.0, 1.5, 0.0, 0.0),
                                hBox(10.0),
                                Text(
                                  isArabic ? 'قابل الفريق' : 'Meet the Team',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                teamView(addressMap['team'], context, baseUrl),
                                hBox(10.0),
                                openingDay(addressMap['timeing']),
                              ],
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

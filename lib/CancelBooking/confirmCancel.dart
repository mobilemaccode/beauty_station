import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmCancel extends StatefulWidget {
  @override
  _ConfirmCancelState createState() => _ConfirmCancelState();
}

class _ConfirmCancelState extends State<ConfirmCancel> {
  LatLng currentPostion;

  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        await getLocation();
      },
    );
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
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 220.0,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/salone.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                        child: GestureDetector(
                          child: Text(
                            'Close',
                            style: TextStyle(
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
                              (route) => false),
                        ),
                      ),
                    ],
                  ),
                  hBox(20.0),
                  Text(
                    'Kapsalone styled',
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
                        '11:20',
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
                          Text(
                            'Tuesday 18 may',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            '30 mins appoinment',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: greyColor,
                      ),
                      wBox(8.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manan Beauty saloon',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          hBox(5.0),
                          Text(
                            'With first available stylish/therapist',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  hBox(30.0),
                  Container(
                    height: 40,
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    color: Colors.red.withOpacity(0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card_rounded,
                          color: Colors.red,
                        ),
                        wBox(8.0),
                        Text(
                          'Cancelled',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  hBox(25.0),
                  SizedBox(
                    height: 8.0,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/divider.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
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
                            onMapCreated: (GoogleMapController controller) {},
                          )
                        : Center(
                            child: Text(
                              'Loading ...',
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

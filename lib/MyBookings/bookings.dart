import 'package:beauty_station/Apis/Request/WsBookingList.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/WidgetLoader.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/MyBookings/myBookingWidgets.dart';
import 'package:beauty_station/Settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking extends StatefulWidget {
  final selectedLocation;

  Booking({
    this.selectedLocation,
  });
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  bool isLogin = false;
  var cus_id = "";
  var isLoadingAndResponse = 0;
  List bookings = [];

  @override
  void initState() {
    setState(() {
      getBookings();
      getLang();
    });
    super.initState();
  }

  bool isArabic = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  @override
  getBookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool("isLoggedIn") ?? false;
    setState(() {});
    cus_id = prefs.getString("userId") ?? "";
    if (isLogin) {
      var membershipRequest = WsBookingList(
        endPoint: APIManagerForm.endpoint,
        customerId: cus_id,
      );
      await APIManagerForm.performRequest(membershipRequest, showLog: true);

      try {
        var dataResponse = membershipRequest.response;
        if (dataResponse['status'] == 'true') {
          // progressHUD.state.dismiss();
          isLoadingAndResponse = 2;
          setState(() {
            bookings = dataResponse['data'];
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: isLogin ? Colors.grey[100] : whiteColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 1,
            title: Text(
              isArabic ? 'حجوزاتي' : 'My Bookings',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              isLogin
                  ? isLoadingAndResponse == 0
                      ? shoLoader()
                      : bookingItem(context, bookings, isArabic)
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      padding: EdgeInsets.all(isLogin ? 0.0 : 20.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          hBox(MediaQuery.of(context).size.height * 0.03),
                          CircleAvatar(
                            radius: 60.0,
                            backgroundImage: AssetImage(
                                'assets/images/calender-100840914-large.jpg'),
                            backgroundColor: Colors.black26,
                          ),
                          hBox(MediaQuery.of(context).size.height * 0.07),
                          /* headingView(context, isArabic),
                          hBox(MediaQuery.of(context).size.height * 0.03),*/
                          /*   mybooking(context, isArabic),
                          //bookingItem(context, bookings),
                          hBox(MediaQuery.of(context).size.height * 0.2),*/
                          loginSignUp(
                              context, widget.selectedLocation, isArabic),
                        ],
                      ),
                    ),
              progressHUD,
            ],
          ),
        ),
      ),
    );
  }
}

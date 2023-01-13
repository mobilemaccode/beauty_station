import 'package:beauty_station/Apis/Request/WsGetFav.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/WidgetLoader.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/MyFavorites/myFavoritesWidgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFavorites extends StatefulWidget {
  final selectedLocation;

  MyFavorites({this.selectedLocation});
  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  var isLogin = false;
  var isLoadingAndResponse = 0;
  List favorites = [];
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
    getLang();

    getFavList();
    super.initState();
  }

  @override //i work on android and i did not test it on ios so...
  void getFavList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool("isLoggedIn") ?? false;
    setState(() {});
    if (isLogin) {
      var userId = prefs?.getString("userId");
      var membershipRequest = WsGetFav(
        endPoint: APIManagerForm.endpoint,
        customerId: userId,
      );
      await APIManagerForm.performRequest(membershipRequest, showLog: true);

      try {
        var dataResponse = membershipRequest.response;
        if (dataResponse['status'] == 'true') {
          // progressHUD.state.dismiss();
          isLoadingAndResponse = 2;
          setState(() {
            favorites = dataResponse['data'];
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
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        title: Text(
          isArabic ? 'مفضلتي' : 'My Favorites',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height,
            child: isLogin
                ? isLoadingAndResponse == 0
                    ? shoLoader()
                    : favorites.length > 0
                        ? favoritesList(favorites, isArabic)
                        : Center(
                            child: Text(isArabic ? 'لا مفضلة' : 'No Favourite'))
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
                        // mybooking(context),
                        //bookingItem(context, bookings),
                        // hBox(MediaQuery.of(context).size.height * 0.2),
                        loginSignUp(context, widget.selectedLocation, isArabic),
                      ],
                    ),
                  ),
          ),
          progressHUD,
        ],
      ),
    );
  }
}

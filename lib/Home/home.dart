import 'package:beauty_station/Apis/Request/WSGetServicesRequest.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Home/homeWidgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List vvv = [];
  List treatmentList = [
    {'name': 'Hair', 'image': 'assets/images/hair.png'},
    {'name': 'Men\'s hair', 'image': 'assets/images/mens hair.png'},
    {'name': 'Hair removal', 'image': 'assets/images/hair removal.png'},
    {'name': 'Nails', 'image': 'assets/images/nais.png'},
    {'name': 'Face', 'image': 'assets/images/face.png'},
    {'name': 'Massage', 'image': 'assets/images/massag.png'},
    {'name': 'Spa days & breaks', 'image': 'assets/images/spa.png'},
    {'name': 'Body', 'image': 'assets/images/body.png'},
  ];
  @override
  void initState() {
    getLang();
    getServices();
    super.initState();
  }

  bool isArabic = false;
  var selectlanguage;

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
      selectlanguage = isArabic == true ? 'ar' : 'en';
    });
  }

  @override
  void getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // progressHUD.state.show();
    var membershipRequest = WSGetServicesRequest(
      endPoint: APIManagerForm.endpoint,
      lang: selectlanguage.toString(),
    );
    await APIManagerForm.performRequest(membershipRequest, showLog: true);

    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        // progressHUD.state.dismiss();
        setState(() {
          vvv = dataResponse['data'];
        });
      } else {
        // progressHUD.state.dismiss();
        // Constants.showToast('Server Error');
        var messages = dataResponse['message'];
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/title.png',
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBox(context, isArabic),
                  hBox(10.0),
                  divider(1.0, 1.5, 0.0, 0.0),
                  hBox(10.0),
                  heading(isArabic),
                  hBox(10.0),
                  categoryTreatment(
                    context,
                    treatmentList,
                    vvv,
                  ),
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

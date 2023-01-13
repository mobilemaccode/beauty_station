import 'dart:convert';

import 'package:beauty_station/Apis/Request/WSLoginRequest.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Dashboard/dashboard.dart';
import 'package:beauty_station/Forgot_password/Forgot_Feild/Forgot_password.dart';
import 'package:beauty_station/Login/loginWigets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final isBooking;
  var selectedLocation;

  Login({this.isBooking, this.selectedLocation});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isArabic = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  void clearText() {
    logInPasswordController.clear();
  }

  @override
  void initState() {
    setState(() {
      print(widget.selectedLocation);
      getLang();
      clearText();
    });
    // TODO: implement initState
    super.initState();
  }

  void logInFun() async {
    progressHUD.state.show();
    if (widget.selectedLocation == null) {
      widget.selectedLocation = '';
    }
    var otpRequest = WSLoginRequest(
      endPoint: APIManagerForm.endpoint,
      mobile: logInMobileNumberController.text,
      password: logInPasswordController.text,
      device_token: '',
      country: widget.selectedLocation,
    );
    await APIManagerForm.performRequest(otpRequest, showLog: true);

    try {
      var dataResponse = otpRequest.response;
      print(dataResponse.toString());
      if (dataResponse['success'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'userId',
          json.encode(
            dataResponse['user_id'],
          ),
        );
        prefs?.setBool("isLoggedIn", true);
        progressHUD.state.dismiss();
        if (widget.isBooking)
          Navigator.pop(context, true);
        else
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(
                currentTab: 0,
              ),
            ),
            (route) => false,
          );
      } else {
        progressHUD.state.dismiss();
        var messages = dataResponse['msg'];
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(isArabic ? 'رسالة' : 'Message'),
              content: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  wBox(5.0),
                  Text(
                    messages,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: new Text(isArabic ? 'حسنا' : "OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
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
          leading: GestureDetector(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: Text(
                    isArabic ? 'يغلق' : 'Close',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ))),
              onTap: () => Navigator.pop(context, false)),
          /* leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context,false),
          ),*/
          centerTitle: true,
          title: Text(
            isArabic
                ? 'تسجيل الدخول باستخدام حساب BeautyStop'
                : 'Login with BeautyStop account',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
          backgroundColor: whiteColor,
          elevation: 1,
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 15.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        loginMobileNumber(typeNo, isArabic),
                        loginPassword(typeNo, isArabic),
                        hBox(20.0),
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Forgot_password(),
                                ))
                          },
                          child: Text(
                            isArabic
                                ? 'هل نسيت كلمة المرور؟'
                                : 'Forgot yor password?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 236, 103, 70)),
                          ),
                        ),
                        hBox(30.0),
                        logInBtn(context, _formKey, logInFun, isArabic),
                        hBox(30.0),
                        tNCText(context, isArabic),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            progressHUD,
          ],
        ),
      ),
    );
  }

  typeNo() {
    setState(() {});
  }
}

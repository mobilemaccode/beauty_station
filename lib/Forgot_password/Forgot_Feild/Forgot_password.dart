import 'dart:convert';

import 'package:beauty_station/Apis/Request/WsForgotPssword.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Forgot_password/OTP_feild/OTP.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Wegit_FOrgot_Pss.dart';

class Forgot_password extends StatefulWidget {
  @override
  _Forgot_passwordState createState() => _Forgot_passwordState();
}

class _Forgot_passwordState extends State<Forgot_password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isArabic = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void clearText() {
    ForgotMobileNumberController.clear();
  }

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  @override
  void initState() {
    getLang();
    // TODO: implement initState
    super.initState();
  }

  var otp;
  void logInFun(String mob) async {
    progressHUD.state.show();
    var otpRequest = WSForgotpassRequest(
      endPoint: APIManagerForm.endpoint,
      mobile: ForgotMobileNumberController.text,
      // device_token: '',
    );
    await APIManagerForm.performRequest(otpRequest, showLog: true);
    try {
      var dataResponse = otpRequest.response;
      if (dataResponse['status'] == 'true') {
        otp = dataResponse['otp'];
        var messages = dataResponse['message'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'userId',
          json.encode(
            dataResponse['user_id'],
          ),
        );
        // prefs?.setBool("isLoggedIn", true);
        progressHUD.state.dismiss();

        // if (widget.isBooking)
        //   Navigator.pop(context, true);
        // else
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OTP(mobile: mob, otp: otp),
          ),
          (route) => true,
        );
        clearText();
        showToast(messages);
        // print('hello...........>' + mob);
      } else {
        progressHUD.state.dismiss();
        var messages = dataResponse['message'];
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Message'),
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
                  child: new Text("OK"),
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
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: ListView(
                  children: [
                    hBox(50.0),
                    Text(isArabic ? 'أدخل رقم الهاتف' : 'Enter Phone No.'),
                    MobileNumber(typeNo, isArabic),
                    hBox(50.0),
                    Submit(
                      context,
                      _formKey,
                      logInFun,
                      isArabic,
                    )
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

  typeNo() {
    setState(() {});
  }
}

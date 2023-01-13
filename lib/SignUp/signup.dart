import 'dart:convert';

import 'package:beauty_station/Apis/Request/WSRegistrationRequest.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Dashboard/dashboard.dart';
import 'package:beauty_station/SignUp/signupWidgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var checkValue = false;

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
    setState(() {
      getLang();
    });
    // TODO: implement initState
    super.initState();
  }

  void signUpFun() async {
    progressHUD.state.show();
    var otpRequest = WSRegistrationRequest(
      endPoint: APIManagerForm.endpoint,
      mobile: signUpMobileNumberController.text,
      password: signUpPasswordController.text,
      name: signUpFullNameController.text,
    );
    await APIManagerForm.performRequest(otpRequest, showLog: true);

    try {
      var dataResponse = otpRequest.response;
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
              content: Container(
                height: 50,
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    wBox(5.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          messages,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
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
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
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
              onTap: () => Navigator.pop(context)),
          centerTitle: true,
          title: Text(
            isArabic ? 'أنشئ حسابك' : 'Create your Account',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          )),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 15.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      mobileNumber(typeNo, isArabic),
                      fullName(typeNo, isArabic),
                      password(typeNo, isArabic),
                      hBox(5.0),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isArabic
                                ? 'الرجاء إدخال 8 أحرف على الأقل'
                                : 'Please enter at least 8 characters',
                            style: TextStyle(fontSize: 12.0),
                          )),
                      hBox(30.0),
                      checkBox(checkValue, isArabic),
                      infoText(context, isArabic),
                      hBox(30.0),
                      signUpBtn(context, _formKey, signUpFun, isArabic),
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
    );
  }

  typeNo() {
    setState(() {});
  }
}

import 'dart:convert';

import 'package:beauty_station/Apis/Request/WsNewPassword.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Wedget_newpass.dart';

class New_password extends StatefulWidget {
  final mobile;

  New_password({
    this.mobile,
  });
  @override
  _New_passwordState createState() => _New_passwordState();
}

class _New_passwordState extends State<New_password> {
  bool isArabic = false;
  final String mobile = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  void clearText() {
    NewPasswordController.clear();
    ConfirmPasswordController.clear();
  }

  @override
  void initState() {
    getLang();
    // TODO: implement initState
    super.initState();
  }

  void NewpasswordFun(password) async {
    progressHUD.state.show();
    var otpRequest = WSNewPasswordRequest(
        endPoint: APIManagerForm.endpoint,
        mobile: widget.mobile,
        password: NewPasswordController.text
        // device_token: '',
        );
    await APIManagerForm.performRequest(otpRequest, showLog: true);

    try {
      var dataResponse = otpRequest.response;

      if (dataResponse['status'] == 'true') {
        var messages = dataResponse['message'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'userId',
          json.encode(
            dataResponse['user_id'],
          ),
        );
        prefs?.setBool("isLoggedIn", true);
        progressHUD.state.dismiss();

        // if (widget.isBooking)
        //   Navigator.pop(context, true);
        // else
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
        key: formKey,
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: ListView(
                  children: [
                    Text(isArabic
                        ? 'أدخل كلمة المرور الجديدة.'
                        : 'Enter new Password.'),
                    Password(typeNo, isArabic),
                    hBox(30.0),
                    Text(isArabic
                        ? 'أدخل تأكيد كلمة المرور'
                        : 'Enter Confirm Password'),
                    ConfirmPassword(typeNo, isArabic),
                    // _ConfirmPassword(
                    //     isArabic ? 'تأكيد كلمة المرور' : 'Confirm Password'),
                    hBox(50.0),
                    Submit(context, formKey, NewpasswordFun, isArabic)
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

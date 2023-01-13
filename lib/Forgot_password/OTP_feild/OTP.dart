import 'dart:convert';

import 'package:beauty_station/Apis/Request/WSOtpRequest.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../New_pass/New_password.dart';

final TextEditingController otpController = TextEditingController();

class OTP extends StatefulWidget {
  final mobile;
  final otp;

  OTP({this.mobile, this.otp});

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
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
    // TODO: implement initState
    super.initState();
  }

  void Otp_sub_Fun(String mobile, String otp) async {
    progressHUD.state.show();
    print('hello aman......${widget.mobile}');
    var otpRequest = WSOtpRequest(
      endPoint: APIManagerForm.endpoint,
      mobile: widget.mobile,
      otp: value,
    );
    await APIManagerForm.performRequest(otpRequest, showLog: true);
    try {
      var dataResponse = otpRequest.response;
      if (dataResponse['status'] == 'true') {
        var messages = dataResponse['message'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'id',
          json.encode(
            dataResponse['id'],
          ),
        );

        print('print id..........' + dataResponse['id'].toString());
        progressHUD.state.dismiss();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => New_password(
              mobile: mobile,
            ),
          ),
          (route) => false,
        );
        showToast(messages);
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

  var value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    hBox(50.0),
                    Text(isArabic ? 'أدخل OTP الخاص بك.' : 'Enter your OTP.'),
                    hBox(20.0),
                    OtpTextField(
                      keyboardType: TextInputType.number,
                      numberOfFields: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      borderColor: Colors.grey,
                      borderRadius: BorderRadius.circular(15.0),
                      fieldWidth: 50.0,
                      showFieldAsBox:
                          true, //set to true to show as box or false to show as dash
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
                      onSubmit: (String verificationCode) {
                        print("submit otp...." + verificationCode);
                        value = verificationCode;
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return AlertDialog(
                        //         title: Text("Verification Code"),
                        //         content: Text(
                        //             'Code entered is $verificationCode'),
                        //       );
                        //     });
                      }, // end onSubmit
                    ),
                    hBox(50.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          widget.otp.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    hBox(50.0),
                    GestureDetector(
                      onTap: () {
                        Otp_sub_Fun(widget.mobile, value.toString());
                        formKey;
                        print('click');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: (value.toString().isNotEmpty)
                              ? Color.fromARGB(255, 236, 103, 70)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          isArabic ? 'يقدم' : 'Submit',
                          style: TextStyle(
                            color: (value.toString().isNotEmpty)
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
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

  // typeNo() {
  //   setState(() {});
  // }
  //
  // Widget _OTP(typeNo) {
  //   return OTPTextField(
  //     keyboardType: TextInputType.number,
  //     length: 4,
  //     width: MediaQuery.of(context).size.width,
  //     textFieldAlignment: MainAxisAlignment.spaceAround,
  //     fieldWidth: 55,
  //     fieldStyle: FieldStyle.box,
  //     outlineBorderRadius: 15,
  //     style: TextStyle(
  //       fontSize: 17,
  //     ),
  //     onChanged: (pin) {
  //       print("Changed: " + pin);
  //       typeNo();
  //     },
  //     onCompleted: (pin) {
  //       print("Completed: " + pin);
  //     },
  //   );
  // }

  // Widget Submit(isArabic) {
  //   return GestureDetector(
  //     onTap: () {
  //       print('click');
  //       Otp_sub_Fun(value.toString());
  //       formKey;
  //     },
  //     child: Container(
  //       alignment: Alignment.center,
  //       height: 45,
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         color: Color.fromARGB(255, 236, 103, 70),
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       child: Text(
  //         isArabic ? 'يقدم' : 'Submit',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }
}

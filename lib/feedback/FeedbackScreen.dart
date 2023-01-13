import 'package:beauty_station/Apis/Request/WsFeedback.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FeedbackWidgets.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
    submitFeedback();
    // TODO: implement initState
    super.initState();
  }

  void submitFeedback() async {
    progressHUD.state.show();
    var otpRequest = WsFeedback(
      endPoint: APIManagerForm.endpoint,
      mobile: feedbackMobileNumberController.text,
      email: feedbackEmailController.text,
      name: feedbackNameController.text,
      description: feedbackDescriptionController.text,
    );
    await APIManagerForm.performRequest(otpRequest, showLog: true);

    try {
      var dataResponse = otpRequest.response;
      if (dataResponse['success'] == true) {
        progressHUD.state.dismiss();
        Navigator.pop(context);
      } else {
        progressHUD.state.dismiss();
      }
    } catch (e) {
      progressHUD.state.dismiss();
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
          backgroundColor: whiteColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            isArabic ? 'الدعم الفني والتعليقات' : 'Feedback & Support',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
        ),
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
                        fullName(typeNo, isArabic),
                        email(typeNo, isArabic),
                        mobileNumber(typeNo, isArabic),
                        description(typeNo, isArabic),
                        hBox(30.0),
                        submitButton(
                            context, _formKey, submitFeedback, isArabic),
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

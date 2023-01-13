import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyTermsCondition extends StatefulWidget {
  final title;
  final content;

  PrivacyPolicyTermsCondition({this.title, this.content});

  @override
  _PrivacyPolicyTermsConditionState createState() =>
      _PrivacyPolicyTermsConditionState();
}

class _PrivacyPolicyTermsConditionState
    extends State<PrivacyPolicyTermsCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.orange,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
    padding: EdgeInsets.all(10.0),child:Text(
            widget.content,
            style: TextStyle(color: Colors.grey, fontSize: 13.0),
          ),
        ),
        )),
    );
  }
}

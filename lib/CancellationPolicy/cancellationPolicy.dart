import 'package:beauty_station/Config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CancellationPolicy extends StatefulWidget {
  @override
  _CancellationPolicyState createState() => _CancellationPolicyState();
}

class _CancellationPolicyState extends State<CancellationPolicy> {
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
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
            isArabic ? 'سياسة الإلغاء' : 'Cancellation Policy',
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
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hBox(15.0),
              Text(
                isArabic ? 'سياسة إعادة الجدولة' : 'Reschedule policy',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              hBox(15.0),
              Text(
                isArabic
                    ? 'نحن آسفون ولكنك غير قادر على إعادة الجدولة لأن وقت الحجز قريب جدًا من موعدك.'
                    : 'We\'re sorry but you are unable to reschedule because the booking time is too close to your appointment time.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              hBox(20.0),
              Text(
                isArabic ? 'سياسة الإلغاء' : 'Cancellation policy',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              hBox(15.0),
              Text(
                isArabic
                    ? 'إذا لم تتمكن من حضور الحجز الخاص بك ، يمكنك إلغاؤه ولكن يرجى إعطاء المكان أكبر قدر ممكن من التحذير.'
                    : 'If you are unable to attend your booking you can cancel it but please give the venue as much warning as possible.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

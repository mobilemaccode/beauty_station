import 'package:beauty_station/CancelBooking/cancelBooking.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageBooking extends StatefulWidget {
  final bookingId;

  ManageBooking(this.bookingId);

  @override
  _ManageBookingState createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
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
        backgroundColor: Colors.grey[100],
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
            isArabic ? 'إدارة حجزي' : 'Manage my booking',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                color: whiteColor,
                padding: EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic ? 'سياسة إعادة الجدولة' : 'Reschedule Policy',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                    hBox(10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.black,
                          size: 8.0,
                        ),
                        wBox(8.0),
                        Expanded(
                          child: Text(
                            isArabic
                                ? 'نحن آسفون ولكنك غير قادر على إعادة الجدولة لأن وقت الحجز قريب جدًا من موعدك.'
                                : 'We\'re sorry but you are unable to reschedule because the booking time is too close to your appointment time.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            maxLines: 3,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    hBox(15.0),
                    Text(
                      isArabic ? 'سياسة الإلغاء' : 'Cancellation Policy',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                    hBox(10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.black,
                          size: 8.0,
                        ),
                        wBox(8.0),
                        Expanded(
                          child: Text(
                            isArabic
                                ? 'إذا لم تتمكن من حضور الحجز الخاص بك ، يمكنك إلغاؤه ولكن يرجى إعطاء المكان أكبر قدر ممكن من التحذير.'
                                : 'If you are unable to attend your booking you can cancel it but please give the venue as much warning as possible.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            maxLines: 3,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              hBox(15.0),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CancelBooking(widget.bookingId),
                  ),
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  margin: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isArabic ? 'إلغاء الحجز' : 'Cancel Booking',
                        style: TextStyle(
                          color: themeColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: themeColor,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

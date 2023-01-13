import 'package:beauty_station/Apis/Request/WsCancelBooking.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// https://we.tl/t-i0Bd6h34Tu
class CancelBooking extends StatefulWidget {
  final bookingId;

  CancelBooking(this.bookingId);

  @override
  _CancelBookingState createState() => _CancelBookingState();
}

class _CancelBookingState extends State<CancelBooking> {
  var reason;

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

  List reasonToCancel = [
    {
      'id': '1',
      'title': 'A patch test was required for this treatment.',
    },
    {
      'id': '2',
      'title': 'I changed my ming or booked by mistake',
    },
    {
      'id': '3',
      'title': 'I found a better deal',
    },
    {
      'id': '4',
      'title': 'I had difficulty adding my promo code',
    },
    {
      'id': '5',
      'title': 'I was advised against having this treatment by the saloon',
    },
    {
      'id': '6',
      'title': 'Unable to attend due to Coronavirus concerns',
    },
    {
      'id': '7',
      'title': 'Unforeseen circumstances, I was unable to attend',
    },
    {
      'id': '8',
      'title': 'Venue can\'t accommodate booking',
    },
    // {
    //   'id': '9',
    //   'title': '',
    // },
  ];

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
          isArabic ? 'تأكيد الالغاء' : 'Confirm Cancellation',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.red,
                      ),
                      wBox(8.0),
                      Expanded(
                        child: Text(
                          isArabic
                              ? 'انتهت فترة الإلغاء في 11/05/2021 ، 5:50 مساءً \ n هل أنت متأكد من رغبتك في الإلغاء؟ فقط لإعلامك ، نظرًا لأنك اخترت الدفع في هذا المكان ، فلن تسترد أموالك مقابل ذلك.'
                              : 'Cancellation period ended on 11/05/2021, 5:50 pm\nAre you sure you\'d like to cancel? Just to let you know, because you\'d selected to pay at this venue you will not get a refund for this.',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          maxLines: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                hBox(15.0),
                divider(1.0, 1.0, 0.0, 0.0),
                hBox(15.0),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Text(
                    isArabic
                        ? 'انتهت فترة الإلغاء في 11/05/2021 ، 5:50 مساءً \ n هل أنت متأكد من رغبتك في الإلغاء؟ فقط لإعلامك ، نظرًا لأنك اخترت الدفع في هذا المكان ، فلن تسترد أموالك مقابل ذلك.'
                        : 'Sorry to hear that. Could you tell us why?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < reasonToCancel.length; i++) ...[
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  reason = reasonToCancel[i]['title'];
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    reason == reasonToCancel[i]['title']
                                        ? Icons.check_circle_sharp
                                        : Icons.brightness_1_outlined,
                                    color: reason == reasonToCancel[i]['title']
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  wBox(8.0),
                                  Expanded(
                                    child: Text(
                                      reasonToCancel[i]['title'],
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLines: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hBox(15.0),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          progressHUD,
        ],
      ),
      bottomSheet: reason != null
          ? GestureDetector(
              onTap: () =>
                  /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmCancel(),
                ),
              ),*/
                  {
                if (reason != null) {cancelBooking()}
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
                height: 45.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: reason == null
                      ? Color.fromARGB(200, 236, 103, 70)
                      : Color.fromARGB(255, 236, 103, 70),
                ),
                child: Text(
                  isArabic ? 'إلغاء الحجز الخاص بي' : 'Cancel my booking',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 30.0),
              height: 1.0,
              width: double.infinity,
              color: Colors.transparent,
            ),
    );
  }

  void cancelBooking() async {
    progressHUD.state.show();
    var membershipRequest = WsCancelBooking(
      endPoint: APIManagerForm.endpoint,
      booking_id: widget.bookingId.toString(),
      comment: reason,
    );
    await APIManagerForm.performRequest(membershipRequest, showLog: true);
    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        showToast("booking cancelled");
        // progressHUD.state.dismiss();
        progressHUD.state.dismiss();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(
              currentTab: 2,
            ),
          ),
          (route) => false,
        );
      } else {
        progressHUD.state.dismiss();
        // Constants.showToast('Server Error');
        var messages = dataResponse['message'];
      }
    } catch (e) {
      progressHUD.state.dismiss();
      print('Error: ${e.toString()}');
    }
  }
}

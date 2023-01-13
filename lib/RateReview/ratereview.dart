import 'package:beauty_station/Apis/Request/WSRateAndReview.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateReview extends StatefulWidget {
  final shop_id;

  RateReview(this.shop_id);

  @override
  _RateReviewState createState() => _RateReviewState();
}

class _RateReviewState extends State<RateReview> {
  double givenRating = 0.0;
  final TextEditingController rateController = TextEditingController();

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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            isArabic ? 'ردود الفعل' : 'Feedback',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'قيم تجربتك' : "Rate Your Experience",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  hBox(20.0),
                  RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 30.0,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 236, 103, 70),
                      ),
                      empty: Icon(
                        Icons.star,
                        color: Colors.black54,
                      ),
                    ),
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                    onRatingUpdate: (rating) {
                      setState(() {
                        givenRating = rating;
                      });
                    },
                  ),
                  hBox(20.0),
                  Text(
                    isArabic
                        ? 'أخبرنا ما الذي يمكننا تحسينه؟'
                        : "Tell us what can we improved?",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  hBox(10.0),
                  TextField(
                      maxLines: 5,
                      controller: rateController,
                      decoration: InputDecoration(
                        hintText: isArabic
                            ? 'أخبرنا كيف يمكننا تحسين ...!'
                            : "Tell us on how we can improve...!",
                        border: OutlineInputBorder(),
                      )),
                ],
              ),
            ),
            progressHUD,
          ],
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            if (givenRating > 0) {
              rateGive();
            }
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
              height: 45.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: givenRating == 0
                    ? Color.fromARGB(200, 236, 103, 70)
                    : Color.fromARGB(255, 236, 103, 70),
              ),
              child: Container(
                child: Center(
                    child: Text(
                  isArabic ? 'يقدم' : 'Submit',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              )),
        ),
      ),
    );
  }

  void rateGive() async {
    progressHUD.state.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cus_id = prefs.getString("userId") ?? "";
    var otpRequest = WSRateAndReview(
        endPoint: APIManagerForm.endpoint,
        shop_id: widget.shop_id,
        rating: givenRating.toString(),
        review: rateController.text,
        customer_id: cus_id);
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
      print('Error: ${e.toString()}');
    }
  }
}

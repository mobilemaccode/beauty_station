import 'package:beauty_station/Apis/Request/WSGetRateAndReviewRequest.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Shops/Reviews/reviewWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reviews extends StatefulWidget {
  var shop_id;
  Reviews({this.shop_id});
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
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
    // TODO: implement initState
    super.initState();
    setState(() {
      getLang();
      GetRateGive();
    });
  }

  List GetDitald = [];
  var total_review;
  var avg_rating;
  void GetRateGive() async {
    //progressHUD.state.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cus_id = prefs.getString("userId") ?? "";
    var otpRequest = WSGatRateAndReview(
      endPoint: APIManagerForm.endpoint,
      shop_id: widget.shop_id,
    );
    await APIManagerForm.performRequest(otpRequest, showLog: true);

    try {
      var dataResponse = otpRequest.response;

      if (dataResponse['status'] == "true") {
        setState(() {
          GetDitald = dataResponse['review_by'];
          total_review = dataResponse['total_review'];
          avg_rating = dataResponse['avg_rating'];
        });

        //progressHUD.state.dismiss();
      } else {
        // progressHUD.state.dismiss();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  // var reviews = {
  //   'total': '15',
  //   'review': '4.2',
  //   'review_by': [
  //     {'name': 'kajol jain', 'rating': '4.2'},
  //     {'name': 'sumit kothari', 'rating': '4.4'},
  //     {'name': 'kapil sen', 'rating': '3.2'},
  //     {'name': 'sagar kurmi', 'rating': '5.0'},
  //   ]
  // };
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
            isArabic ? 'مراجعات المكان' : 'Venue Reviews',
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
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            avg_rating.toString(),
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 45.0,
                            ),
                          ),
                          wBox(8.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hBox(5.0),
                              avg_rating != null ? _row() : Container(),
                              hBox(5.0),
                              Text(
                                isArabic
                                    ? 'مرتكز على ${total_review.toString()} المراجعات'
                                    : 'Based on ${total_review.toString()} Reviews',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      hBox(10.0),
                      Divider(),
                      hBox(15.0),
                      peopleReview(
                        context,
                        formKey,
                        GetDitald,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            progressHUD,
          ],
        ),
      ),
    );
  }

  Widget _row() {
    return RatingBar(
      initialRating: double.parse(avg_rating),
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: 22.0,
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star,
          color: Colors.orange,
        ),
        empty: Icon(
          Icons.star,
          color: Colors.black54,
        ),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
    );
  }
}

import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;
class WSRateAndReview extends APIRequest{
  String shop_id;
  String customer_id;
  String  rating;
  String review;
  WSRateAndReview({
    endPoint,
  this.shop_id,
  this.rating,
    this.review,
    this.customer_id
  }) : super(endPoint + "add_shop_review") {}
  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["shop_id"] = this.shop_id;
    params["rating"] = this.rating;
    params["review"] = this.review;
    params["customer_id"] = this.customer_id.replaceAll(new RegExp(r'[^\w\s]+'),'');
    return params;
  }

  @override
  String parseResponse(http.Response response, bool showLog) {
    super.parseResponse(response, showLog);
    String retVal = "Problem occured in parsing the response";
    if (response.statusCode == 200) {
      try {
        Map<String, Object> responseData = jsonDecode(response.body);
        if (responseData.containsKey("success")) {
          this.response.addEntries(responseData.entries);
          retVal = "";
        }
      } catch (e) {
        retVal = e.toString();
      }
    }

    return retVal;
  }
}
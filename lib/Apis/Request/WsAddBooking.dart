import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;
class WsAddBooking extends APIRequest{
  String vendor_id;
  String customer_id;
  String  staff_id;
  String date;
  String time;
  String remark;
  String name;
  String email;
  String mobile;
  String treatmentt_ids;
  String variation_ids;
  WsAddBooking({
    endPoint,
    this.treatmentt_ids,
    this.variation_ids,
    this.vendor_id,
    this.customer_id,
    this.staff_id,
    this.date,
    this.time,
    this.remark,
    this.name,
    this.email,
    this.mobile
  }) : super(endPoint + "add_booking") {}
  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["treatment_id"] = this.treatmentt_ids;
    params["variation_id"] = this.variation_ids;
    params["vendor_id"] = this.vendor_id;
    params["customer_id"] = this.customer_id.replaceAll(new RegExp(r'[^\w\s]+'),'');
    params["staff_id"] = this.staff_id;
    params["date"] = this.date;
    params["time"] = this.time;
    params["remark"] = this.remark;
    params["name"] = this.name;
    params["email"] = this.email;
    params["mobile"] = this.mobile;
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
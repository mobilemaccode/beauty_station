import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;
class WsBookingList extends APIRequest{

  String customerId;
  WsBookingList({
    endPoint,
    this.customerId,
  }) : super(endPoint + "get_bookings") {}

  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["customer_id"] = this.customerId.replaceAll(new RegExp(r'[^\w\s]+'),'');
    return params;
  }

  @override
  String parseResponse(http.Response response, bool showLog) {
    super.parseResponse(response, showLog);
    String retVal = "Problem occured in parsing the response";
    if (response.statusCode == 200) {
      try {
        Map<String, Object> responseData = jsonDecode(response.body);

        if (responseData.containsKey("status")) {
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
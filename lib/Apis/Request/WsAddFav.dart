import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;

class WsAddFav extends APIRequest {
  String customerId;
  String vendor_id;

  WsAddFav({endPoint, this.customerId, this.vendor_id})
      : super(endPoint + "add_fav") {}

  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["customer_id"] = this.customerId.replaceAll(new RegExp(r'[^\w\s]+'),'');
    params["vendor_id"] = this.vendor_id;
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

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../request_manager.dart';

class WSForgotpassRequest extends APIRequest {
  String mobile;
  //String device_token;

  WSForgotpassRequest({
    endPoint,
    this.mobile,
    //this.device_token,
  }) : super(endPoint + "validate_mobile") {}

  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["mobile"] = this.mobile;
    //params["device_token"] = this.device_token;
    return params;
  }

//var datarespons = null;
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

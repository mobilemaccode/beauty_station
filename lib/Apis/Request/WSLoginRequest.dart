import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;

class WSLoginRequest extends APIRequest {
  String mobile;
  String password;
  String device_token;
  String country;

  WSLoginRequest(
      {endPoint, this.mobile, this.password, this.device_token, this.country})
      : super(endPoint + "login") {}

  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["mobile"] = this.mobile;
    params["password"] = this.password;
    params["device_token"] = this.device_token;
    params["country"] = this.country;
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

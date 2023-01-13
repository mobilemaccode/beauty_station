import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;

class WsFeedback extends APIRequest {
  String mobile;
  String email;
  String name;
  String description;
  WsFeedback({
    endPoint,
    this.mobile,
    this.email,
    this.name,
    this.description,
  }) : super(endPoint + "contactUs") {}

  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["name"] = this.name;
    params["email"] = this.email;
    params["mobile"] = this.mobile;
    params["description"] = this.description;
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

import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;

class WsSearch extends APIRequest {
  String name;
  String country_name;
  String lang;
  WsSearch({
    endPoint,
    this.name,
    this.country_name,
    this.lang,
  }) : super(endPoint + "venue_treatment_filteration") {}

  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["name"] = name;
    params["country_name"] = country_name;
    params["lang"] = lang;
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

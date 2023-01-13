import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;
class WSGetStaffDetail extends APIRequest{
  String treatmentt_ids;
  String variation_ids;
  WSGetStaffDetail({
    endPoint,
    this.treatmentt_ids,
    this.variation_ids
  }) : super(endPoint + "get_staff_by_treatment") {}
  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["treatment_id"] = this.treatmentt_ids;
    params["variation_id"] = this.variation_ids;
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
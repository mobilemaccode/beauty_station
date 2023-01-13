import 'package:beauty_station/Apis/request_manager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WsStaffDetail extends APIRequest{
  String shop_id;
  WsStaffDetail({
    endPoint,
    this.shop_id,
  }) : super(endPoint + "get_shop_detai_new") {}
  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["shop_id"] = this.shop_id;
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
import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;

class WsShopDetail extends APIRequest {
  String shop_id;
  String customer_id;
  String lang;
  WsShopDetail({
    endPoint,
    this.shop_id,
    this.customer_id,
    this.lang,
  }) : super(endPoint + "get_shop_allservices") {}
  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["shop_id"] = this.shop_id;
    params["vendor_id"] = this.shop_id;
    params["customer_id"] =
        this.customer_id.replaceAll(new RegExp(r'[^\w\s]+'), '');
    params["lang"] = this.lang;
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

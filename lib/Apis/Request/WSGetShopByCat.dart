import 'dart:convert';

import 'package:beauty_station/Apis/request_manager.dart';
import 'package:http/http.dart' as http;

class WSGetShopByCat extends APIRequest {
  String cat_id;
  String price;
  String rating;
  String popularity;
  bool isFilterApply;
  String latVal;
  String longVal;
  String date;
  String country_name;
  String lang;

  WSGetShopByCat({
    endPoint,
    this.cat_id,
    this.price,
    this.rating,
    this.isFilterApply,
    this.latVal,
    this.longVal,
    this.date,
    this.popularity,
    this.country_name,
    this.lang,
  }) : super(endPoint + "get_shop_list") {}

  @override
  Map<String, Object> getParams() {
    Map<String, Object> params = Map<String, Object>();
    params["cat_id"] = this.cat_id;
    print(isFilterApply);
    if (isFilterApply) {
      params["price"] = this.price == null ? '' : this.price;
      params["rating"] = this.rating == null ? '' : this.rating;
      params["lat"] = this.latVal == null ? '' : this.latVal;
      params["long"] = this.longVal == null ? '' : this.longVal;
      params["date"] = this.date == null ? '' : this.date;
      params["popularity"] = this.popularity == null ? '' : this.popularity;
    }
    params["country_name"] = this.country_name;
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

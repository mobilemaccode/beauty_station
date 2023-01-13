import 'package:beauty_station/Apis/Request/WsSearch.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Shops/ShopDetail/shopDetail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchTreatmentAndVenue extends StatefulWidget {
  @override
  _SearchTreatmentAndVenueState createState() =>
      _SearchTreatmentAndVenueState();
}

class _SearchTreatmentAndVenueState extends State<SearchTreatmentAndVenue> {
  List favorites = [];

  bool isArabic = false;
  var selectlanguage;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
      selectlanguage = isArabic == true ? 'ar' : 'en';
    });
  }

  @override //i work on android and i did not test it on ios so...
  void getFavList(text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var country_name = prefs.getString('country_name') ?? '';
    var membershipRequest = WsSearch(
      endPoint: APIManagerForm.endpoint,
      name: text,
      country_name: country_name.toString(),
      lang: selectlanguage.toString(),
    );
    await APIManagerForm.performRequest(membershipRequest, showLog: true);
    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        // progressHUD.state.dismiss();
        setState(() {
          favorites = dataResponse['data'];
        });
      } else {
        // progressHUD.state.dismiss();
        // Constants.showToast('Server Error');
        var messages = dataResponse['message'];
        setState(() {
          favorites.clear();
        });
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      setState(() {
        favorites.clear();
      });
    }
  }

  @override
  void initState() {
    getLang();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: whiteColor,
          elevation: 1,
          title: TextField(
            // controller: searchController,
            onChanged: (text) {
              getFavList(text);
            },
            cursorColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: isArabic
                  ? 'ابحث عن العلاج والمكان'
                  : 'Find a treatment and venue',
              filled: true,
              fillColor: Colors.grey[300],
              hintStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                decoration: TextDecoration.none,
              ),
              prefixStyle: TextStyle(color: Colors.black),
              // border: InputBorde,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.1),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.0,
                ),
              ),
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                onPressed: null,
              ),
            ),
            // onChanged: onSearchTextChanged,
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    isArabic ? 'يلغي' : 'Cancel',
                    style: TextStyle(
                      color: themeColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: favorites.length > 0 ? favoritesList(favorites) : Text(""),
      ),
    );
  }
}

Widget favoritesList(favorites) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: favorites.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: ListTile(
          leading: SizedBox(
            height: 100,
            width: 100,
            child: Image.network(
              'http://tenspark.com/beauty_station/upload_shop/images/${favorites[index]['shop_image'].split(',')[0]}',
              fit: BoxFit.fill,
            ),
          ),
          title: Text(
            favorites[index]['shop_name'],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\t${favorites[index]['rating']}',
                          style: TextStyle(color: Colors.orange),
                        ),
                        TextSpan(
                          text: '\t\t${favorites[index]['reviews']} Reviews',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                favorites[index]['address'],
              ),
            ],
          ),
          trailing: Icon(
            Icons.favorite,
          ),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShopDetail(
                    lat: favorites[index]['latitude'],
                    long: favorites[index]['longitude'],
                    catName: favorites[index]['longitude'],
                    shopName: favorites[index]['shop_name'],
                    shop_id: favorites[index]['vendor_id'] ?? ''),
              ),
            )
          },
        ),
      );
    },
  );
}

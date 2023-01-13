import 'dart:core';

import 'package:beauty_station/Apis/Request/WsAddFav.dart';
import 'package:beauty_station/Apis/Request/WsShopDetail.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/WidgetLoader.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Shops/ShopDetail/shopDetailWidgets.dart';
import 'package:beauty_station/Stylish/selectStylish.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopDetail extends StatefulWidget {
  final lat;
  final long;
  var shop_id;
  final shopName;
  final catName;

  ShopDetail({this.lat, this.long, this.catName, this.shopName, this.shop_id});

  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  var listPaths = [];
  var list = List();
  var isLoadingAndResponse = 0;
  var customer_id = "";
  var checkValue = false;

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

  @override
  void initState() {
    getLang();
    getShopDetail();
    super.initState();
  }

  var shop;
  @override //i work on android and i did not test it on ios so...
  void getShopDetail() async {
    // progressHUD.state.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customer_id = prefs.getString("userId") ?? "";
    var membershipRequest = WsShopDetail(
        endPoint: APIManagerForm.endpoint,
        shop_id: widget.shop_id,
        customer_id: customer_id,
        lang: '');
    await APIManagerForm.performRequest(membershipRequest, showLog: true);

    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        isLoadingAndResponse = 2;
        // progressHUD.state.dismiss();

        shopDetail = dataResponse['data'];
        shop = shopDetail['shop_id'];

        if (customer_id != "") {
          isFav = shopDetail['fav_status'] != 0;
        }
        print(shopDetail);
        var listMain = shopDetail['treatments'] as List;
        for (var i = 0; i < listMain.length; i++) {
          var listchild = listMain[i]['treatment_array'] as List;
          for (var j = 0; j < listchild.length; j++) {
            listchild[j]['treat_id'] = listMain[i]['treatment_id'];
            listchild[j]['treat_name'] = listMain[i]['treatment'];
            list.add(listchild[j]);
          }
        }
        setState(() {
          listPaths = "${shopDetail['shop_image']}".split(',');
        });
      } else {
        // progressHUD.state.dismiss();
        // Constants.showToast('Server Error');
        setState(() {
          isLoadingAndResponse = 1;
        });
        var messages = dataResponse['message'];
      }
    } catch (e) {
      setState(() {
        isLoadingAndResponse = 1;
      });
      print('Error: ${e.toString()}');
    }
  }

  int currentPos = 0;
  bool isFav = false;
  List selectedStyle = [];
  List selectedTrIds = [];
  List slectedTreatMent = [];
  List selectedEmployeList = [];
  List selectedEmployeIdList = [];
  List selectedDateList = [];
  List selectedTimeIdList = [];
  List selectedSerDuration = [];
  List employeImageList = [];
  List priceList = [];

  addRemoveStyle(chooseItem) {
    setState(() {
      if (selectedTrIds.contains(chooseItem['treat_id'])) {
        if (selectedStyle.contains(chooseItem['id'])) {
          var index = selectedTrIds.indexOf(chooseItem['treat_id']);
          selectedTrIds.remove(chooseItem['treat_id']);
          selectedSerDuration.remove(chooseItem['duration']);
          selectedStyle.removeAt(index);
          slectedTreatMent.removeAt(index);
          priceList.remove(chooseItem['price']);
        } else {
          var index = selectedTrIds.indexOf(chooseItem['treat_id']);
          selectedTrIds.remove(chooseItem['treat_id']);
          selectedStyle.removeAt(index);
          slectedTreatMent.removeAt(index);
          selectedSerDuration.removeAt(index);
          priceList.removeAt(index);
          selectedTrIds.add(chooseItem['treat_id']);
          selectedStyle.add(chooseItem['id']);
          selectedSerDuration.add(chooseItem['duration']);
          priceList.add(chooseItem['price']);
          slectedTreatMent
              .add(chooseItem['treat_name'] + "-" + chooseItem['name']);
        }
      } else {
        selectedTrIds.add(chooseItem['treat_id']);
        selectedStyle.add(chooseItem['id']);
        slectedTreatMent
            .add(chooseItem['treat_name'] + "-" + chooseItem['name']);
        selectedSerDuration.add(chooseItem['duration']);
        priceList.add(chooseItem['price']);
      }
/*
      if (selectedStyle.contains(chooseItem['id'])) {
        selectedStyle.remove(chooseItem['id']);
        if (selectedTrIds.contains(chooseItem['treat_id'])) {
          selectedTrIds.remove(chooseItem['treat_id']);
        }
      } else {
        selectedStyle.add(chooseItem['id']);
        if (!selectedTrIds.contains(chooseItem['treat_id'])) {
          selectedTrIds.add(chooseItem['treat_id']);
        }
      }
*/
    });
  }

  var shopDetail = {
    'id': '1',
    'name': 'VK saloon',
    'address': '2-r mp nagar bhopal',
    'rating': '4.2',
    'views': '15',
    'hair_style': [
      {
        'id': '1',
        'name': 'Pompadour style',
        'time': '45 min',
        'price': '25',
      },
      {
        'id': '2',
        'name': 'Blowout style',
        'time': '1hr 20 min',
        'price': '45',
      },
      {
        'id': '3',
        'name': 'Faux Hawk with Undercut',
        'time': '20 min',
        'price': '104',
      },
      {
        'id': '4',
        'name': 'Barmuda style',
        'time': '45 min',
        'price': '25',
      },
      {
        'id': '5',
        'name': 'StickBond hair style',
        'time': '1hr 20 min',
        'price': '45',
      },
      {
        'id': '6',
        'name': 'Blowout style',
        'time': '1hr 20 min',
        'price': '45',
      },
      {
        'id': '7',
        'name': 'Faux Hawk with Undercut',
        'time': '20 min',
        'price': '104',
      },
      {
        'id': '8',
        'name': 'Pompadour style',
        'time': '45 min',
        'price': '25',
      },
      {
        'id': '9',
        'name': 'Faux Hawk with Undercut',
        'time': '20 min',
        'price': '104',
      },
    ]
  };

  void addFav() async {
    if (customer_id != "") {
      var membershipRequest = WsAddFav(
        endPoint: APIManagerForm.endpoint,
        customerId: customer_id,
        vendor_id: widget.shop_id,
      );
      await APIManagerForm.performRequest(membershipRequest, showLog: true);

      try {
        var dataResponse = membershipRequest.response;
        if (dataResponse['status'] == 'true') {
          setState(() {
            isFav = !isFav;
          });
          // showToast(isFav ? 'Add to Wishlist' : 'Remove from Wishlist');
        } else {
          // progressHUD.state.dismiss();
          // Constants.showToast('Server Error');
          setState(() {
            isFav = !isFav;
          });
          // showToast(isFav ? 'Add to Wishlist' : 'Remove from Wishlist');
          var messages = dataResponse['message'];
        }
      } catch (e) {
        print('Error: ${e.toString()}');
      }
    } else {
      showToast(isArabic ? 'الرجاء تسجيل الدخول أولا' : "Please login first");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding:
              EdgeInsets.only(bottom: selectedStyle.length != 0 ? 70.0 : 0.0),
          width: double.infinity,
          child: isLoadingAndResponse == 0
              ? shoLoader()
              : isLoadingAndResponse == 1
                  ? Center(
                      child: Text(isArabic
                          ? 'البيانات غير متوفرة'
                          : "data not available"))
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 250.0,
                              autoPlay: false,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(
                                  () {
                                    currentPos = index;
                                  },
                                );
                              },
                            ),
                            items: listPaths
                                .map(
                                  (item) => Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 250,
                                        child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.network(
                                              'http://tenspark.com/beauty_station/upload_shop/images/$item',
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 40.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_back_ios_rounded,
                                                    color: whiteColor,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                /*IconButton(
                                                  icon: Icon(
                                                    Icons.ios_share,
                                                    color: whiteColor,
                                                  ),
                                                  onPressed: () => shareApp(context),
                                                )*/
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: listPaths.map(
                                              (url) {
                                                int index =
                                                    listPaths.indexOf(url);
                                                return Container(
                                                  width: 8.0,
                                                  height: 8.0,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 2.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: currentPos == index
                                                        ? whiteColor
                                                        : greyColor,
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                          shopNameAndRating(context, shopDetail, addFav, isFav,
                              widget.shop_id, isArabic, shop),
                          divider(1.0, 1.5, 0.0, 0.0),
                          venueDetail(context, shopDetail, isArabic),
                          SizedBox(
                            height: 8.0,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/divider.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          hBox(10.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              isArabic
                                  ? ' نتائج ${widget.catName}'
                                  : 'Results for ${widget.catName}',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          hairCutDetail(list, selectedStyle, addRemoveStyle,
                              'top', isArabic),
                          divider(1.0, 1.5, 0.0, 0.0),
                          hBox(15.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              isArabic ? 'قائمة كاملة' : 'Full Menu',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          hairCutDetail(list, selectedStyle, addRemoveStyle,
                              'full', isArabic),
                        ],
                      ),
                    ),
        ),
        bottomSheet: selectedStyle.length != 0
            ? GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectStylish(
                        lat: widget.lat,
                        long: widget.long,
                        catName: widget.catName,
                        shopName: widget.shopName,
                        shop_id: widget.shop_id,
                        shop_id2: shopDetail['shop_id'],
                        address: shopDetail['address'],
                        treatmentId: selectedTrIds.join(","),
                        variationId: selectedStyle.join(","),
                        index: 0,
                        priceList: priceList,
                        selectedServiceNames: slectedTreatMent,
                        selectedEmployeList: selectedEmployeList,
                        selectedEmployeIdList: selectedEmployeIdList,
                        selectedDateList: selectedDateList,
                        selectedTimeIdList: selectedTimeIdList,
                        selectedSerDuration: selectedSerDuration,
                        employeImageList: employeImageList),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
                  height: 45.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color.fromARGB(255, 236, 103, 70),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      wBox(MediaQuery.of(context).size.width * 0.01),
                      Text(
                        isArabic ? 'التحقق من الصلاحية' : 'Check Availability',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        selectedStyle.length.toString(),
                        style: TextStyle(
                          fontSize: 15.0,
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 30.0),
                height: 1.0,
                width: double.infinity,
                color: Colors.transparent,
              ),
      ),
    );
  }

  void shareApp(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(
        isArabic
            ? ' يرجى تنزيل تطبيق Beauty Station والتحقق من ذلك ${widget.shopName}'
            : 'Please download Beauty Station App and check ${widget.shopName}',
        subject: "",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

    /* await Share.share(
        'Please download Beauty Station App and check ${widget.shopName}');*/
  }
}

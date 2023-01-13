import 'package:beauty_station/Apis/Request/WSGetStaffDetail.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/AppoinmentDateTime/appoinmentDateTime.dart';
import 'package:beauty_station/Config/WidgetLoader.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectStylish extends StatefulWidget {
  final shop_id;
  final treatmentId;
  final variationId;
  final catName;
  final shopName;
  final shop_id2;
  final address;
  final lat;
  final long;
  final index;
  final selectedServiceNames;
  final selectedEmployeList;
  final selectedEmployeIdList;
  final selectedDateList;
  final selectedTimeIdList;
  final selectedSerDuration;
  final employeImageList;
  final priceList;
  SelectStylish(
      {this.lat,
      this.long,
      this.catName,
      this.shopName,
      this.shop_id,
      this.shop_id2,
      this.address,
      this.treatmentId,
      this.variationId,
      this.index,
      this.priceList,
      this.selectedServiceNames,
      this.selectedEmployeList,
      this.selectedEmployeIdList,
      this.selectedDateList,
      this.selectedTimeIdList,
      this.selectedSerDuration,
      this.employeImageList,
      staff_id});

  @override
  _SelectStylishState createState() => _SelectStylishState();
}

class _SelectStylishState extends State<SelectStylish> {
  bool isSelectStylesh = false;
  var stylishName;
  var selectedImage;
  var stylishId;
  var price;
  var baseUrl = '';
  var isLoadingAndResponse = 0;
  bool isArabic = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  List stylish = [
    {
      'name': 'samar khan',
      'rate': '40.0',
    },
    {
      'name': 'javed habib',
      'rate': '100.0',
    },
    {
      'name': 'sunena',
      'rate': '58.0',
    },
    {
      'name': 'preet k',
      'rate': '40.0',
    },
  ];

  @override
  void initState() {
    print('hello..${widget.priceList}');
    print('hello..${widget.selectedSerDuration}');
    getStylist();
    getLang();
    super.initState();
  }

  @override //i work on android and i did not test it on ios so...
  void getStylist() async {
    // progressHUD.state.show();
    var result = widget.treatmentId.split(",")[widget.index];
    var resultVar = widget.variationId.split(",")[widget.index];
    var membershipRequest = WSGetStaffDetail(
      endPoint: APIManagerForm.endpoint,
      treatmentt_ids: result,
      variation_ids: resultVar,
    );
    await APIManagerForm.performRequest(membershipRequest, showLog: true);

    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        isLoadingAndResponse = 2;
        stylish.clear();
        // progressHUD.state.dismiss();
        // stylish = dataResponse['data'];
        baseUrl = dataResponse['staff_img_url'];
        var listMain = dataResponse['data'] as List;
        print(listMain);
        for (var i = 0; i < listMain.length; i++) {
          var listchild = listMain[i] as List;
          print(listchild);
          for (var j = 0; j < listchild.length; j++) {
            var listchild2 = listchild[j]['staff_array'] as List;
            for (var k = 0; k < listchild2.length; k++) {
              print(listchild2[k]);
              stylish.add(listchild2[k]);
              stylishId = listchild2[k]['staff_id'];
              print('id????????????????${stylishId}');
            }
          }
        }
        setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            isArabic ? 'حدد المصمم الخاص بك' : 'Select your stylist',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black87,
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.selectedServiceNames[widget.index],
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
            isLoadingAndResponse == 0
                ? shoLoader()
                : isLoadingAndResponse == 1
                    ? Center(
                        child: Text(isArabic
                            ? 'البيانات غير متوفرة'
                            : "data not available"))
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: stylish.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  isSelectStylesh = true;
                                  stylishName = stylish[index]['sname'];
                                  stylishId = stylish[index]['staff_id'];
                                  price = stylish[index]['price'];
                                  selectedImage = stylish[index]
                                              ['staff_image'] !=
                                          null
                                      ? baseUrl + stylish[index]['staff_image']
                                      : '';
                                });
                              },
                              contentPadding: EdgeInsets.only(
                                top: 15.0,
                                right: 15.0,
                                left: 15.0,
                              ),
                              leading: CircleAvatar(
                                radius: 20.0,
                                child: CircleAvatar(
                                  radius: stylishName == stylish[index]['sname']
                                      ? 17.0
                                      : 20.0,
                                  foregroundImage: NetworkImage(stylish[index]
                                              ['staff_image'] !=
                                          null
                                      ? baseUrl + stylish[index]['staff_image']
                                      : ''),
                                  backgroundImage: NetworkImage(
                                    stylish[index]['staff_image'] != null
                                        ? baseUrl +
                                            stylish[index]['staff_image']
                                        : '',
                                  ),
                                ),
                              ),
                              title: Text(
                                stylish[index]['sname'],
                              ),
                              trailing: Text(
                                '€${stylish[index]['price']}',
                              ),
                            );
                          },
                        ),
                      ),
            progressHUD,
          ],
        ),
        bottomSheet: isSelectStylesh
            ? GestureDetector(
                onTap: () => switchScreen(),
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
                  child: Text(
                    isArabic
                        ? 'حدد التاريخ والوقت'
                        : 'Select your date and time',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
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

  void switchScreen() {
    print("index value ${widget.index}");
    (widget.selectedEmployeIdList as List).insert(widget.index, stylishId);
    (widget.selectedEmployeList as List).insert(widget.index, stylishName);
    (widget.employeImageList as List).insert(widget.index, selectedImage);
    (widget.priceList as List).insert(widget.index, price);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppoinmentDateTime(
            lat: widget.lat,
            long: widget.long,
            shop_id2: widget.shop_id2,
            address: widget.address,
            catName: widget.catName,
            shopName: widget.shopName,
            shop_id: widget.shop_id,
            treatmentId: widget.treatmentId,
            variationId: widget.variationId,
            staff_id: stylishId,
            price: price,
            index: widget.index,
            priceList: widget.priceList,
            selectedServiceNames: widget.selectedServiceNames,
            selectedEmployeList: widget.selectedEmployeList,
            selectedEmployeIdList: widget.selectedEmployeIdList,
            selectedDateList: widget.selectedDateList,
            selectedTimeIdList: widget.selectedTimeIdList,
            selectedSerDuration: widget.selectedSerDuration,
            employeImageList: widget.employeImageList),
      ),
    );
  }
}

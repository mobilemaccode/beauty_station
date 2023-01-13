import 'package:beauty_station/Checkout/checkout.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/GetAppoinment/getAppoinmentWidgets.dart';
import 'package:beauty_station/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAppoinment extends StatefulWidget {
  final shop_id2;
  final address;
  final shop_id;
  final treatmentId;
  final variationId;
  final staff_id;
  final price;
  final time;
  final date;
  final catName;
  final shopName;
  final lat;
  final long;
  final selectedServiceNames;
  final selectedEmployeList;
  final selectedEmployeIdList;
  final selectedDateList;
  final selectedTimeIdList;
  final selectedSerDuration;
  final employeImageList;
  final priceList;
  GetAppoinment(
      {this.lat,
      this.long,
      this.shop_id2,
      this.address,
      this.catName,
      this.shopName,
      this.shop_id,
      this.treatmentId,
      this.variationId,
      this.staff_id,
      this.price,
      this.time,
      this.date,
      this.priceList,
      this.selectedServiceNames,
      this.selectedEmployeList,
      this.selectedEmployeIdList,
      this.selectedDateList,
      this.selectedTimeIdList,
      this.selectedSerDuration,
      this.employeImageList});

  @override
  _GetAppoinmentState createState() => _GetAppoinmentState();
}

class _GetAppoinmentState extends State<GetAppoinment> {
  bool isCheckOne = false;
  bool isCheckTwo = false;
  var isLogin = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onCheckOneTap() {
    setState(() {
      isCheckOne = !isCheckOne;
    });
  }

  bool isArabic = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  @override
  void initState() {
    print(isLogin);
    getLang();
    checkLogin();
    super.initState();
  }

  void onCheckTwoTap() {
    setState(() {
      isCheckTwo = !isCheckTwo;
    });
  }

  @override //i work on android and i did not test it on ios so...
  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs?.getBool("isLoggedIn") != null)
      isLogin = prefs?.getBool("isLoggedIn") ?? false;
    if (isLogin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Checkout(
              lat: widget.lat,
              long: widget.long,
              shop_id2: widget.shop_id2,
              address: widget.address,
              catName: widget.catName,
              shopName: widget.shopName,
              shop_id: widget.shop_id,
              treatmentId: widget.treatmentId,
              variationId: widget.variationId,
              staff_id: widget.staff_id,
              price: widget.price,
              time: widget.time,
              date: widget.date,
              name: "",
              email: "",
              mobile: "",
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
    } else {
      setState(() {});
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
            isArabic ? 'التفاصيل الشخصية الخاصة بك' : 'Your Personal Detail',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: isLogin
                  ? Container(
                      child: Center(
                          child: Text(isArabic
                              ? 'بالفعل تسجيل الدخول الخروج'
                              : "Already Login Checkout")))
                  : SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 110,
                              width: double.infinity,
                              padding: EdgeInsets.all(15.0),
                              color: greyColor.withOpacity(0.2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isArabic
                                        ? 'احجز بشكل أسرع من خلال تسجيل الدخول'
                                        : 'Book faster by signing in',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _navigateLogin(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: whiteColor,
                                        border: Border.all(
                                          width: 2.5,
                                          color: themeColor,
                                        ),
                                      ),
                                      child: Text(
                                        isArabic ? 'بريد إلكتروني' : 'Email',
                                        style: TextStyle(
                                          color: themeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isArabic
                                        ? 'الخروج كضيف'
                                        : 'CHECKOUT AS GUEST',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  checkoutEmail(isArabic),
                                  checkoutFullname(isArabic),
                                  checkoutPhone(isArabic),
                                  hBox(15.0),
                                  confirmVisit(widget.shopName, isArabic),
                                  hBox(20.0),
                                  checkOne(isCheckOne, onCheckOneTap, isArabic),
                                  checkTwo(isCheckTwo, onCheckTwoTap, isArabic),
                                  Text(isArabic
                                      ? 'يمكنك معرفة المزيد حول كيفية تخزين تريتويل. يستخدم ويحمي بياناتك في سياسة الخصوصية الخاصة بنا.'
                                      : 'You can find out more about how Treatwell stores. uses and protects your data in our privacy policy.'),
                                  hBox(100.0)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
            progressHUD,
          ],
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            if (isLogin) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Checkout(
                      lat: widget.lat,
                      long: widget.long,
                      shop_id2: widget.shop_id2,
                      address: widget.address,
                      catName: widget.catName,
                      shopName: widget.shopName,
                      shop_id: widget.shop_id,
                      treatmentId: widget.treatmentId,
                      variationId: widget.variationId,
                      staff_id: widget.staff_id,
                      price: widget.price,
                      time: widget.time,
                      date: widget.date,
                      name: "",
                      email: "",
                      mobile: "",
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
            } else {
              if (_formKey.currentState.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(
                        lat: widget.lat,
                        long: widget.long,
                        shop_id2: widget.shop_id2,
                        address: widget.address,
                        catName: widget.catName,
                        shopName: widget.shopName,
                        shop_id: widget.shop_id,
                        treatmentId: widget.treatmentId,
                        variationId: widget.variationId,
                        staff_id: widget.staff_id,
                        price: widget.price,
                        time: widget.time,
                        date: widget.date,
                        priceList: widget.priceList,
                        name: checkoutNameController.text,
                        email: checkoutEmailController.text,
                        mobile: checkoutPhoneController.text,
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
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
              height: 45.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromARGB(255, 236, 103, 70),
              ),
              child: Container(
                child: Center(
                    child: Text(
                  isArabic ? 'اذهب إلى الدفع' : 'Go to Checkout',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              )),
        ),
      ),
    );
  }

  void _navigateLogin(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => Login(
                isBooking: true,
              )),
    );
    if (result) {
      checkLogin();
    }
  }
}

import 'package:beauty_station/Apis/Request/WsAddBooking.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/BookingConfirm/bookingConfirm.dart';
import 'package:beauty_station/CancellationPolicy/cancellationPolicy.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Terms/PrivacyPolicyTermsCondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  final shop_id2;
  final address;
  final shop_id;
  final treatmentId;
  final variationId;
  final staff_id;
  final price;
  final time;
  final date;
  final name;
  final email;
  final mobile;
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
  Checkout(
      {this.lat,
      this.long,
      this.shop_id2,
      this.address,
      this.catName,
      this.shop_id,
      this.shopName,
      this.treatmentId,
      this.variationId,
      this.staff_id,
      this.price,
      this.priceList,
      this.time,
      this.date,
      this.name,
      this.email,
      this.mobile,
      this.selectedServiceNames,
      this.selectedEmployeList,
      this.selectedEmployeIdList,
      this.selectedDateList,
      this.selectedTimeIdList,
      this.selectedSerDuration,
      this.employeImageList});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final formKeyCoupon = GlobalKey<FormState>();

  final TextEditingController voucherController = TextEditingController();
  bool isArabic = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List selectedServiceNameslist = [];
  void add() {
    selectedServiceNameslist = widget.selectedSerDuration as List;
  }

  var price;
  void aaa() {
    var b = 0;
    for (int i = 0; i < selectedServiceNameslist.length; i++) {
      var a = int.parse((widget.priceList as List)[i]);
      b = b + a;
    }
    // print('amanb...b...${int.parse(b)}');

    setState(() {
      price = b;
    });
  }

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  @override
  void initState() {
    getLang();
    add();
    aaa();

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
            isArabic ? 'الدفع' : 'Checkout',
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
              height: MediaQuery.of(context).size.height * 0.81,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicyTermsCondition(
                                title:
                                    isArabic ? 'شروط الشرط' : "Terms Condition",
                                content: isArabic
                                    ? 'لوريم إيبسوم هو ببساطة نص شكلي يستخدم في صناعة الطباعة والتنضيد. كان Lorem Ipsum هو النص الوهمي القياسي في الصناعة منذ القرن الخامس عشر الميلادي ، عندما أخذت طابعة غير معروفة لوحًا من النوع وتدافعت عليه لعمل كتاب عينة. لقد صمد ليس فقط لخمسة قرون ، ولكن أيضًا القفزة في التنضيد الإلكتروني ، وظل دون تغيير جوهري. تم نشره في الستينيات من القرن الماضي مع إصدار أوراق Letraset التي تحتوي على مقاطع Lorem Ipsum ، ومؤخرًا مع برامج النشر المكتبي مثل Aldus PageMaker بما في ذلك إصدارات Lorem Ipsum.'
                                    : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              ),
                            ),
                          );
                        },
                        child: Text(
                          isArabic
                              ? 'من خلال الاستمرار ، يجب أن توافق على الشروط والأحكام الخاصة بنا'
                              : 'By continuing you have to agree to our Terms & Conditions',
                        ),
                      ),
                    ),
                    hBox(10.0),
                    divider(1.0, 1.0, 0.0, 0.0),
                    hBox(40.0),
                    Text(
                      widget.shopName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                    hBox(30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.time,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 30.0,
                          ),
                        ),
                        wBox(12.0),
                        SizedBox(
                          height: 32.0,
                          child: VerticalDivider(
                            thickness: 2.0,
                            color: Colors.black,
                            width: 2.0,
                            endIndent: 2.0,
                            indent: 2.0,
                          ),
                        ),
                        wBox(12.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMM-dd, EEEE').format(widget.date),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              // widget.selectedSerDuration[0],
                              isArabic
                                  ? 'موعد ${widget.selectedSerDuration.toString()} دقيقة'
                                  : '${widget.selectedSerDuration[0]} mins appoinment',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    hBox(25.0),
                    SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          for (var i = 0;
                              i < (widget.selectedEmployeList as List).length ??
                                  0;
                              i++) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: greyColor,
                                  foregroundImage:
                                      NetworkImage(widget.employeImageList[i]),
                                ),
                                wBox(8.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /* Text(
                              widget.shopName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                            hBox(5.0),*/
                                    Text(
                                      (widget.selectedEmployeList as List)[i],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    hBox(5.0),
                                    Text(
                                      (widget.selectedServiceNames as List)[i],
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    hBox(5.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isArabic
                                              ? ' دقيقة' +
                                                  widget.selectedSerDuration[i]
                                              : '${widget.selectedSerDuration[i]} mins',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        wBox(10.0),
                                        Text(
                                          (widget.priceList as List)[i],
                                          // '€${widget.price}',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                          ]
                        ])),
                    hBox(20.0),
                    Container(
                      height: 40,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      color: Colors.blue[200].withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.black,
                          ),
                          wBox(8.0),
                          Text(
                            isArabic
                                ? 'إعادة الجدولة حتى 1 ساعة قبل الموعد'
                                : 'Reschedule upto 1 hrs before appointment',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    hBox(25.0),
                    SizedBox(
                      height: 8.0,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/divider.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.43,
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          hBox(20.0),
                          Form(
                            key: formKeyCoupon,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return isArabic
                                        ? 'الرجاء إدخال الرمز الترويجي.'
                                        : 'Please enter promo code.';
                                  }
                                  return null;
                                },
                                controller: voucherController,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 17),
                                  hintText: isArabic
                                      ? 'أدخل رمز القسيمة'
                                      : 'Enter Voucher Code',
                                  filled: true,
                                  fillColor: whiteColor,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      if (formKeyCoupon.currentState
                                          .validate()) {
                                        // addCoupon();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        top: 15.0,
                                        end: 25.0,
                                      ),
                                      child: Text(
                                        isArabic ? 'تطبيق' : 'APPLY',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ), // myIcon is a 48px-wide widget.
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            ),
                          ),
                          hBox(15.0),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CancellationPolicy(),
                              ),
                            ),
                            child: Container(
                              height: 45.0,
                              width: double.infinity,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              color: whiteColor,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    isArabic
                                        ? 'سياسة الإلغاء'
                                        : 'Cancellation policy',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            progressHUD,
          ],
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            payAndChangeScreen();
          },
          child: Container(
            alignment: Alignment.center,
            height: 70,
            width: double.infinity,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isArabic
                      ? 'إجمالي للدفع \n€${price}'
                      : 'Total to Pay \n€${price}',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.black,
                  ),
                  child: Text(
                    isArabic ? 'تأكيد الحجز' : 'Confirm Booking',
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void payAndChangeScreen() async {
    progressHUD.state.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId") ?? "";
    var membershipRequest = WsAddBooking(
        endPoint: APIManagerForm.endpoint,
        treatmentt_ids: widget.treatmentId,
        variation_ids: widget.variationId,
        vendor_id: widget.shop_id,
        customer_id: userId,
        staff_id: (widget.selectedEmployeIdList as List).join(","),
        date: (widget.selectedDateList as List).join(","),
        time: (widget.selectedTimeIdList as List).join(","),
        remark: "",
        name: widget.name,
        email: widget.email,
        mobile: widget.mobile);
    await APIManagerForm.performRequest(membershipRequest, showLog: true);

    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['success'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookingConfirm(
                    lat: widget.lat,
                    long: widget.long,
                    shop_id2: widget.shop_id2,
                    address: widget.address,
                    // catName: widget.catName,
                    // shop_id: widget.shop_id,
                    shopName: widget.shopName,
                    // treatmentId: widget.treatmentId,
                    // variationId: widget.variationId,
                    // staff_id: widget.staff_id,
                    price: price,
                    time: widget.time,
                    date: widget.date,
                    priceList: widget.priceList,
                    bookingId: dataResponse['data'],
                    selectedServiceNames: widget.selectedServiceNames,
                    selectedEmployeList: widget.selectedEmployeList,
                    // selectedEmployeIdList: widget.selectedEmployeIdList,
                    // selectedDateList: widget.selectedDateList,
                    // selectedTimeIdList: widget.selectedTimeIdList,
                    selectedSerDuration: widget.selectedSerDuration,
                    employeImageList: widget.employeImageList,
                    pagename: 'checkout',
                  )),
        );
      }
      progressHUD.state.dismiss();
    } catch (e) {
      progressHUD.state.dismiss();
      print('Error: ${e.toString()}');
    }
  }
}

import 'package:beauty_station/Apis/Request/WsTimings.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/WidgetLoader.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/GetAppoinment/getAppoinment.dart';
import 'package:beauty_station/Stylish/selectStylish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppoinmentDateTime extends StatefulWidget {
  final shop_id2;
  final address;
  final shop_id;
  final treatmentId;
  final variationId;
  final staff_id;
  final price;
  final catName;
  final shopName;
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
  AppoinmentDateTime(
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
      this.priceList,
      this.index,
      this.selectedServiceNames,
      this.selectedEmployeList,
      this.selectedEmployeIdList,
      this.selectedDateList,
      this.selectedTimeIdList,
      this.selectedSerDuration,
      this.employeImageList});

  @override
  _AppoinmentDateTimeState createState() => _AppoinmentDateTimeState();
}

class _AppoinmentDateTimeState extends State<AppoinmentDateTime> {
  var currDt = DateTime.now();
  var bookingDate;
  var selectTime;
  DateTime selectDoB = DateTime.now();
  var isLoadingAndResponse = 0;
  List timing = [
    {
      'time': '9:00',
      'amount': '40.0',
    },
    {
      'time': '10:00',
      'amount': '45.0',
    },
    {
      'time': '10:30',
      'amount': '40.0',
    },
    {
      'time': '12:00',
      'amount': '45.0',
    },
    {
      'time': '2:00',
      'amount': '35.0',
    },
  ];
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
    getLang();
    getStylist();
    super.initState();
  }

  var dayName;

  @override //i work on android and i did not test it on ios so...
  void getStylist() async {
    selectTime = null;
    // progressHUD.state.show();
    var membershipRequest = WsTimings(
      endPoint: APIManagerForm.endpoint,
      staffId: widget.staff_id,
      date: '${DateFormat('yyyy-MM-dd').format(selectDoB)}',
    );
    await APIManagerForm.performRequest(membershipRequest, showLog: true);
    try {
      var dataResponse = membershipRequest.response;
      if (dataResponse['status'] == 'true') {
        isLoadingAndResponse = 2;
        dayName = '${DateFormat('EEEE').format(DateTime.now())}'.toLowerCase();
        timing.clear();
        List timingApi = dataResponse['data'];
        for (var i = 0; i < timingApi.length; i++) {
          // if (timingApi[i]['day'] == dayName) {
          timingApi[i]['amount'] = widget.priceList;
          timing.add(timingApi[i]);
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: DateTime(currDt.year + 1),
    );
    bookingDate = picked;
    dayName = '${DateFormat('EEEE').format(DateTime.now())}'.toLowerCase();
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
            selectDoB == null
                ? isArabic
                    ? 'حدد التاريخ والوقت'
                    : 'Select Date and Time'
                : DateFormat("MMM").format(selectDoB),
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
            Container(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarWeek(
                    height: 70,
                    minDate: DateTime.now(),
                    maxDate: DateTime.now().add(
                      Duration(days: 365),
                    ),
                    onDatePressed: (DateTime datetime) {
                      setState(() {
                        selectDoB = datetime;
                        getStylist();
                      });
                    },
                    dayOfWeekStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                    dayOfWeekAlignment: FractionalOffset.bottomCenter,
                    dateStyle: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w400),
                    dateAlignment: FractionalOffset.topCenter,
                    todayDateStyle: TextStyle(
                        color: (selectDoB.year == DateTime.now().year &&
                                selectDoB.month == DateTime.now().month &&
                                selectDoB.day == DateTime.now().day)
                            ? Colors.white
                            : Colors.orange,
                        fontWeight: FontWeight.w400),
                    todayBackgroundColor:
                        (selectDoB.year == DateTime.now().year &&
                                selectDoB.month == DateTime.now().month &&
                                selectDoB.day == DateTime.now().day)
                            ? Color.fromARGB(255, 236, 103, 70)
                            : Colors.black.withOpacity(0.15),
                    pressedDateBackgroundColor:
                        Color.fromARGB(255, 236, 103, 70),
                    pressedDateStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    dateBackgroundColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    dayOfWeek: [
                      isArabic ? 'الإثنين' : 'Mon',
                      isArabic ? 'الثلاثاء' : 'Tue',
                      isArabic ? 'الأربعاء' : 'Wed',
                      isArabic ? 'خميس' : 'Thu',
                      isArabic ? 'الجمعة' : 'Fri',
                      isArabic ? 'جلس' : 'Sat',
                      isArabic ? 'الشمس' : 'Sun'
                    ],
                    spaceBetweenLabelAndDate: 0,
                    dayShapeBorder: CircleBorder(),
                  ),
                  /*TableCalendar(
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(2030, 3, 14),
                          daysOfWeekStyle: DaysOfWeekStyle(
                          ),
                          focusedDay: DateTime.now(),
                          calendarStyle: CalendarStyle(
                              canMarkersOverflow: true,
                              outsideDaysVisible: false,
                              todayTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white)),
                          // selectedDayPredicate: (day) {
                          //   return isSameDay(selectDoB, day);
                          // },
                          headerVisible: false,
daysOfWeekVisible: false,
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              selectDoB = selectedDay;// update `_focusedDay` here as well
                            });
                          },
                        ),*/
/*                      Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        )*/
                  /*   InkWell(
                          child: Text(
                            selectDoB == null
                                ? '${DateFormat('MMM-dd, EEEE').format(DateTime.now())}'
                                : '${DateFormat('MMM-dd, EEEE').format(selectDoB)}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            _selectDate(context).then(
                              (result) => setState(
                                () {
                                  selectDoB = bookingDate;
                                },
                              ),
                            );
                          },
                        ),*/
                  hBox(10.0),
                  Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                    for (var i = 0;
                                        i < timing.length ?? 0;
                                        i++) ...[
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(top: 1.0),
                                        leading: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (timing[i]['is_booked'])
                                                selectTime = timing[i]['time'];
                                            });
                                          },
                                          icon: selectTime == timing[i]['time']
                                              ? Icon(
                                                  Icons.check_circle_sharp,
                                                  color: Color.fromARGB(
                                                      255, 236, 103, 70),
                                                )
                                              : Icon(
                                                  Icons.add_circle_outlined,
                                                  color: greyColor,
                                                ),
                                        ),
                                        title: Text(
                                          timing[i]['is_booked']
                                              ? timing[i]['time']
                                              : '${timing[i]['time']}  (Booked)',
                                          style: TextStyle(
                                              color: timing[i]['is_booked']
                                                  ? Colors.grey.shade900
                                                  : Colors.grey.shade400),
                                        ),
                                        trailing: Text(
                                          '€${timing[i]['amount']}',
                                        ),
                                      ),
                                    ],
                                  ])),
                  ),
                  hBox(100.0),
                ],
              ),
            )),
          ],
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            if (selectTime != null && selectDoB != null) {
              var result = widget.treatmentId.split(",") as List;
              var indexNext = widget.index + 1;
              if (result.length > indexNext) {
                (widget.selectedDateList as List).insert(widget.index,
                    '${DateFormat('yyyy').format(new DateTime.now())}-${DateFormat('MM-dd').format(selectDoB)}');
                (widget.selectedTimeIdList as List)
                    .insert(widget.index, selectTime);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectStylish(
                          lat: widget.lat,
                          long: widget.long,
                          shop_id2: widget.shop_id2,
                          address: widget.address,
                          catName: widget.catName,
                          shopName: widget.shopName,
                          shop_id: widget.shop_id,
                          treatmentId: widget.treatmentId,
                          variationId: widget.variationId,
                          index: indexNext,
                          priceList: widget.priceList,
                          selectedServiceNames: widget.selectedServiceNames,
                          selectedEmployeList: widget.selectedEmployeList,
                          selectedEmployeIdList: widget.selectedEmployeIdList,
                          selectedDateList: widget.selectedDateList,
                          selectedTimeIdList: widget.selectedTimeIdList,
                          selectedSerDuration: widget.selectedSerDuration,
                          employeImageList: widget.employeImageList),
                    ));
              } else {
                (widget.selectedDateList as List)
                    .insert(widget.index, selectDoB);
                (widget.selectedTimeIdList as List)
                    .insert(widget.index, selectTime);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetAppoinment(
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
                        priceList: widget.priceList,
                        time: selectTime,
                        date: selectDoB,
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
              color: selectTime == null
                  ? Color.fromARGB(200, 236, 103, 70)
                  : Color.fromARGB(255, 236, 103, 70),
            ),
            child: Text(
              isArabic ? 'يكمل' : 'Continue',
              style: TextStyle(
                fontSize: 15.0,
                color: whiteColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

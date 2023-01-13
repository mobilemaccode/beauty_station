import 'dart:async';

import 'package:beauty_station/Dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Config/config.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => Dashboard(selectedLocation: _selectedLocation)),
    );
  }

  // Widget _buildFullscrenImage() {
  //   return Image.asset(
  //     'assets/fullscreen.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }
  //
  // Widget _buildImage(String assetName, [double width = 350]) {
  //   return Image.asset('assets/$assetName', width: width);
  // }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isArabic = false;
  bool isChecked = false;

  void initState() {
    super.initState();
    bbb();
    getStringValuesSF();
    _CitynameSaver();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var status = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      //profile = json.decode(prefs.getString('profile'));
      setState(() {
        isChecked = prefs.getBool('isArabic') ?? false;
        isArabic = prefs.getBool('isArabic') ?? false;
      });
    });
  }

  _CitynameSaver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country_name', _selectedLocation);
    prefs.setString('lang', _selectedLang);
    print(_selectedLocation);
    print(_selectedLang);
  }

  changeLang(status) async {
    print(status);
    setState(
      () {
        isChecked = !isChecked;
      },
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.setBool(
      "isArabic",
      status ? true : false,
    );

    this.setState(() {});
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(
      Duration(seconds: 2),
    );
    setState(
      () {
        getStringValuesSF();
        // coursesGet = List.generate(random.nextInt(10), (i) => i);
      },
    );
    return null;
  }

  List<String> _Lang = [
    'English',
    'Arabic',
  ];
  String _selectedLang;
  Widget bbb() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down_sharp),

                  hint: Text('choose Language'),
                  // Not necessary for Option 1
                  value: _selectedLang,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLang = newValue;
                      _selectedLang != 'English'
                          ? changeLang(true)
                          : changeLang(false);

                      _CitynameSaver();
                    });
                  },
                  items: _Lang.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _locations = ['Saudi Arabia', 'Morocco', 'Netherland', 'India'];
  String _selectedLocation;
  Widget aaa() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down_sharp),

                  hint: Text(isArabic
                      ? "اختر الدولة"
                      : 'choose Country'), // Not necessary for Option 1
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                      _CitynameSaver();
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.transparent,
        imagePadding: EdgeInsets.only(top: 20));

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Center(
          child: IntroductionScreen(
            key: introKey,
            // globalFooter: Image.asset('assets/images/bg.jpg'),
            globalBackgroundColor: Colors.transparent,
            pages: [
              PageViewModel(
                title: " ",
                image: Image.asset('assets/images/logo.png'),
                body: '',
                decoration: pageDecoration,
              ),
              PageViewModel(
                image: Image.asset('assets/images/1.jpg'),
                title: isArabic ? 'اكتشف الخدمات' : "Explore Services",
                body: isArabic
                    ? 'Lornen ipsum ، أو ipsum كما هو معروف في الفترات الزمنية ، هو نص وهمي يستخدم في تصميمات الطباعة أو الرسومات أو الويب. ينسب الحيازة'
                    : "Lornen ipsum, or ipsum as it is semetimes known, is dummy text used in loynind out print , graphic or web designs . The possage is attributed",
                decoration: pageDecoration,
              ),
              PageViewModel(
                image: Image.asset('assets/images/2.jpg'),
                title: isArabic ? 'حدد وقتك' : "Schedule Your Time",
                body: isArabic
                    ? 'Lornen ipsum ، أو ipsum كما هو معروف في الفترات الزمنية ، هو نص وهمي يستخدم في تصميمات الطباعة أو الرسومات أو الويب. ينسب الحيازة'
                    : "Lornen ipsum, or ipsum as it is semetimes known, is dummy text used in loynind out print , graphic or web designs . The possage is attributed",
                decoration: pageDecoration,
              ),
              PageViewModel(
                image: Image.asset('assets/images/3.jpg'),
                title: isArabic
                    ? 'حدد البلد \ n & اللغة'
                    : "Select Country\n & language",
                body: "",
                footer: Column(
                  children: [
                    bbb(),
                    // Padding(
                    //   padding: const EdgeInsets.all(15.0),
                    //   child: GestureDetector(
                    //     onTap: () async {
                    //       // changeLang(status);
                    //     },
                    //     child: Container(
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.white,
                    //             blurRadius: 6.0,
                    //           ),
                    //         ],
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               wBox(5.0),
                    //               Icon(Icons.translate),
                    //               wBox(25.0),
                    //               Text(
                    //                 isArabic
                    //                     ? 'تغيير اللغة إلى اللغة الإنجليزية'
                    //                     : 'Language change to arabic',
                    //               ),
                    //             ],
                    //           ),
                    //           bbb(),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    hBox(10.0),
                    aaa(),
                    // Container(
                    //     child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Icon(Icons.public_rounded),
                    //         wBox(20.0),
                    //         Text(isArabic ? 'اختر الدولة' : 'choose country'),
                    //       ],
                    //     ),
                    //     aaa(),
                    //   ],
                    // ))
                  ],
                ),
                decoration: pageDecoration,
              ),
              // PageViewModel(
              //   title: "Welcome to beauty station",
              //   bodyWidget: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       Text("Click on ", style: bodyStyle),
              //       Icon(Icons.edit),
              //       Text(" to enter this application", style: bodyStyle),
              //     ],
              //   ),
              //   decoration: pageDecoration.copyWith(
              //     bodyFlex: 2,
              //     imageFlex: 4,
              //     bodyAlignment: Alignment.center,
              //     imageAlignment: Alignment.topCenter,
              //   ),
              //   reverse: true,
              // ),
            ],
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            //rtl: true, // Display as right-to-left
            skip: Text(isArabic ? 'يتخطى' : 'Skip'),
            next: Icon(Icons.arrow_forward),
            done: Text(isArabic ? 'منتهي' : 'Done',
                style: TextStyle(fontWeight: FontWeight.w600)),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(12.0)
                : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

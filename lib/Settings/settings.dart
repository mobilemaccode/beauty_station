import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Dashboard/dashboard.dart';
import 'package:beauty_station/Settings/settingsWidgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isArabic = false;
  bool isChecked = false;

  void initState() {
    _CitynameSaver();
    bbb();
    aaa();
    super.initState();
    getStringValuesSF();
  }

  _CitynameSaver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country_name', _selectedLocation);
    prefs.setString('lang', _selectedLang);
    print(_selectedLocation);
    print(_selectedLang);
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

  changeLang(status) async {
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

  Future<bool> _willPopCallback() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(
          currentTab: 2,
        ),
      ),
      (route) => false,
    );
    return true; // return true if the route to be popped
  }

  List<String> _Lang = [
    'English',
    'عربي',
  ];
  String _selectedLang;
  Widget bbb() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: Text('choose Lang'), // Not necessary for Option 1
        value: _selectedLang,
        onChanged: (newValue) {
          setState(() {
            _selectedLang = newValue;
            print(_selectedLang);
            _selectedLang != 'English' ? changeLang(true) : changeLang(false);
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
    );
  }

  List<String> _locations = ['Saudi Arabia', 'Morocco', 'Netherland', 'India'];
  String _selectedLocation;
  Widget aaa() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: Text(isArabic
            ? 'اختر الدولة'
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _willPopCallback();
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 1,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.orange,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(
                      currentTab: 2,
                    ),
                  ),
                  (route) => false,
                );
              },
            ),
            title: Text(
              isArabic ? 'إعدادات' : 'Settings',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    feedBackSupport(context, isArabic),
                    legal(context, isArabic),
                    profilr(context, isArabic),
                    SizedBox(
                      height: 30,
                    ),
                    country(context, aaa, isArabic),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () async {
                          //changeLang(status);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  wBox(5.0),
                                  Icon(Icons.translate),
                                  wBox(25.0),
                                  Text(
                                    isArabic
                                        ? 'تغيير اللغة إلى اللغة الإنجليزية'
                                        : 'Language change to arabic',
                                  ),
                                ],
                              ),
                              bbb(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    preference(isArabic),
                    logout(logoutSession, isArabic)
                  ],
                ),
              ),
              progressHUD,
            ],
          ),
        ),
      ),
    );
  }

  void logoutSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", false);
    prefs.setString("userId", "");
    showToast("Logout successfully");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(
          currentTab: 0,
        ),
      ),
      (route) => false,
    );
  }
}

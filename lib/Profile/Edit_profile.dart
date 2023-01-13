import 'dart:convert';
import 'dart:io';

import 'package:beauty_station/Apis/Request/WsGetProfile.dart';
import 'package:beauty_station/Apis/api_manager_Form.dart';
import 'package:beauty_station/Config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit_profile extends StatefulWidget {
  @override
  _Edit_profileState createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isArabic = false;
  Image _image;
  var filepath = "";
  var isLogin = false;
  var isLoadingAndResponse = 0;
  var data = {};
  var MobileNumberController = TextEditingController();
  var EmailController = TextEditingController();
  var NameController = TextEditingController();

  void initState() {
    super.initState();
    getLang();
    getProfile();
  }

  @override //i work on android and i did not test it on ios so...
  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool("isLoggedIn") ?? false;
    setState(() {});
    if (isLogin) {
      var userId = prefs?.getString("userId");
      var membershipRequest = WsGetProfile(
        endPoint: APIManagerForm.endpoint,
        customerId: userId,
      );
      await APIManagerForm.performRequest(membershipRequest, showLog: true);

      try {
        var dataResponse = membershipRequest.response;
        print("membershipRequest.response.....${userId}");

        if (dataResponse['success'] == true) {
          print("failed");
          // progressHUD.state.dismiss();
          isLoadingAndResponse = 2;
          data = dataResponse['data'];
          EmailController.text = data['email'] != null ? data['email'] : '';
          MobileNumberController.text =
              data['mobile'] != null ? data['mobile'] : '';
          NameController.text = data['name'] != null ? data['name'] : '';
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
  }

  void getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isArabic = prefs.getBool('isArabic') ?? false;
    });
  }

  List<String> _locations = [
    'Mal',
    'Female',
  ]; // Option 2
  String _selectedLocation;

  var selectedTime = null;
  var bookingDate = null;
  var isFillterAply = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 236, 103, 70),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? Text(""),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(1980, 10, 16),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    bookingDate = picked;
    isFillterAplyFunc();
    // dayName = '${DateFormat('EEEE').format(DateTime.now())}'.toLowerCase();
  }

  void isFillterAplyFunc() {
    isFillterAply = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: isLogin
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  hBox(30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        child: Text(isArabic ? 'إلغاء' : 'cancel',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        isArabic ? 'تعديل الملف الشخصي' : "EDIT PROFILE",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      FlatButton(
                        child: Text(isArabic ? 'يحفظ' : 'Save',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () {
                          updateProfile();
                        },
                      ),
                    ],
                  ),
                  hBox(20.0),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    backgroundImage:
                        _image != null ? _image.image : AssetImage(''),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, left: 80),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                        ),
                        onPressed: () {
                          _showPicker(context);
                        },
                      ),
                    ),
                  ),
                  hBox(20.0),
                  Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextField(
                          decoration: InputDecoration(),
                          style: TextStyle(color: Colors.white54),
                          controller: NameController,
                        ),
                      )),
                  hBox(30.0),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(isArabic ? 'بريد إلكتروني' : 'E-mail'),
                          hBox(10.0),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: themeColor,
                            decoration: InputDecoration(),
                            style: TextStyle(color: Colors.black),
                            controller: EmailController,
                          ),
                          hBox(30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(isArabic
                                      ? 'تاريخ الميلاد'
                                      : 'Birth Date'),
                                  hBox(20.0),
                                  GestureDetector(
                                    onTap: () {
                                      _selectDate(context).then(
                                        (result) => setState(
                                          () {
                                            selectedTime = bookingDate;
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        selectedTime == null
                                            ? isArabic
                                                ? "في أي وقت"
                                                : 'Any Time'
                                            : '${DateFormat('yyyy-MM-dd').format(selectedTime)}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(isArabic
                                      ? 'جنس تذكير أو تأنيث'
                                      : 'Gender'),
                                  hBox(10.0),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: DropdownButton(
                                      hint: Text(
                                        isArabic
                                            ? 'جنس تذكير أو تأنيث'
                                            : 'Gender',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ), // Not necessary for Option 1
                                      value: _selectedLocation,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedLocation = newValue;
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
                                ],
                              ),
                            ],
                          ),
                          hBox(30.0),
                          Text(isArabic ? 'رقم الاتصال' : 'Contact Number'),
                          hBox(10.0),
                          TextField(
                              keyboardType: TextInputType.number,
                              cursorColor: themeColor,
                              decoration: InputDecoration(),
                              style: TextStyle(color: Colors.black),
                              controller: MobileNumberController),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Text(
                "Need to Login",
                style: TextStyle(color: Colors.black),
              ),
            ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile image = await ImagePicker.platform
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      filepath = image.path;
      _image = Image.file(File(image.path));
    });
  }

  _imgFromGallery() async {
    XFile image = await ImagePicker.platform
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      filepath = image.path;
      _image = Image.file(File(image.path));
    });
  }

  Future<void> updateProfile() async {
    progressHUD.state.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId") ?? "";
    var request = http.MultipartRequest(
        'POST', Uri.parse(APIManagerForm.endpoint + 'update_profile'));
    if (filepath != "")
      request.files.add(http.MultipartFile('image',
          File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
          filename: filepath.split("/").last));
    else
      request.fields['image'] = '';
    request.fields['name'] = NameController.value.text;
    request.fields['user_id'] = userId;
    request.fields['email'] = EmailController.value.text;
    request.fields['mobile'] = MobileNumberController.value.text;
    var res = await request.send();
    progressHUD.state.dismiss();
    if (res.statusCode == 200) {
      res.stream.transform(utf8.decoder).listen((value) {
        try {
          print(value);
          Map<String, Object> responseData = jsonDecode(value);
          if (responseData.containsKey("success")) {
            if (responseData['success'] == 'true') {
              Navigator.pop(context);
            }
          }
        } catch (e) {}
      });
    }
  }
}

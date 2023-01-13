import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_hud/progress_hud.dart';

SizedBox hBox(height) {
  return SizedBox(
    height: height,
  );
}

SizedBox wBox(width) {
  return SizedBox(
    width: width,
  );
}

Divider divider(height, thickness, indent, endIndent) {
  return Divider(
    height: height,
    thickness: thickness,
    indent: indent,
    endIndent: endIndent,
  );
}

Color whiteColor = Colors.white;
Color redColor = Color(0xffE01C23);
Color greyColor = Colors.grey;
Color themeColor = Colors.lightBlue[900];

TextStyle labelHintFontStyle = TextStyle(
  color: Colors.black87,
  fontSize: 14.5,
  fontWeight: FontWeight.w600,
);

ProgressHUD progressHUD = ProgressHUD(
  loading: false,
  backgroundColor: Colors.black12,
  color: Colors.white,
  containerColor: Color(0xff001b29),
  borderRadius: 5.0,
  text: 'Loading...',
);

showToast(String toast) {
  return Fluttertoast.showToast(
    msg: toast,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Color(0xff21335A),
    textColor: Colors.white,
  );
}

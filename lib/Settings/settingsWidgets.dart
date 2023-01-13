import 'package:beauty_station/Profile/Edit_profile.dart';
import 'package:beauty_station/Settings/legalScreen.dart';
import 'package:beauty_station/feedback/FeedbackScreen.dart';
import 'package:flutter/material.dart';

Widget feedBackSupport(context, isArabic) {
  return ListTile(
    leading: Icon(Icons.announcement),
    title: Text(
      isArabic ? 'والدعم  ردود الفعل' : 'FeedBack & Support',
    ),
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackScreen(),
      ),
    ),
  );
}

Widget legal(context, isArabic) {
  return ListTile(
    leading: Icon(Icons.assistant_photo_outlined),
    title: Text(
      isArabic ? 'قانوني' : 'Legal',
    ),
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
    ),
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => legalScreen(),
      ),
    ),
  );
}

Widget profilr(context, isArabic) {
  return ListTile(
    leading: Icon(Icons.person),
    title: Text(
      isArabic ? 'حساب تعريفي' : 'Profile',
    ),
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
    ),
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Edit_profile(),
      ),
    ),
  );
}

Widget country(context, aaa, isArabic) {
  return ListTile(
    leading: Icon(Icons.public_rounded),
    title: Text(
      isArabic ? 'دولة' : 'Country',
    ),
    trailing: aaa(),
  );
}

Widget language(context, isArabic) {
  return ListTile(
    leading: Icon(Icons.translate),
    title: Text(
      isArabic ? 'لغة' : 'Language',
    ),
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
    ),
    // onTap: () => Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Language(),
    //   ),
    // ),
  );
}

Widget preference(isArabic) {
  return ListTile(
    leading: Icon(Icons.person_search),
    title: Text(
      isArabic ? 'تفضيلات المحتوى' : 'Content & Preferences',
    ),
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
    ),
  );
}

Widget logout(logoutSession, isArabic) {
  return ListTile(
      leading: Icon(Icons.settings_power),
      title: Text(
        isArabic ? 'تسجيل خروج' : 'Logout',
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
      ),
      onTap: () => logoutSession());
}

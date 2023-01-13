// import 'package:beauty_station/Config/config.dart';
// import 'package:custom_switch_button/custom_switch_button.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Language extends StatefulWidget {
//   @override
//   _LanguageState createState() => _LanguageState();
// }
//
// class _LanguageState extends State<Language> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   var refreshKey = GlobalKey<RefreshIndicatorState>();
//   bool isArabic = false;
//   bool isChecked = false;
//
//   void initState() {
//     super.initState();
//     getStringValuesSF();
//   }
//
//   getStringValuesSF() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var status = prefs.getBool('isLoggedIn') ?? false;
//     if (status) {
//       setState(() {
//         //profile = json.decode(prefs.getString('profile'));
//         setState(() {
//           isChecked = prefs.getBool('isArabic') ?? false;
//           isArabic = prefs.getBool('isArabic') ?? false;
//         });
//       });
//     }
//   }
//
//   changeLang() async {
//     setState(
//       () {
//         isChecked = !isChecked;
//       },
//     );
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs?.setBool(
//       "isArabic",
//       isChecked ? true : false,
//     );
//
//     this.setState(() {});
//     refreshList();
//   }
//
//   Future<Null> refreshList() async {
//     refreshKey.currentState?.show(atTop: false);
//     await Future.delayed(
//       Duration(seconds: 2),
//     );
//
//     setState(
//       () {
//         getStringValuesSF();
//         // coursesGet = List.generate(random.nextInt(10), (i) => i);
//       },
//     );
//
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Scaffold(
//         body: Container(
//           color: Colors.white,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 100,
//               ),
//               divider(1.0, 3.0, 25.0, 25.0),
//               hBox(25.0),
//               Text(
//                 isArabic ? 'تغيير اللغة' : 'Switch language',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: "Montserrat",
//                 ),
//               ),
//               hBox(20.0),
//               Column(
//                 children: [
//                   Text(
//                     isArabic
//                         ? 'من العربية إلى الانجليزية'
//                         : 'Change Language English to Arabic',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: "Montserrat",
//                     ),
//                   ),
//                   hBox(30.0),
//                   GestureDetector(
//                     onTap: () async {
//                       changeLang();
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey,
//                             blurRadius: 6.0,
//                           ),
//                         ],
//                       ),
//                       child: CustomSwitchButton(
//                         backgroundColor: Colors.white,
//                         unCheckedColor: Colors.grey,
//                         animationDuration: Duration(milliseconds: 400),
//                         checkedColor: themeColor,
//                         checked: isChecked,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(''),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

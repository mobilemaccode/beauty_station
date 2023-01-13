import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Config/validations.dart';
import 'package:flutter/material.dart';

TextEditingController checkoutEmailController = TextEditingController();
TextEditingController checkoutNameController = TextEditingController();
TextEditingController checkoutPhoneController = TextEditingController();

Widget checkoutEmail(isArabic) {
  return SizedBox(
      height: 60.0,
      child: TextFormField(
        controller: checkoutEmailController,
        validator: validateEmailField,
        keyboardType: TextInputType.emailAddress,
        // hintText: "Email",
        decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: isArabic ? 'بريد إلكتروني' : 'Email',
            hintText: isArabic ? 'بريد إلكتروني' : 'Email'),
        onSaved: (String val) {},
        textInputAction: TextInputAction.next,
      ));
}

Widget checkoutFullname(isArabic) {
  return SizedBox(
      height: 60.0,
      child: TextFormField(
        controller: checkoutNameController,
        validator: validateName,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: isArabic ? 'الاسم بالكامل' : 'Full Name',
            hintText: isArabic ? 'الاسم بالكامل' : 'Full Name'),
        onSaved: (String val) {},
        textInputAction: TextInputAction.next,
      ));
}

Widget checkoutPhone(isArabic) {
  return SizedBox(
      height: 60.0,
      child: TextFormField(
        controller: checkoutPhoneController,
        validator: validateMobile,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: isArabic ? 'هاتف' : 'Phone',
            hintText: isArabic ? 'هاتف' : 'Phone'),
        onSaved: (String val) {},
        textInputAction: TextInputAction.next,
      ));
}

String _character = 'yes';

Widget confirmVisit(shopName, isArabic) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic
                ? 'هل زرت $shopName في آخر 12 شهرًا؟'
                : 'Have you visited $shopName in the last 12 months?',
            style: TextStyle(
              color: Color(0xff919090),
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio(
                value: isArabic ? 'نعم' : 'yes',
                groupValue: _character,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(
                    () {
                      _character = value;
                    },
                  );
                },
              ),
              Text(
                isArabic ? 'نعم' : 'Yes',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              wBox(20.0),
              Radio(
                value: isArabic ? 'رقم' : 'no',
                groupValue: _character,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(
                    () {
                      _character = value;
                    },
                  );
                },
              ),
              Text(
                isArabic ? 'نعم' : 'No',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Widget checkOne(isCheckOne, onCheckOneTap, isArabic) {
  return CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading,
    contentPadding: EdgeInsets.all(5),
    title: Text(
      isArabic
          ? 'ضع علامة في هذا المربع إذا كنت ترغب في تلقي رسائل بريد إلكتروني تسويقية من Treatwell مع أحدث أخبار وعروض TREATWELL لسلع وخدمات مماثلة. يمكنك إلغاء الاشتراك في أي وقت عن طريق النقر فوق ارتباط إلغاء الاشتراك في رسائل البريد الإلكتروني التسويقية.'
          : 'Tick this box if you want to receive marketing emails from Treatwell with the tatest TREATWELL news and offers for similar goods and services. you can unsubscribe at any time by clicking the unsubscribelink in marketing emails.',
      style: TextStyle(
        color: Colors.black54,
        fontSize: 13.0,
      ),
    ),
    value: isCheckOne,
    onChanged: (bool value) {
      onCheckOneTap();
    },
  );
}

Widget checkTwo(isCheckTwo, onCheckTwoTap, isArabic) {
  return CheckboxListTile(
    contentPadding: EdgeInsets.all(5),
    controlAffinity: ListTileControlAffinity.leading,
    title: Text(
      isArabic
          ? 'ضع علامة في هذا المربع إذا كنت ترغب في تلقي رسائل البريد الإلكتروني التسويقية والرسائل النصية القصيرة من SALON الذي تحجز به بخصوص خدماتهم. يمكنك سحب موافقتك في أي وقت باستخدام رابط إلغاء الاشتراك في الاتصالات التسويقية أو عن طريق الاتصال بالصالون مباشرة. \ n لمزيد من المعلومات حول كيفية استخدام الصالون لمعلوماتك الشخصية. يرجى التواصل مع الصالون مباشرة.'
          : 'Tick this box if you DO want to receive marketing emails & SMS from the SALON you are booking with about their services. You can withdraw your consent at any time by using the unsubscribe link in marketing comunications or by contacting the salon directly.\nFor more information on how the salon will use your personal information. please contact the salon directly.',
      style: TextStyle(
        color: Colors.black54,
        fontSize: 13.0,
      ),
    ),
    value: isCheckTwo,
    onChanged: (bool value) {
      onCheckTwoTap();
    },
  );
}

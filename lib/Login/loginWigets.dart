import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Config/inputFormField.dart';
import 'package:beauty_station/Config/validations.dart';
import 'package:beauty_station/Terms/PrivacyPolicyTermsCondition.dart';
import 'package:flutter/material.dart';

final TextEditingController logInMobileNumberController =
    TextEditingController();
final TextEditingController logInPasswordController = TextEditingController();
bool setPass = true;
void clearText() {
  logInPasswordController.clear();
}

Widget loginMobileNumber(typeNo, isArabic) {
  return AllInputDesign(
    controller: logInMobileNumberController,
    validator: validateMobile,
    onChanged: (text) {
      typeNo();
    },
    keyBoardType: TextInputType.phone,
    maxLength: 10,
    counterText: '',
    hintText: isArabic ? 'رقم الهاتف' : 'Phone Nr',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget loginPassword(typeNo, isArabic) {
  return StatefulBuilder(
    builder: (context, setState) {
      return AllInputDesign(
        controller: logInPasswordController,
        validator: validatePassword,
        onChanged: (text) {
          typeNo();
        },
        keyBoardType: TextInputType.text,
        hintText: isArabic ? 'كلمة المرور' : 'Password',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: GestureDetector(
            onTap: () {
              setState(
                () {
                  setPass = !setPass;
                },
              );
            },
            child: Text(
              setPass
                  ? isArabic
                      ? 'تبين'
                      : 'Show'
                  : isArabic
                      ? 'إخفاء'
                      : 'Hide',
              style: TextStyle(
                color: redColor,
              ),
            ),
          ),
        ),
        obsecureText: setPass,
        textInputAction: TextInputAction.done,
      );
    },
  );
}

Widget infoText() {
  return Text(
    'You can find out more about BeautyShop store, uses and protects your data in out privacy polcy.',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.black54,
    ),
  );
}

Widget logInBtn(context, _formKey, logInFun, isArabic) {
  return GestureDetector(
    onTap: () {
      if (_formKey.currentState.validate()) {
        logInFun();
      }
    },
    child: Container(
      alignment: Alignment.center,
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: (logInMobileNumberController.text.isNotEmpty &&
                logInPasswordController.text.isNotEmpty)
            ? Color.fromARGB(255, 236, 103, 70)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        isArabic ? 'تسجيل الدخول' : 'LogIn',
        style: TextStyle(
          color: (logInMobileNumberController.text.isNotEmpty &&
                  logInPasswordController.text.isNotEmpty)
              ? Colors.white
              : Colors.black54,
        ),
      ),
    ),
  );
}

Widget tNCText(context, isArabic) {
  return GestureDetector(
    child: Row(
      children: [
        Text(
            isArabic
                ? 'بالمتابعة عليك أن توافق على'
                : 'By Continuing you have to agree to',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black38,
            )),
        Text(isArabic ? '\t الشروط والأحكام.' : '\tTerms & Condition.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black38,
                fontWeight: FontWeight.bold)),
      ],
    ),
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrivacyPolicyTermsCondition(
              title: isArabic ? 'شروط الشرط' : "Terms Condition",
              content: isArabic
                  ? 'لوريم إيبسوم هو ببساطة نص شكلي يستخدم في صناعة الطباعة والتنضيد. كان Lorem Ipsum هو النص الوهمي القياسي في الصناعة منذ القرن الخامس عشر الميلادي ، عندما أخذت طابعة غير معروفة لوحًا من النوع وتدافعت عليه لعمل كتاب عينة. لقد صمد ليس فقط لخمسة قرون ، ولكن أيضًا القفزة في التنضيد الإلكتروني ، وظل دون تغيير جوهري. تم نشره في الستينيات من القرن الماضي مع إصدار أوراق Letraset التي تحتوي على مقاطع Lorem Ipsum ، ومؤخرًا مع برامج النشر المكتبي مثل Aldus PageMaker بما في ذلك إصدارات Lorem Ipsum.'
                  : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            ),
          ))
    },
  );
}

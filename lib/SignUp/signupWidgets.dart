import 'package:beauty_station/Config/config.dart';
import 'package:beauty_station/Config/inputFormField.dart';
import 'package:beauty_station/Config/validations.dart';
import 'package:beauty_station/Terms/PrivacyPolicyTermsCondition.dart';
import 'package:flutter/material.dart';

final TextEditingController signUpFullNameController = TextEditingController();
final TextEditingController signUpMobileNumberController =
    TextEditingController();
final TextEditingController signUpPasswordController = TextEditingController();
bool setPass = true;

Widget fullName(typeNo, isArabic) {
  return AllInputDesign(
    controller: signUpFullNameController,
    validator: validateName,
    onChanged: (text) {
      typeNo();
    },
    keyBoardType: TextInputType.emailAddress,
    hintText: isArabic ? 'الاسم بالكامل' : 'Full Name',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget mobileNumber(typeNo, isArabic) {
  return AllInputDesign(
    controller: signUpMobileNumberController,
    validator: validateMobile,
    keyBoardType: TextInputType.phone,
    onChanged: (text) {
      typeNo();
    },
    maxLength: 10,
    counterText: '',
    hintText: isArabic ? 'رقم الهاتف' : 'Phone Nr',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget password(typeNo, isArabic) {
  return StatefulBuilder(builder: (context, setState) {
    return AllInputDesign(
      controller: signUpPasswordController,
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
            setState(() {
              setPass = !setPass;
            });
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
  });
}

Widget checkBox(valuefirst, isArabic) {
  return StatefulBuilder(builder: (context, setState) {
    return Container(
        child: CheckboxListTile(
      value: valuefirst,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
          isArabic
              ? 'ابعث لي رسائل بريد إلكتروني من متجر التجميل تحتوي على أحدث العروض وأخبار الجمال.'
              : 'Send Me emails from Beautyshop with the latest offers & beauty news.',
          style: TextStyle(color: Colors.grey, fontSize: 13.0)),
      onChanged: (bool value) {
        setState(() {
          valuefirst = value;
        });
      },
    ));
  });
}

Widget infoText(context, isArabic) {
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        isArabic
            ? 'يمكنك معرفة المزيد عن متجر BeautyShop ، ويستخدم ويحمي بياناتك في سياسة الخصوصية.'
            : 'You can find out more about BeautyShop store, uses and protects your data in out privacy policy.',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    ),
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrivacyPolicyTermsCondition(
              title: isArabic ? 'سياسة الخصوصية' : "Privacy Policy",
              content: isArabic
                  ? 'لوريم إيبسوم هو ببساطة نص شكلي يستخدم في صناعة الطباعة والتنضيد. كان Lorem Ipsum هو النص الوهمي القياسي في الصناعة منذ القرن الخامس عشر الميلادي ، عندما أخذت طابعة غير معروفة لوحًا من النوع وتدافعت عليه لعمل كتاب عينة. لقد صمد ليس فقط لخمسة قرون ، ولكن أيضًا القفزة في التنضيد الإلكتروني ، وظل دون تغيير جوهري. تم نشره في الستينيات من القرن الماضي مع إصدار أوراق Letraset التي تحتوي على مقاطع Lorem Ipsum ، ومؤخرًا مع برامج النشر المكتبي مثل Aldus PageMaker بما في ذلك إصدارات Lorem Ipsum.'
                  : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            ),
          ))
    },
  );
}

Widget signUpBtn(context, formKey, signUpFun, isArabic) {
  return GestureDetector(
    onTap: () {
      if (formKey.currentState.validate()) {
        signUpFun();
      }
    },
    child: Container(
      alignment: Alignment.center,
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: (signUpFullNameController.text.isNotEmpty &&
                signUpMobileNumberController.text.isNotEmpty &&
                signUpPasswordController.text.isNotEmpty)
            ? Color.fromARGB(255, 236, 103, 70)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        isArabic ? 'أنشئ حسابك' : 'Create your Account',
        style: TextStyle(
          color: (signUpFullNameController.text.isNotEmpty &&
                  signUpMobileNumberController.text.isNotEmpty &&
                  signUpPasswordController.text.isNotEmpty)
              ? Colors.white
              : Colors.black54,
        ),
      ),
    ),
  );
}

Widget tNCText(context, isArabic) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
          isArabic
              ? 'بالمتابعة عليك أن توافق على'
              : 'By Continuing you have to agree to',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black26,
          )),
      GestureDetector(
        child: Text(isArabic ? 'الشروط والأحكام.' : ' Terms & Condition.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black38,
            )),
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
      ),
    ],
  );
}

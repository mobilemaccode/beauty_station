import 'package:beauty_station/Config/inputFormField.dart';
import 'package:beauty_station/Config/validations.dart';
import 'package:flutter/material.dart';

final TextEditingController feedbackEmailController = TextEditingController();
final TextEditingController feedbackMobileNumberController =
    TextEditingController();
final TextEditingController feedbackNameController = TextEditingController();
final TextEditingController feedbackDescriptionController =
    TextEditingController();
bool setPass = true;

Widget fullName(typeNo, isArabic) {
  return AllInputDesign(
    controller: feedbackNameController,
    validator: validateName,
    onChanged: (text) {
      typeNo();
    },
    keyBoardType: TextInputType.emailAddress,
    hintText: isArabic ? 'الاسم الكامل' : 'Full Name',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget email(typeNo, isArabic) {
  return AllInputDesign(
    controller: feedbackEmailController,
    validator: validateEmailField,
    onChanged: (text) {
      typeNo();
    },
    keyBoardType: TextInputType.emailAddress,
    hintText: isArabic ? 'البريد الالكتروني' : 'Email',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget mobileNumber(typeNo, isArabic) {
  return AllInputDesign(
    controller: feedbackMobileNumberController,
    validator: validateMobile,
    keyBoardType: TextInputType.phone,
    onChanged: (text) {
      typeNo();
    },
    maxLength: 10,
    counterText: '',
    hintText: isArabic ? 'رقم الجوالل لا' : 'Phone Nr',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget description(typeNo, isArabic) {
  return AllInputDesign(
    controller: feedbackDescriptionController,
    validator: validateDescrption,
    onChanged: (text) {
      typeNo();
    },
    keyBoardType: TextInputType.text,
    counterText: '',
    hintText: isArabic ? 'التفاصيل' : 'Description',
    onSaved: (String val) {},
    textInputAction: TextInputAction.done,
  );
}

Widget submitButton(context, formKey, submitFeedback, isArabic) {
  return GestureDetector(
    onTap: () {
      if (formKey.currentState.validate()) {
        submitFeedback();
      }
    },
    child: Container(
      alignment: Alignment.center,
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: (feedbackDescriptionController.text.isNotEmpty &&
                feedbackNameController.text.isNotEmpty &&
                feedbackEmailController.text.isNotEmpty &&
                feedbackMobileNumberController.text.isNotEmpty)
            ? Color.fromARGB(255, 236, 103, 70)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        isArabic ? 'يقدم' : 'Submit',
        style: TextStyle(
          color: (feedbackDescriptionController.text.isNotEmpty &&
                  feedbackNameController.text.isNotEmpty &&
                  feedbackEmailController.text.isNotEmpty &&
                  feedbackMobileNumberController.text.isNotEmpty)
              ? Colors.white
              : Colors.black54,
        ),
      ),
    ),
  );
}

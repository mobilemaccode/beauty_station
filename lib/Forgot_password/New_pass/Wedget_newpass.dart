import 'package:beauty_station/Config/inputFormField.dart';
import 'package:beauty_station/Config/validations.dart';
import 'package:flutter/material.dart';

final TextEditingController NewPasswordController = TextEditingController();
final TextEditingController ConfirmPasswordController = TextEditingController();

Widget Password(typeNo, isArabic) {
  return AllInputDesign(
    validator: validatePassword,
    controller: NewPasswordController,
    keyBoardType: TextInputType.phone,
    onChanged: (text) {
      typeNo();
    },
    maxLength: 10,
    counterText: '',
    hintText: isArabic ? 'أدخل كلمة المرور' : 'Enter Password',
    textInputAction: TextInputAction.next,
  );
}

Widget ConfirmPassword(typeNo, isArabic) {
  return AllInputDesign(
    controller: ConfirmPasswordController,
    keyBoardType: TextInputType.phone,
    onChanged: (text) {
      typeNo();
    },
    maxLength: 10,
    counterText: '',
    hintText: isArabic ? 'تأكيد كلمة المرور' : 'Confirm Password',
    textInputAction: TextInputAction.next,
  );
}

Widget Submit(context, formKey, NewpasswordFun, isArabic) {
  return GestureDetector(
    onTap: () {
      if (formKey.currentState.validate()) {
        NewpasswordFun(NewPasswordController.text);
      }
    },
    child: Container(
      alignment: Alignment.center,
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: (NewPasswordController.text.isNotEmpty &&
                ConfirmPasswordController.text.isNotEmpty)
            ? Color.fromARGB(255, 236, 103, 70)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        isArabic ? 'يقدم' : 'Submit',
        style: TextStyle(
          color: (NewPasswordController.text.isNotEmpty &&
                  ConfirmPasswordController.text.isNotEmpty)
              ? Colors.white
              : Colors.black54,
        ),
      ),
    ),
  );
}

import 'package:beauty_station/Config/inputFormField.dart';
import 'package:beauty_station/Config/validations.dart';
import 'package:flutter/material.dart';

final TextEditingController ForgotMobileNumberController =
    TextEditingController();

Widget MobileNumber(typeNo, isArabic) {
  return AllInputDesign(
    controller: ForgotMobileNumberController,
    validator: validateMobile,
    keyBoardType: TextInputType.phone,
    onChanged: (text) {
      typeNo();
    },
    maxLength: 10,
    counterText: '',
    hintText: isArabic ? 'رقم الهاتف.' : 'Phone No.',
    textInputAction: TextInputAction.next,
  );
}

Widget Submit(
  context,
  _formKey,
  logInFun,
  isArabic,
) {
  return GestureDetector(
    onTap: () => {
      if (_formKey.currentState.validate())
        {
          logInFun(ForgotMobileNumberController.text)
          //clearText();
        }
    },
    child: Container(
      alignment: Alignment.center,
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: (ForgotMobileNumberController.text.isNotEmpty)
            ? Color.fromARGB(255, 236, 103, 70)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        isArabic ? 'يقدم' : 'Submit',
        style: TextStyle(
            color: (ForgotMobileNumberController.text.isNotEmpty)
                ? Colors.white
                : Colors.black54),
      ),
    ),
  );
}

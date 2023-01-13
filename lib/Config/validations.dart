String validateEmailField(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty)
    return 'Email is Required.';
  else if (!regex.hasMatch(value)) return 'Invalid Email';
}

String validateName(String value) {
  Pattern pattern = r'^[a-z A-Z]+$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty)
    return 'Name is Required.';
  else if (!regex.hasMatch(value))
    return 'Name accept only characters';
  else if (value.length < 3)
    return 'Name required at least 3 character';
  else if (value.length > 45)
    return 'Name required at most 45 character';
  else
    return null;
}

String validateMobile(String value) {
  if (value.isEmpty)
    return 'Phone Number is Required.';
  else if (value.length < 10)
    return 'Phone Number required at least 10 numbers';
  else if (value.length > 10)
    return 'Phone Number required at most 10 numbers';
  else
    return null;
}

// {
//   if (value.isEmpty)
//     return 'Phone Number is Required.';
//   // else if (value.length < 10)
//   //   return 'Phone Number required at least 10 numbers';
//   // else if (value.length > 10)
//   //   return 'Phone Number required at most 10 numbers';
//   else
//     return null;
// }
String validateDescrption(String value) {
  if (value.isEmpty)
    return 'Description is Required.';
  // else if (value.length < 10)
  //   return 'Phone Number required at least 10 numbers';
  // else if (value.length > 10)
  //   return 'Phone Number required at most 10 numbers';
  else
    return null;
}

String validatePassword(String value) {
  if (value.isEmpty) return 'Password is Required.';
}

String validateCity(String value) {
  Pattern pattern = r'^[a-z A-Z]+$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty)
    return 'City is Required.';
  else if (!regex.hasMatch(value))
    return 'City accept only characters';
  else if (value.length < 3)
    return 'City required at least 3 character';
  else if (value.length > 45)
    return 'City required at most 45 character';
  else
    return null;
}

String validateState(String value) {
  Pattern pattern = r'^[a-z A-Z]+$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty)
    return 'State is Required.';
  else if (!regex.hasMatch(value))
    return 'State accept only characters';
  else
    return null;
}

String validateCountry(String value) {
  Pattern pattern = r'^[a-z A-Z]+$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty)
    return 'Country is Required.';
  else if (!regex.hasMatch(value))
    return 'Country accept only characters';
  else
    return null;
}

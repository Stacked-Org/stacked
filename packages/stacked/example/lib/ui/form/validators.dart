String? passwordValidator({String? value, int minimumLength = 6}) {
  if (value != null && value.length < minimumLength)
    return "Password should have min $minimumLength characters";
  else
    return null;
}

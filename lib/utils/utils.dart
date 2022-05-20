mixin InputValidationMixin {
  bool isEmailValid(String email) {
    var pattern = r'^\S+@\S+\.\S+$';
    var regex = RegExp(pattern);

    return regex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    var light = r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{6,}$';
    // var extreme =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
    var regex = RegExp(light);

    return regex.hasMatch(password);
  }

  bool isNumberValid(String number) {
    var pattern = r'^[0-9-+\s]+$';
    var regex = RegExp(pattern);

    return regex.hasMatch(number);
  }
}

class AppValidators {
  static bool required(String? value) {
    return value == null || value.isEmpty;
  }

  static bool email(String? value) {
    return value != null && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
  }

  static bool minLength(String? value, int minLength) {
    return value != null && value.length < minLength;
  }

  static bool passwordMatch(String? value, String? otherValue) {
    return value != otherValue;
  }
}
class ValidateUtils {
  static bool validatePhoneNumber(String phoneNumber) {
    final RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');
    return regex.hasMatch(phoneNumber);
  }

  static bool containsFullWidthCharacters(String input) {
    final fullWidthRegex = RegExp(
        r'[\u3040-\u309F\u30A0-\u30FF\uFF01-\uFF60\uFF61-\uFF9F\u4E00-\u9FAF]');
    return fullWidthRegex.hasMatch(input);
  }

  static bool containsWhitespace(String input) {
    final whitespaceRegex = RegExp(r'\s');
    return whitespaceRegex.hasMatch(input);
  }
}

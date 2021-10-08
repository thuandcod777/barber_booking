extension StringValidator on String {
  static const EMAIL_REGEX = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$';

  String? get isValidEmail =>
      this.contains(RegExp(EMAIL_REGEX)) ? null : "Email does not valid";
}

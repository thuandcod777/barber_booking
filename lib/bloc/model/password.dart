import 'package:barber_booking/extension/validators.dart';
import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure({String value = ''}) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return Validators.isValidPassword(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}

import 'package:barber_booking/extension/validators.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure({String value = ''}) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    return Validators.isValidEmail(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}

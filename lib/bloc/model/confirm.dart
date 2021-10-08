import 'package:formz/formz.dart';

enum ConfirmPasswordInputError { empty }

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordInputError> {
  const ConfirmPasswordInput.pure({String value = ''}) : super.pure(value);
  const ConfirmPasswordInput.dirty({String password = '', String value = ''})
      : super.dirty(password);

  @override
  ConfirmPasswordInputError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ConfirmPasswordInputError.empty;
  }
}

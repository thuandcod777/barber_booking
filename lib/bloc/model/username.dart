import 'package:formz/formz.dart';

enum UserNameInputError { empty }

class UserNameInput extends FormzInput<String, UserNameInputError> {
  const UserNameInput.pure({String value = ''}) : super.pure(value);
  const UserNameInput.dirty([String value = '']) : super.dirty(value);

  @override
  UserNameInputError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UserNameInputError.empty;
  }
}

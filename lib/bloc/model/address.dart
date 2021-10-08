import 'package:formz/formz.dart';

enum AddressInputError { empty }

class AddressInput extends FormzInput<String, AddressInputError> {
  const AddressInput.pure({String value = ''}) : super.pure(value);
  const AddressInput.dirty([String value = '']) : super.dirty(value);

  @override
  AddressInputError? validator(String? value) {
    return value?.isNotEmpty == true ? null : AddressInputError.empty;
  }
}

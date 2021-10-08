/*import 'package:formz/formz.dart';

enum FormzStatusValidationError { empty }

class FormzStatus extends FormzInput<String, FormzStatusValidationError> {
  FormzStatus.pure() : super.pure('');
  FormzStatus.dirty([String value = '']) : super.dirty(value);

  @override
  FormzStatusValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FormzStatusValidationError.empty;
  }
}*/

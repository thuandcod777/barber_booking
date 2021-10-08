import 'dart:io';

import 'package:barber_booking/bloc/model/address.dart';
import 'package:barber_booking/bloc/model/confirm.dart';
import 'package:barber_booking/bloc/model/email.dart';
import 'package:barber_booking/bloc/model/password.dart';
import 'package:barber_booking/bloc/model/username.dart';
import 'package:barber_booking/config/path.dart';
import 'package:barber_booking/repositories/authentication_repository.dart';
import 'package:barber_booking/repositories/storage_repository.dart';
import 'package:barber_booking/repositories/user_data_respository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authRepository;
  final UserDataRepository _userDataRepository;
  final StorageRepository _storageRepository;

  SignupCubit(
      {required AuthenticationRepository authRepository,
      required UserDataRepository userDataRepository,
      required StorageRepository storageRepository})
      : _authRepository = authRepository,
        _userDataRepository = userDataRepository,
        _storageRepository = storageRepository,
        super(const SignupState());

  File? _pickedImage;

  void setImage(File? imageFile) async {
    _pickedImage = imageFile;
    emit(state.copyWith(photoAvatar: _pickedImage));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        status: Formz.validate([
          state.userName,
          email,
          state.password,
          state.confirmPassword,
          state.address,
        ])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmPassword = ConfirmPasswordInput.dirty(
        password: password.value, value: state.confirmPassword.value);
    emit(state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        status: Formz.validate([
          state.userName,
          state.email,
          password,
          confirmPassword,
          state.address
        ])));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = ConfirmPasswordInput.dirty(
        password: state.password.value, value: value);

    emit(state.copyWith(
        confirmPassword: confirmPassword,
        status: Formz.validate([
          state.userName,
          state.email,
          state.password,
          confirmPassword,
          state.address
        ])));
  }

  void userNameChanged(String value) {
    final userName = UserNameInput.dirty(value);
    emit(state.copyWith(
        userName: userName,
        status: Formz.validate([
          userName,
          state.password,
          state.confirmPassword,
          state.email,
          state.address
        ])));
  }

  void addressChanged(String value) {
    final address = AddressInput.dirty(value);
    emit(state.copyWith(
        address: address,
        status: Formz.validate([
          state.userName,
          state.password,
          state.confirmPassword,
          state.email,
          address,
        ])));
  }

  Future<void> signnUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authRepository.signUpWithEmail(
          email: state.email.value, password: state.password.value);

      String profilePictureUrl = await _storageRepository.uploadImage(
          _pickedImage!, Paths.profilePicturePath);

      var userId = await _authRepository.getCurrentUser();

      await _userDataRepository.saveProfileUser(userId, profilePictureUrl,
          state.userName.value, state.email.value, state.address.value);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

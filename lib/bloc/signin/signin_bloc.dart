import 'dart:async';

import 'package:barber_booking/extension/validators.dart';
import 'package:barber_booking/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthenticationRepository _authRepository;

  SigninBloc({required AuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(SigninState.empty());

  @override
  Stream<Transition<SigninEvent, SigninState>> transformEvents(
      Stream<SigninEvent> events,
      TransitionFunction<SigninEvent, SigninState> next) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged || event is! PasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email!);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password!);
    } else if (event is SignUpWithCredentialsPressed) {
      yield* _mapSigninCredentialPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<SigninState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<SigninState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<SigninState> _mapSigninCredentialPressedToState(
      {String? email, String? password}) async* {
    yield SigninState.loading();

    try {
      await _authRepository.signInWithEmail(email!, password!);
      yield SigninState.success();
    } catch (_) {
      SigninState.failure();
    }
  }
}

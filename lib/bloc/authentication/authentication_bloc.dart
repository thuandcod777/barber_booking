import 'dart:async';

import 'package:barber_booking/repositories/authentication_repository.dart';
import 'package:barber_booking/repositories/user_data_respository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authRepository;
  final UserDataRepository _userDataRepository;

  AuthenticationBloc(
      {required AuthenticationRepository authRepository,
      required UserDataRepository userDataRepository})
      : _authRepository = authRepository,
        _userDataRepository = userDataRepository,
        super(UnAuthenticated());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (state is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (state is LogginIn) {
      yield* _mapLoggedInToState();
    } else if (state is LogginOut) {
      yield* _mapSignOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignIn = await _authRepository.isSignedIn();

      if (isSignIn) {
        final userId = await _authRepository.getCurrentUser();
        /*final isFirstTime = await _userDataRepository.isFirstTime(userId);

        if (!isFirstTime) {
          yield AuthenticatedButNotSet(userId);
        } else {
          yield UnAuthentication();
        }*/

        yield Authenticated(userId);
      } else {
        yield UnAuthentication();
      }
    } catch (_) {
      yield UnAuthentication();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final userId = await _authRepository.getCurrentUser();
    // final isFirstTime = await _userDataRepository.isFirstTime(userId);

    /* if (!isFirstTime) {
        yield AuthenticatedButNotSet(userId);
      } else {
        yield UnAuthentication();
      }*/
    yield Authenticated(userId);
  }

  Stream<AuthenticationState> _mapSignOutToState() async* {
    yield UnAuthentication();

    _authRepository.signOut();
  }
}

import 'package:barber_booking/bloc/authentication/authentication_bloc.dart';
import 'package:barber_booking/bloc/form_bloc/form_bloc.dart';
import 'package:barber_booking/bloc/phone/phoneauth_bloc.dart';
import 'package:barber_booking/bloc/signin/signin_bloc.dart';
import 'package:barber_booking/bloc/signup/signup_cubit.dart';
import 'package:barber_booking/bloc/truck_bloc/truck_bloc_bloc.dart';
import 'package:barber_booking/provider/phone_auth_provider.dart';
import 'package:barber_booking/repositories/authentication_repository.dart';
import 'package:barber_booking/repositories/phone_auth_repository.dart';
import 'package:barber_booking/repositories/storage_repository.dart';
import 'package:barber_booking/repositories/truck_data_repository.dart';
import 'package:barber_booking/repositories/user_data_respository.dart';
import 'package:barber_booking/screen/account_screen.dart';
import 'package:barber_booking/screen/booking_screen.dart';
import 'package:barber_booking/screen/map_screen.dart';
import 'package:barber_booking/screen/message_screen.dart';
import 'package:barber_booking/screen/orders_screen.dart';
import 'package:barber_booking/screen/setting_screen.dart';
import 'package:barber_booking/screen/sign_in.dart';
import 'package:barber_booking/screen/home_screen.dart';
import 'package:barber_booking/screen/otp_form.dart';
import 'package:barber_booking/screen/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final PhoneAuthFirebaseRepository _phoneAuthRepository =
      PhoneAuthFirebaseRepository(
          phoneAuthProvider:
              PhoneAuthFirebaseProvider(firebaseAuth: FirebaseAuth.instance));

  final AuthenticationRepository _authRepository = AuthenticationRepository();
  final UserDataRepository _userDataRepository = UserDataRepository();
  final StorageRepository _storageRepository = StorageRepository();
  final TruckDataRepository _truckDataRepository = TruckDataRepository();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) =>
              PhoneauthBloc(phoneAuthRepository: _phoneAuthRepository)),
      BlocProvider(
        create: (context) => SignupCubit(
            authRepository: _authRepository,
            userDataRepository: _userDataRepository,
            storageRepository: _storageRepository),
      ),
      BlocProvider(
        create: (context) => SigninBloc(
          authRepository: _authRepository,
        ),
      ),
      BlocProvider(
        create: (context) => AuthenticationBloc(
            authRepository: _authRepository,
            userDataRepository: _userDataRepository)
          ..add(AppStarted()),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => TruckBloc(
          truckDataRepository: _truckDataRepository,
        )..add(LoadTruckEvent()),
      ),
      BlocProvider(create: (context) => FormBloc())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/signin':
            return MaterialPageRoute(builder: (_) => SignIn());
          case '/signup':
            return MaterialPageRoute(builder: (_) => SignUp());
          case '/otp':
            return MaterialPageRoute(builder: (_) => OtpForm());
          case '/home':
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case '/booking':
            return MaterialPageRoute(builder: (_) => BookingScreen());
          case '/orders':
            return MaterialPageRoute(builder: (_) => OrderScreen());
          case '/map':
            return MaterialPageRoute(builder: (_) => MapScreen());
          case '/message':
            return MaterialPageRoute(builder: (_) => MessageScreen());
          case '/account':
            return MaterialPageRoute(builder: (_) => AccountScreen());
          case '/setting':
            return MaterialPageRoute(builder: (_) => SettingScreen());

          default:
            return null;
        }
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          /*if (state is UnAuthenticated) {
            return Container(
                child: Text(
              'asdasd',
              style: TextStyle(color: Colors.white),
            ));
          }*/
          if (state is Authenticated) {
            return HomeScreen(
              userId: state.userId,
            );
          }

          if (state is UnAuthentication) {
            return SignIn();
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }
}

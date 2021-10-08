import 'package:barber_booking/bloc/authentication/authentication_bloc.dart';
import 'package:barber_booking/bloc/signin/signin_bloc.dart';
import 'package:barber_booking/config/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SigninBloc? _signinBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isSignInButtonEnable(SigninState state) {
    return isPopulated && !state.isSubmitting;
  }

  void _onFormSubmitted() {
    _signinBloc!.add(SignUpWithCredentialsPressed(
        _emailController.text, _passwordController.text));
  }

  @override
  void initState() {
    _signinBloc = BlocProvider.of<SigninBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Sign In Failed'), Icon(Icons.error)],
            )));
        }

        if (state.isSubmitting) {
          print("isSubmitting");
          ScaffoldMessenger.of(context)
            ..showSnackBar(SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Sign In .....'), CircularProgressIndicator()],
            )));
        }

        if (state.isSuccess) {
          print("Success");
          //Bloc LoggedIn

          BlocProvider.of<AuthenticationBloc>(context).add(LogginIn());

          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.logo,
              height: 300.0,
            ),
            _textFieldEmailAndPassword(context),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password'),
                  ],
                ),
              ),
            ),
            _buttonSignIn(context),
            _buttonLoginWithPhone(context),
            _buttonSignInWithGoogle(context),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Don\'t have a account ?',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: ' Sign Up',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold))
                ])),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget _textFieldEmailAndPassword(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                controller: _emailController,
                autocorrect: false,
                validator: (_) {
                  return state.isEmailValid ? 'Invalid Email' : null;
                },
                decoration: InputDecoration(
                    hintText: 'Input Email',
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.red),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.red),
                    )),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                controller: _passwordController,
                obscureText: true,
                autocorrect: true,
                validator: (_) {
                  return state.isPasswordValid ? 'Invalid Password' : null;
                },
                decoration: InputDecoration(
                    hintText: 'Input Password',
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.red),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.red),
                    )),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buttonSignInWithGoogle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width * 0.77,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () {},
        icon: Image.asset(
          Assets.google_button,
          height: 20,
        ),
        label: Text('SIGN IN WITH GOOGLE'),
      ),
    );
  }

  Widget _buttonLoginWithPhone(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width * 0.77,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () => Navigator.pushNamed(context, '/otp'),
        icon: Icon(Icons.phone),
        label: Text('LOGIN WITH PHONE'),
      ),
    );
  }

  Widget _buttonSignIn(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          width: MediaQuery.of(context).size.width * 0.77,
          child: ElevatedButton(
            onPressed: isSignInButtonEnable(state) ? _onFormSubmitted : null,
            child: Text('SIGN IN'),
            style: ElevatedButton.styleFrom(
                primary:
                    isSignInButtonEnable(state) ? Colors.red : Colors.grey),
          ),
        );
      },
    );
  }

  void _onEmailChanged() {
    _signinBloc!.add(EmailChanged(_emailController.text));
  }

  void _onPasswordChanged() {
    _signinBloc!.add(PasswordChanged(_passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

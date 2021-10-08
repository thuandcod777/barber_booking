import 'dart:io';
import 'package:formz/formz.dart';
import 'package:barber_booking/bloc/signup/signup_cubit.dart';
import 'package:barber_booking/config/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  String? address;
  File? photo;
  final ImagePicker _picker = ImagePicker();

  bool _visible = true;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  //SignupCubit? _signupBloc;

  /*bool get isPopulated =>
      photo != null &&
      _userNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _addressController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignupState state) {
    return isPopulated && state.status.isSubmissionSuccess;
  }*/

  @override
  void initState() {
    //_signupBloc = BlocProvider.of<SignupCubit>(context);

    /*_userNameController.addListener(_onUserNameChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
    _addressController.addListener(_onAddressChanged);*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Success'), Icon(Icons.error)],
            )));
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }

        /*if (state.isSubmitting) {
          print("isSubmitting");
          ScaffoldMessenger.of(context)
            ..showSnackBar(SnackBar(
                content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Sign Up .....'), CircularProgressIndicator()],
            )));
        }

        if (state.isSuccess) {
          print("Success");
          //Bloc LoggedIn
        }*/
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.0,
            ),
            _pickImageAvatar(context),
            _formTextFormField(context),
            SizedBox(
              height: 30.0,
            ),
            _buttonSignUp(context),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Already have an acount ?',
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: ' Sign In',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))
              ])),
            )
          ],
        ),
      ),
    ));
  }

  Widget _pickImageAvatar(BuildContext context) =>
      BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return Container(
              height: 190.0,
              width: 140.0,
              child: CircleAvatar(
                child: photo == null
                    ? GestureDetector(
                        onTap: () async {
                          /* FilePickerResult? getPickImage = await FilePicker
                              .platform
                              .pickFiles(type: FileType.image);

                          if (getPickImage != null) {
                            setState(() {
                              photo = File(getPickImage.files.single.path!);
                            });
                          }*/
                          PickedFile? image = await _picker.getImage(
                              source: ImageSource.gallery);

                          if (image != null) {
                            /*setState(() {
                              photo = File(image.path);
                            });*/

                            context
                                .read<SignupCubit>()
                                .setImage(File(image.path));
                          }
                        },
                        child: Image.asset(Assets.avatar),
                      )
                    : GestureDetector(
                        onTap: () async {
                          /*FilePickerResult? getPickImage = await FilePicker
                              .platform
                              .pickFiles(type: FileType.image);

                          if (getPickImage != null) {
                            setState(() {
                              photo = File(getPickImage.files.single.path!);
                            });
                          }*/
                          PickedFile? image = await _picker.getImage(
                              source: ImageSource.gallery);

                          if (image != null) {
                            /* setState(() {
                              photo = File(image.path);
                            });*/

                            context
                                .read<SignupCubit>()
                                .setImage(File(image.path));
                          }
                        },
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundImage: FileImage(photo!),
                        ),
                      ),
              ));
        },
      );

  Widget _buttonSignUp(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : Container(
                width: MediaQuery.of(context).size.width * 0.77,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          /*isSignUpButtonEnabled(state)
                          ? Colors.red
                          : Colors.grey*/
                          Colors.red),
                  onPressed: () =>
                      context.read<SignupCubit>().signnUpFormSubmitted(),
                  child: Text('Sign Up'),
                ),
              );
      },
    );
  }

  Widget _formTextFormField(BuildContext context) {
    return Column(
      children: [
        _userNameInput(context),
        _emailInput(context),
        _passwordInput(
          context,
        ),
        _confirmPassword(context),
        _addressInput(context),
      ],
    );
  }

  Widget _addressInput(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: _addressController,
              onChanged: (address) =>
                  context.read<SignupCubit>().addressChanged(address),
              autocorrect: false,
              /* validator: (_) {
                      return state.address.invalid
                          ? 'Please input Address'
                          : null;
                    },*/
              decoration: InputDecoration(
                errorText:
                    state.address.invalid ? "Please input Address" : null,
                hintText: 'Input Address',
                labelText: 'Address',
                labelStyle: TextStyle(color: Colors.red),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ));
      },
    );
  }

  Widget _confirmPassword(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: TextFormField(
            obscureText: _visible,
            // controller: _confirmPasswordController,

            onChanged: (confirmPassword) => context
                .read<SignupCubit>()
                .confirmPasswordChanged(confirmPassword),
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
            validator: (_) {
              /*if (value!.length < 6) {
                      return 'Minium 6 characters';
                    }
    
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return 'Password does\'t match';
                    }
    
                    setState(() {
                      confirmPassword = value;
                    });*/

              /*return state.confirmPassword.invalid
                        ? "Invalid ConfirmPassword"
                        : null;*/
            },
            decoration: InputDecoration(
              errorText: state.confirmPassword.invalid
                  ? "passwords do not match"
                  : null,
              suffixIcon: IconButton(
                icon: _visible
                    ? Icon(Icons.remove_red_eye_outlined,
                        color: Colors.red[900])
                    : Icon(
                        Icons.visibility_off,
                        color: Colors.red[900],
                      ),
                onPressed: () {
                  setState(() {
                    _visible = !_visible;
                  });
                },
              ),
              hintText: 'Confirm Password',
              labelText: 'Confirm Password',
              labelStyle: TextStyle(color: Colors.red),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _passwordInput(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: TextFormField(
            obscureText: _visible,
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.always,
            onChanged: (password) =>
                context.read<SignupCubit>().passwordChanged(password),
            autocorrect: false,
            validator: (_) {
              /*if (value!.isEmpty) {
                      return 'Please input password';
                    }
    
                    setState(() {
                      password = value;
                    });
    
                    return null;*/
              // return state.password.invalid ? "Invalid Password" : null;
            },
            decoration: InputDecoration(
              errorText: state.password.invalid ? "Invalid Password" : null,
              hintText: 'Input Password',
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.red),
              suffixIcon: IconButton(
                icon: _visible
                    ? Icon(Icons.remove_red_eye_outlined,
                        color: Colors.red[900])
                    : Icon(
                        Icons.visibility_off,
                        color: Colors.red[900],
                      ),
                onPressed: () {
                  setState(() {
                    _visible = !_visible;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _emailInput(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.always,
            onChanged: (email) =>
                context.read<SignupCubit>().emailChanged(email),
            autocorrect: false,
            validator: (_) {
              /*if (value!.isEmpty) {
                      return 'Please input email';
                    }
    
                    value.isValidEmail;
    
                    setState(() {
                      email = value;
                    });
    
                    return null;*/
              // return state.email.invalid ? "Invalid Email" : null;
            },
            decoration: InputDecoration(
              errorText: state.email.invalid ? "Invalid Email" : null,
              hintText: 'Input Email',
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _userNameInput(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.userName != current.userName,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: TextFormField(
            onChanged: (username) =>
                context.read<SignupCubit>().userNameChanged(username),
            controller: _userNameController,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
            validator: (_) {
              /*if (value!.isEmpty) {
                      return 'Please input user name';
                    }
                    setState(() {
                      username = value;
                    });
    
                    return null;*/
              /*return state.userName.invalid
                        ? "Please input user name"
                        : null;*/
            },
            decoration: InputDecoration(
              errorText:
                  state.userName.invalid ? "Please input user name" : null,
              hintText: 'Input UserName',
              labelText: 'UserName',
              labelStyle: TextStyle(color: Colors.red),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        );
      },
    );
  }

  /*void getCurrentLocation() {
    BlocProvider.of<LocationBloc>(context).add(LocationChanged());
  }*/

  /*void _onUserNameChanged() {
    _signupBloc!.userNameChanged(_userNameController.text);
  }

  void _onEmailChanged() {
    _signupBloc!.emailChanged(_emailController.text);
  }

  void _onPasswordChanged() {
    _signupBloc!.passwordChanged(_passwordController.text);
  }

  void _onConfirmPasswordChanged() {
    _signupBloc!.confirmPasswordChanged(_confirmPasswordController.text);
  }

  void _onAddressChanged() {
    _signupBloc!.addressChanged(_addressController.text);
  }*/

  /*void _onFormSubmitted() {
    _signupBloc!.add(SignUpWithCredentialsPressed(
        photo: photo!,
        username: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        address: _addressController.text));
  }*/

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

import 'package:barber_booking/bloc/phone/phoneauth_bloc.dart';
import 'package:barber_booking/config/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  //MOBILE_VERIFICATION currentState = MOBILE_VERIFICATION.SHOW_MOBILE_FORM;
  //var countryCodeController = TextEditingController(text: '+91');

  var phoneNumberController = TextEditingController();
  String phoneNumber = "";

  String error = "";

  void onCountryChange(CountryCode countryCode) {
    this.phoneNumber = countryCode.toString();
    print("New Country selected: " + countryCode.toString());
  }

  bool _validPhoneNumber = true;

  var text1NumberForm = TextEditingController();
  var text2NumberForm = TextEditingController();
  var text3NumberForm = TextEditingController();
  var text4NumberForm = TextEditingController();
  var text5NumberForm = TextEditingController();
  var text6NumberForm = TextEditingController();

  //FirebaseAuth _auth = FirebaseAuth.instance;

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /*body: Container(
            child: showLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : currentState == MOBILE_VERIFICATION.SHOW_MOBILE_FORM
                    ? mobileFormWidget(context)
                    : otpFormWidget(context, verificationId)));*/
      body: _phoneAuthViewBuilder(context),
    );
  }

  Widget _phoneAuthViewBuilder(BuildContext context) {
    return BlocConsumer<PhoneauthBloc, PhoneauthState>(
      listener: (previous, current) {
        if (current is PhoneAuthCodeVerficationSuccess) {
          // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          checkLoginState(context, false, _scaffoldKey);
        } else if (current is PhoneAuthCodeVerficationFailure) {
          _showSnackBarWithText(context: context, textValue: current.message);
        } else if (current is PhoneauthError) {
          _showSnackBarWithText(
              context: context, textValue: 'Uexpected error occurred.');
        } else if (current is PhoneAuthNumberVerficationFailure) {
          _showSnackBarWithText(context: context, textValue: current.message);
        } else if (current is PhoneAuthNumberVerficationSuccess) {
          _showSnackBarWithText(
              context: context,
              textValue: 'SMS code is sent to your mobile number.');
        } else if (current is PhoneAuthCodeAutoRetrevalTimeoutComplete) {
          _showSnackBarWithText(
              context: context, textValue: 'Time out for auto retrieval');
        }
      },
      builder: (context, state) {
        if (state is PhoneauthInitial) {
          return _mobileFormWidget(context);
        } else if (state is PhoneAuthNumberVerficationSuccess) {
          return _otpFormWidget(context, state.verificationId);
        } else if (state is PhoneAuthNumberVerficationFailure) {
          return _mobileFormWidget(context);
        } else if (state is PhoneAuthCodeVerficationFailure) {
          return _otpFormWidget(context, state.verificationId);
        } else if (state is PhoneauthLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Container();
      },
    );
  }

  Widget _mobileFormWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200.0,
          child: Image.asset(Assets.phone_button),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'OTP SMS PHONE NUMBER',
          style: TextStyle(fontSize: 20.0, color: Colors.red[400]),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CountryCodePicker(
                  dialogSize: Size.fromRadius(180.0),
                  onChanged: onCountryChange,
                  initialSelection: 'VN',
                  favorite: ['+84', 'VN'],
                  showCountryOnly: false,
                  padding: EdgeInsets.only(bottom: 20.0),
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 4,
                child: TextFormField(
                  controller: phoneNumberController,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    labelStyle: TextStyle(color: Colors.red),
                    hintText: 'Phone Number',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(30.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  onChanged: (value) {
                    if (value.length == 10) {
                      setState(() {
                        _validPhoneNumber = true;
                      });
                    } else {
                      setState(() {
                        _validPhoneNumber = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.77,
          child: ElevatedButton(
            onPressed: () {
              _verifyPhoneNumber(context);
            },
            child: Text('Send'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        )
      ],
    );
  }

  Widget _otpFormWidget(BuildContext context, verifcationId) {
    final node = FocusScope.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'OTP CODE',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'We sent a 6-digit code to your phone',
            style: TextStyle(fontSize: 17.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: text1NumberForm,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  onChanged: (value) {
                    node.nextFocus();
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: text2NumberForm,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  onChanged: (value) {
                    node.nextFocus();
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: text3NumberForm,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  onChanged: (value) {
                    node.nextFocus();
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: text4NumberForm,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  onChanged: (value) {
                    node.nextFocus();
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: text5NumberForm,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  onChanged: (value) {
                    node.nextFocus();
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: text6NumberForm,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                      if (text1NumberForm.text.length == 1) {
                        if (text2NumberForm.text.length == 1) {
                          if (text3NumberForm.text.length == 1) {
                            if (text4NumberForm.text.length == 1) {
                              if (text5NumberForm.text.length == 1) {
                                String _otp =
                                    '${text1NumberForm.text}${text2NumberForm.text}${text3NumberForm.text}${text4NumberForm.text}${text5NumberForm.text}${text6NumberForm.text}';

                                _verifySMS(context, verifcationId, _otp);
                              }
                            }
                          }
                        }
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 10.0),
          child: Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 17.0),
          ),
        )
      ],
    );
  }

  void _verifyPhoneNumber(BuildContext context) {
    BlocProvider.of<PhoneauthBloc>(context).add(PhoneAuthNumberVerified(
        phoneNumber:
            '${this.phoneNumber.toString()}${phoneNumberController.text}'));
  }

  void _verifySMS(
      BuildContext context, String verificationCode, String smsCodeOTP) {
    BlocProvider.of<PhoneauthBloc>(context).add(PhoneAuthCodeVerified(
        verificationId: verificationCode, smsCode: smsCodeOTP));
  }

  void _showSnackBarWithText(
      {required BuildContext context, required String textValue}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(textValue)));
  }
}

Future<void> checkLoginState(BuildContext context, bool fromLogin,
    GlobalKey<ScaffoldState> scaffoldState) async {
  await Future.delayed(Duration(seconds: fromLogin == true ? 0 : 3))
      .then((value) => {
            FirebaseAuth.instance.currentUser!.getIdToken().then((token) async {
              //If get token,we print it
              print('$token');

              //Check user in FireStore
              CollectionReference userRef =
                  FirebaseFirestore.instance.collection('Users');
              DocumentSnapshot snapshotUser = await userRef
                  .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
                  .get();

              if (snapshotUser.exists) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              } else {
                //If user infor doesn't available, show dialog

                var nameController = TextEditingController();
                var addressController = TextEditingController();

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('UPDATE PROFILES'),
                    actions: [
                      Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Username',
                                hintText: 'Input Username'),
                            controller: nameController,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Address',
                                hintText: 'Input Address'),
                            controller: addressController,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context); // dismisses only the dialog and returns false
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  userRef
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.phoneNumber)
                                      .set({
                                    'uid':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'name': nameController.text,
                                    'address': addressController.text
                                  }).then((value) async {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(
                                            scaffoldState.currentContext!)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                                'UPDATE PROFILES SUCCESSFULLY!')));
                                  }).catchError((e) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(
                                            scaffoldState.currentContext!)
                                        .showSnackBar(
                                            SnackBar(content: Text('$e')));
                                  });
                                },
                                child: Text('Update'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ).then((value) => Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false));
              }
            })
          });
}

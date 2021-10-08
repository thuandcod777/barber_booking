enum PhoneAuthModelState { codeSent, autoVerified, error, verified }

class PhoneAuthModel {
  final PhoneAuthModelState phoneAuthModelState;
  final String? verificationId;
  final int? verificationToken;
  final String? uid;

  PhoneAuthModel(
      {required this.phoneAuthModelState,
      this.verificationId,
      this.verificationToken,
      this.uid});

  factory PhoneAuthModel.fromMap(Map<String, dynamic>? map) {
    return PhoneAuthModel(
        phoneAuthModelState:
            PhoneAuthModelState.values[map?['phoneAuthModelState']],
        uid: map?['uid'],
        verificationId: map?['verificationId'],
        verificationToken: map?['verificationToken']);
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneAuthModelState': phoneAuthModelState,
      'verificationId': verificationId,
      'verificationToken': verificationToken,
      'uid': uid
    };
  }
}

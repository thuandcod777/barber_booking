part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final File? photoAvatar;
  final UserNameInput userName;
  final Email email;
  final Password password;
  final ConfirmPasswordInput confirmPassword;
  final AddressInput address;
  final FormzStatus status;

  const SignupState({
    this.photoAvatar,
    this.email = const Email.pure(),
    this.userName = const UserNameInput.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.address = const AddressInput.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [
        photoAvatar,
        userName,
        email,
        password,
        confirmPassword,
        address,
        status
      ];

  SignupState copyWith({
    File? photoAvatar,
    UserNameInput? userName,
    Email? email,
    Password? password,
    ConfirmPasswordInput? confirmPassword,
    AddressInput? address,
    FormzStatus? status,
  }) {
    return SignupState(
      photoAvatar: photoAvatar ?? this.photoAvatar,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      address: address ?? this.address,
      status: status ?? this.status,
    );
  }
}

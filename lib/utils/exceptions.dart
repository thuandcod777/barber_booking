abstract class Exceptions implements Exception {
  String errorMessage();
}

class UserNotFoundException extends Exceptions {
  @override
  String errorMessage() => 'No user found for provided uid/username';
}

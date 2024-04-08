import 'package:cubex/core/core.dart';

class LoginVM extends BaseVM {
  TextEditingController emailC =
      TextEditingController(text: 'edoborworksheet@gmail.com');
  TextEditingController passwordC = TextEditingController(text: 'Success@123');

  bool _isValidEmail = false;
  bool get isValidEmail => _isValidEmail;

  final bool _isTrustedDevice = false;
  bool get isTrustedDevice => _isTrustedDevice;

  emailIsValid() {
    _isValidEmail = emailC.text.isNotEmpty &&
        emailC.text.contains("@") &&
        emailC.text.contains(".");
    notify();
  }

  btnIsValid() {
    return _isValidEmail && passwordC.text.length > 7;
  }
}

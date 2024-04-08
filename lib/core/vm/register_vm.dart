import 'package:cubex/core/core.dart';

class RegisterVM extends BaseVM {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController imageC = TextEditingController();

  ValidatorStatus _validatorStatus = ValidatorStatus();
  ValidatorStatus get validatorStatus => _validatorStatus;

  bool _isMatchingPassword = false;
  bool get isMatchingPassword => _isMatchingPassword;

  bool _isValidEmail = false;
  bool get isValidEmail => _isValidEmail;

  validatePassword(String password) {
    _validatorStatus = PasswordValidatorService().validate(password);
    notify();
  }

  passwordMatch(String confirmPassword) {
    _isMatchingPassword = PasswordValidatorService()
        .passwordMatch(passwordC.text.trim(), confirmPassword);
    notify();
  }

  emailIsValid() {
    _isValidEmail = emailC.text.isNotEmpty &&
        emailC.text.contains("@") &&
        emailC.text.contains(".");
    notify();
  }

  signupBtnIsValid() {
    return isValidEmail && validatorStatus.isValid;
  }

  clearData() {
    emailC.clear();
    passwordC.clear();
    confirmPassC.clear();
    phoneC.clear();
    addressC.clear();
    imageC.clear();
  }

  @override
  void dispose() {
    printty("RegisterVM disposed");

    emailC.dispose();
    passwordC.dispose();
    confirmPassC.dispose();
    phoneC.dispose();
    addressC.dispose();
    imageC.dispose();

    super.dispose();
  }
}

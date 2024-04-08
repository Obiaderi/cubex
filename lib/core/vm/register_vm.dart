import 'package:cubex/core/core.dart';

class RegisterVM extends BaseVM {
  TextEditingController userNameC = TextEditingController();
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
    return isValidEmail &&
        validatorStatus.isValid &&
        userNameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty &&
        addressC.text.isNotEmpty;
  }

  Future<ApiResponse> register() async {
    return makeRequest(
      method: DioHttpMethod.POST,
      endpoint: '/register',
      data: {
        "username": userNameC.text.trim(),
        "email": emailC.text.trim(),
        "password": passwordC.text.trim(),
        "phone": phoneC.text.trim(),
        "address": addressC.text.trim(),
        "image": imageC.text.trim(),
      },
      onSuccess: (data) {
        return ApiResponse(success: true);
      },
    );
  }

  clearData() {
    userNameC.clear();
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

    userNameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    confirmPassC.dispose();
    phoneC.dispose();
    addressC.dispose();
    imageC.dispose();

    super.dispose();
  }
}

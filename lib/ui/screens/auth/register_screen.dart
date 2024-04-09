import 'package:cubex/core/core.dart';
import 'package:cubex/ui/components/components.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _imageFocusNode = FocusNode();

  _unFocusAll() {
    _userNameFocusNode.unfocus();
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();
    _phoneFocusNode.unfocus();
    _addressFocusNode.unfocus();
    _imageFocusNode.unfocus();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterVM>(
      builder: (context, vm, _) {
        return BusyOverlay(
          show: vm.isBusy,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                "Register Screen",
                style: AppTypography.text16b,
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: Sizer.width(24))
                  .copyWith(top: Sizer.height(20)),
              child: ListView(
                children: [
                  const YBox(24),
                  CustomTextField(
                    labelText: "Username",
                    focusNode: _userNameFocusNode,
                    showLabelHeader: true,
                    borderRadius: Sizer.height(4),
                    controller: vm.userNameC,
                    onSubmitted: (_) {
                      _userNameFocusNode.unfocus();
                      _emailFocusNode.requestFocus();
                    },
                  ),
                  const YBox(24),
                  CustomTextField(
                    labelText: "Email",
                    focusNode: _emailFocusNode,
                    showLabelHeader: true,
                    borderRadius: Sizer.height(4),
                    controller: vm.emailC,
                    keyboardType: KeyboardType.email,
                    errorText: vm.emailC.text.isNotEmpty && !vm.isValidEmail
                        ? "Invalid Email"
                        : null,
                    onChanged: (_) => vm.emailIsValid(),
                    onSubmitted: (_) {
                      _emailFocusNode.unfocus();
                      _passwordFocusNode.requestFocus();
                    },
                  ),
                  const YBox(24),
                  CustomTextField(
                    labelText: "Password",
                    focusNode: _passwordFocusNode,
                    showLabelHeader: true,
                    borderRadius: Sizer.height(4),
                    controller: vm.passwordC,
                    isPassword: true,
                    onChanged: (val) => vm.validatePassword(val),
                    onSubmitted: (_) {
                      _passwordFocusNode.unfocus();
                      _confirmPasswordFocusNode.requestFocus();
                    },
                  ),
                  const YBox(24),
                  CustomTextField(
                    labelText: "Confirm Password",
                    focusNode: _confirmPasswordFocusNode,
                    showLabelHeader: true,
                    borderRadius: Sizer.height(4),
                    controller: vm.confirmPassC,
                    isPassword: true,
                    errorText: vm.confirmPassC.text.isNotEmpty &&
                            !vm.isMatchingPassword
                        ? "Passwords do not match"
                        : null,
                    onChanged: (val) => vm.passwordMatch(val),
                    onSubmitted: (_) {
                      _confirmPasswordFocusNode.unfocus();
                      _phoneFocusNode.requestFocus();
                    },
                  ),
                  const YBox(8),
                  Column(children: [
                    ValidationItemWidget(
                      label: "At least 8 characters long",
                      isValid: vm.validatorStatus.hasAtleast8Character,
                    ),
                    const YBox(8),
                    ValidationItemWidget(
                      label: "At least 1 capital letter",
                      isValid: vm.validatorStatus.containsUpperCase,
                    ),
                    const YBox(8),
                    ValidationItemWidget(
                      label: "At least 1 number",
                      isValid: vm.validatorStatus.containsANumber,
                    ),
                    const YBox(8),
                    ValidationItemWidget(
                      label: "At least 1 special character @ # \$ %r",
                      isValid: vm.validatorStatus.containsSpecialCharacter,
                    ),
                  ]),
                  const YBox(24),
                  CustomTextField(
                    labelText: "Phone Number",
                    focusNode: _phoneFocusNode,
                    showLabelHeader: true,
                    borderRadius: Sizer.height(4),
                    controller: vm.phoneC,
                    onChanged: (_) => vm.emailIsValid(),
                    onSubmitted: (_) {
                      _phoneFocusNode.unfocus();
                      _addressFocusNode.requestFocus();
                    },
                  ),
                  const YBox(24),
                  CustomTextField(
                    labelText: "Address",
                    focusNode: _addressFocusNode,
                    showLabelHeader: true,
                    borderRadius: Sizer.height(4),
                    controller: vm.addressC,
                    onSubmitted: (_) {
                      _addressFocusNode.unfocus();
                      _imageFocusNode.requestFocus();
                    },
                  ),
                  const YBox(24),
                  CustomTextField(
                    labelText: "Image",
                    focusNode: _imageFocusNode,
                    showLabelHeader: true,
                    borderRadius: Sizer.height(4),
                    controller: vm.imageC,
                    onSubmitted: (_) {
                      _unFocusAll();
                      _register();
                    },
                  ),
                  const YBox(100),
                  CustomButton(
                    height: 65,
                    onTap: () {
                      _unFocusAll();
                      _register();
                    },
                    online: vm.signupBtnIsValid(),
                    text: "Register",
                  ),
                  const YBox(30),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePath.loginScreen);
                    },
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Already have an account?  ",
                          style: AppTypography.text14.copyWith(
                            color: AppColors.gray500,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            height: 2,
                          ),
                          children: [
                            TextSpan(
                              text: "Log in",
                              style: AppTypography.text14.copyWith(
                                color: AppColors.lightBlue,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                height: 1.2,
                              ),
                            ),
                          ],
                        )),
                  ),
                  const YBox(80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _register() {
    context.read<RegisterVM>().register().then((value) {
      if (value.success) {
        FlushBarToast.fLSnackBar(
          message: "Registration Successful",
        ).show(context);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, RoutePath.loginScreen);
        });
      } else {
        FlushBarToast.fLSnackBar(
          message: value.message.toString(),
          backgroundColor: AppColors.red,
        ).show(context);
      }
    });
  }
}

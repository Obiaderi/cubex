import 'package:cubex/core/core.dart';
import 'package:cubex/ui/components/components.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _userNameFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(
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
                "Login Screen",
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
                    onChanged: (_) => vm.notify(),
                    onSubmitted: (_) {
                      _userNameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                    onChanged: (_) => vm.notify(),
                    onSubmitted: (_) {
                      _passwordFocusNode.unfocus();
                      _login();
                    },
                  ),
                  const YBox(25),
                  const YBox(220),
                  CustomButton(
                    height: 65,
                    onTap: () {
                      _login();
                    },
                    online: vm.btnIsValid(),
                    text: "Log in",
                  ),
                  const YBox(30),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePath.registerScreen);
                    },
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don’t have an account yet? ",
                          style: AppTypography.text14.copyWith(
                            color: AppColors.gray500,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            height: 2,
                          ),
                          children: [
                            TextSpan(
                              text: "Create Account",
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
                  const YBox(30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _login() {
    context.read<AuthVM>().login().then((value) {
      if (value.success) {
        FlushBarToast.fLSnackBar(
          message: "Login Successful",
        ).show(context);
        Navigator.pushReplacementNamed(context, RoutePath.profileScreen);
      } else {
        FlushBarToast.fLSnackBar(
          message: value.message.toString(),
          backgroundColor: AppColors.red,
        ).show(context);
      }
    });
  }
}

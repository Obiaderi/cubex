import 'package:cubex/core/core.dart';
import 'package:cubex/ui/components/components.dart';
import 'package:provider/provider.dart';

class WelcomneBackScreen extends StatefulWidget {
  const WelcomneBackScreen({super.key});

  @override
  State<WelcomneBackScreen> createState() => _WelcomneBackScreenState();
}

class _WelcomneBackScreenState extends State<WelcomneBackScreen> {
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    context.read<AuthVM>().getProfile();
  }

  _authenticate() {
    setState(() {
      _loading = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _loading = false;
      });
      Navigator.of(context).pushNamed(RoutePath.profileScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(
      builder: (context, vm, _) {
        return BusyOverlay(
          show: _loading,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                "CubeX",
                style: AppTypography.text18.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: Sizer.width(24))
                  .copyWith(top: Sizer.height(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Welcome back ",
                      style: AppTypography.text16.copyWith(
                        color: AppColors.gray500,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: vm.authUser?.username ?? "",
                          style: AppTypography.text16.copyWith(
                            color: AppColors.brandBlack,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                          ),
                        ),
                        TextSpan(
                          text: " to Cubex,",
                          style: AppTypography.text16.copyWith(
                            color: AppColors.gray500,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const YBox(50),
                  const TransactionPIN(),
                  const YBox(50),
                  CustomButton(
                    onTap: () {
                      if (vm.isAuthenticate) {
                        return _authenticate();
                      }
                      FlushBarToast.fLSnackBar(
                        message: "Please enter a valid passcode",
                        backgroundColor: AppColors.red,
                      ).show(context);
                    },
                    online: vm.passCode?.length == 4,
                    text: "Authenticate",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

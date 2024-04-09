import 'package:cubex/core/core.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthVM>().getUserFromStorage();
    });
    _animateOpacity();
  }

  void _animateOpacity() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _opacity = 1.0;
    });

    Future.delayed(const Duration(seconds: 4)).then((value) {
      if (context.read<AuthVM>().authUser != null) {
        Navigator.of(context).pushReplacementNamed(RoutePath.welcomeBack);
      } else {
        Navigator.of(context).pushReplacementNamed(RoutePath.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandBlue,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 3),
          child: const Text(
            'Welcome to Cubex',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

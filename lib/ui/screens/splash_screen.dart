import 'package:cubex/core/core.dart';

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
    _animateOpacity();
  }

  void _animateOpacity() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _opacity = 1.0;
    });

    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacementNamed(RoutePath.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandBlue,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 4),
          child: Text(
            'Welcome to Cubex',
            style: AppTypography.text32.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

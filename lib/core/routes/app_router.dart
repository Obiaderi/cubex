import 'package:cubex/core/core.dart';
import 'package:cubex/ui/screens/screens.dart';

class AppRouters {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutePath.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RoutePath.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RoutePath.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return errorScreen('No route defined for ${settings.name}');
    }
  }

  static MaterialPageRoute errorScreen(String msg) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(msg),
        ),
      ),
    );
  }
}

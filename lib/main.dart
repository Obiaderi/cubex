import 'package:cubex/core/core.dart';
import 'package:cubex/locator.dart';
import 'package:cubex/ui/screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MultiProvider(
          providers: allProviders,
          child: MaterialApp(
            title: 'Cubex',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              fontFamily: 'Inter',
              useMaterial3: true,
            ),
            navigatorKey: NavigatorKeys.appNavigatorKey,
            home: const SplashScreen(),
            onGenerateRoute: AppRouters.getRoute,
          ),
        );
      },
    );
  }
}

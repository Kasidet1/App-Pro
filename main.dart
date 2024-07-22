import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/facebook_login.dart';
import 'package:flutter_application_1/screens/google_login.dart';
import 'package:flutter_application_1/screens/register.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/pin_input_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/activities_screen.dart';
import 'services/mock_auth_service.dart';
import 'screens/new_activity_screen.dart' as new_activity;
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MockAuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifePlanner',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFB0BEC5), // Light Grey Blue
          secondary: Color(0xFFCFD8DC), // Very Light Blue
          background: Colors.white,
          surface: Color(0xFFECEFF1), // Very Light Grey
        ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(0xFF263238), // Dark Grey Blue
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: Color(0xFF455A64), fontSize: 16), // Grey Blue
          bodyMedium: TextStyle(color: Color(0xFF607D8B), fontSize: 14), // Light Grey Blue
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFFB0BEC5), // Light Grey Blue
          elevation: 1,
          iconTheme: IconThemeData(color: Color(0xFF263238)), // Dark Grey Blue
          titleTextStyle: TextStyle(
            color: Color(0xFF263238), // Dark Grey Blue
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: const Color(0xFFB0BEC5), // Light Grey Blue
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFCFD8DC), // Very Light Blue
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFECEFF1), // Very Light Grey
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 2), // Light Grey Blue
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/Register': (context) => Register(),
        '/Googlelogin': (context) => GoogleLogin(),
        '/FacebookLogin': (context) => FacebookLogin(),
        '/pin': (context) => PinInputScreen(),
        '/auth': (context) => AuthScreen(),
        '/new_activity': (context) => new_activity.NewActivityScreen(
              onAdd: (name, note, dateTime) {},
            ),
        '/activities': (context) => ActivitiesScreen(),
      },
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.75);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height * 0.85);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.7);
    var secondEndPoint = Offset(size.width, size.height * 0.85);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB0BEC5), Color(0xFFCFD8DC)], // Light Grey Blue to Very Light Blue
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: child,
      ),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFECEFF1), Color(0xFFF3F4F6)], // Very Light Grey to Almost White
          ),
        ),
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 200,
              ),
            ),
            GradientButton(
              onPressed: () {},
              child: const Text('Gradient Button'),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.white),
                title: Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                subtitle: Container(
                  width: double.infinity,
                  height: 12,
                  color: Colors.white,
                ),
              ),
            ),
            Lottie.asset(
              'assets/loading_animation.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}

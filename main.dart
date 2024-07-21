import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/facebook_login.dart';
import 'package:flutter_application_1/screens/google_login.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/pin_input_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/activities_screen.dart';
import 'services/mock_auth_service.dart';
import 'screens/new_activity_screen.dart' as new_activity;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MockAuthService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifePlanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<MockAuthService>(
        builder: (context, authService, _) {
          if (authService.user == null) {
            return LoginScreen();
          } else {
            return HomeScreen();
          }
        },
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/Googlelogin': (context) => GoogleLogin(),
        '/FacebookLogin': (context) => FacebookLogin(),
        '/pin': (context) => PinInputScreen(),
        '/auth': (context) => AuthScreen(),
        '/new_activity': (context) =>
            new_activity.NewActivityScreen(onAdd: (name, note, dateTime) {}),
        '/activities': (context) => ActivitiesScreen(),
      },
    );
  }
}

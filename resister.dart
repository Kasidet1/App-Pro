import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_auth_service.dart';

class Resister extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<MockAuthService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Resister')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'ComfirmPassword'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authService.signInWithEmail(
                  emailController.text,
                  passwordController.text,
                );
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
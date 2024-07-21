import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_auth_service.dart';

class Register extends StatelessWidget {  // เปลี่ยนชื่อคลาสเป็น Register
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();  // เพิ่ม Controller สำหรับ ConfirmPassword

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<MockAuthService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Register')),  // เปลี่ยนข้อความเป็น Register
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
              controller: confirmPasswordController,  // เพิ่ม Controller
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,  // เพิ่ม obscureText
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
              child: Text('Register'),  // เปลี่ยนข้อความเป็น Register
            ),
            SizedBox(height: 10),  // เพิ่มระยะห่างระหว่างปุ่ม
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');  // เพิ่มการนำทางกลับไปหน้า Login
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

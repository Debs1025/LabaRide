import 'package:flutter/material.dart';
import 'loginscreen_user.dart';

class SignUpCompleteScreen extends StatefulWidget {
  const SignUpCompleteScreen({super.key});

  @override
  State<SignUpCompleteScreen> createState() => _SignUpCompleteScreenState();
}

class _SignUpCompleteScreenState extends State<SignUpCompleteScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 180,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/blacklogo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Positioned(
              bottom: 10,
              child: Text(
                'Sign Up Complete',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A0066),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
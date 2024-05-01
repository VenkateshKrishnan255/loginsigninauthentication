import 'package:flutter/material.dart';
import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome To Flutter Firebase',
          style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

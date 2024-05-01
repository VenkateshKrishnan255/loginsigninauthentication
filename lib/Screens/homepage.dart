import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_venkat/Screens/loginpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text(
          "HomePage",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome To Home',style: TextStyle(fontSize: 18),),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(),),);
              },
              child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

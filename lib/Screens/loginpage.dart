import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_authentication_venkat/Screens/signuppage.dart';
import 'package:flutter_authentication_venkat/Widget/custom_textformfield.dart';
import '../UserAuth/firebase_auth_services.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    print('------------>Dispose Execute');
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 15,
              ),
              Custom_TextFormField(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 15,
              ),
              Custom_TextFormField(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _logIn,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(fontSize: 14),),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignupPage(),), (route) => false);
                    },
                    child: Text('Sign Up',style: TextStyle(color: Colors.red,fontSize: 15),),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logIn() async {
    print('------------>Sign Up Execute');

    // Get Data From User
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Email validation
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter an email')),
      );
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    // Password validation
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a password')),
      );
      return;
    } else if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 6 characters long')),
      );
      return;
    }

    try {
      // Attempt to sign up with email and password
      User? user = await _auth.loginwithEmailAndPassword(email, password);

      // Check if user creation was successful
      if (user != null) {
        print('------------>User is Successfully Created');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error in Sign Up')),
        );
        print('------------>Error in Sign Up');
      }
    } catch (e) {
      // Handle any exceptions that may present
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during sign-up: ${e.toString()}')),
      );
      print('Error during sign-up: $e');
    }
  }
}

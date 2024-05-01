import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_venkat/Screens/homepage.dart';
import 'package:flutter_authentication_venkat/UserAuth/firebase_auth_services.dart';
import 'package:flutter_authentication_venkat/Widget/custom_textformfield.dart';
import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    print('------------>Dispose Execute');
    _usernameController.dispose();
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
        title: const Text(
          "SignUp",
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
              const Text(
                'SignUp',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 15,
              ),
              Custom_TextFormField(
                controller: _usernameController,
                hintText: "Username",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 15,
              ),
              Custom_TextFormField(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 15,
              ),
              Custom_TextFormField(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _signUp,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have a account",style: TextStyle(fontSize: 14),),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
                    },
                    child: Text('Login Up',style: TextStyle(color: Colors.red,fontSize: 15),),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    print('------------>Sign Up Execute');

    // Get Data From User
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Username validation
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a username')),
      );
      return;
    } else if (username.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username must be at least 3 characters long')),
      );
      return;
    }

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
      User? user = await _auth.signupwithEmailAndPassword(email, password);

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
      // Handle any exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during sign-up: ${e.toString()}')),
      );
      print('Error during sign-up: $e');
    }
  }


}

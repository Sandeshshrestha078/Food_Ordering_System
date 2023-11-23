// import 'dart:html';

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_users/screens/home_screen.dart';
import 'package:food_users/widget/textfield.dart';

// import '../../dashpage/home_screen.dart';
// import '../forget_password/forget_pwd_optn/forget_pwd_buttom_sheet.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // Function to handle the login process
  void login(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreeen()));
      }

      // Handle successful login
      log('User logged in: ${userCredential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      // Handle login error
      log('Login error: ${e.code.toString()}');
      //  Display an error message to the user
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.code.toString()}')));
    } catch (e) {
      // Handle other exceptions
      log('Error occurred during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*-- section 1  start */
            Image(
                image: const AssetImage('assets/images/login.jpg'),
                height: size.height * 0.2),
            const Text(
              'Welcome Back,',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Unlock flavor with a login.',
              style: TextStyle(fontSize: 18.0, color: Colors.black54),
            ),

            /*-- section 1  ends */

            /*-- section 2 [form] start */
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextFormField(
                        controller: emailController,
                        tohide: false,
                        msg: 'Enter your email',
                        label: 'E-mail',
                        prefixIcon: const Icon(
                          Icons.person_outline_outlined,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CommonTextFormField(
                        controller: passwordController,
                        tohide: true,
                        msg: 'Enter your password',
                        label: 'Password',
                        prefixIcon: const Icon(
                          Icons.fingerprint_outlined,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // If the form is valid, call createAccount
                                login(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white),
                            child: const Text('LOGIN')),
                      )
                    ]),
              ),
            ),
            /*-- section 2 [form] ends */

            /*-- section 3  starts */

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const SignIn())));
                        },
                        child: const Text.rich(TextSpan(
                            text: "Don't have an Account? ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            children: [
                              TextSpan(
                                text: "Signup",
                                style: TextStyle(color: Colors.blue),
                              )
                            ]))),
                  )
                ],
              ),
            )
            /*-- section 3 ends */
          ],
        ),
      ))),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_user/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_user/widget/textfield.dart';

// import 'package:get/get.dart';

// import '../login/login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Function to create a new user account
  Future<void> createAccount(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save user details in Firestore collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      });

      // Clear text fields
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();

      // Navigate to the SignIn screen
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );

      // If the account creation is successful, you can do additional tasks here
      log('Account created: ${userCredential.user!.uid}');

      // Navigate to another screen or perform any other actions
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      // Handle other FirebaseAuthException cases as needed
    } catch (e) {
      log('Error occurred: $e');
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
                /* section 1[header] starts*/
                Image(
                  image: const AssetImage('assets/images/signup.jpg'),
                  height: size.height * 0.2,
                ),
                const Text('Get On Board!',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                const Text("Satisfy cravings, create tasty moments.",
                    style: TextStyle(fontSize: 18.0, color: Colors.black54)),

                /* section 1[header] starts*/

                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        CommonTextFormField(
                            controller: nameController,
                            tohide: false,
                            msg: 'Enter your name',
                            label: 'Full Name',
                            prefixIcon:
                                const Icon(Icons.person_outline_outlined)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CommonTextFormField(
                          controller: emailController,
                          tohide: false,
                          msg: 'Enter your email',
                          label: 'E-Mail',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CommonTextFormField(
                          controller: phoneController,
                          tohide: false,
                          msg: 'Enter your phone number',
                          label: 'Phone Number',
                          prefixIcon: const Icon(
                            Icons.phone_android_rounded,
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
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // If the form is valid, call createAccount
                                  createAccount(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white),
                              child: const Text('SIGNUP')),
                        ),
                      ],
                    ),
                  ),
                ),
                /* Section 2 [form] ends*/

                /* Section 3[footer] starts*/
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => const SignIn())));
                            },
                            child: const Text.rich(TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                children: [
                                  TextSpan(
                                    text: "LOGIN",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ]))),
                      )
                    ],
                  ),
                )
                /* Section 3[footer] ends*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

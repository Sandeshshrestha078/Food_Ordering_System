// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:food_user/screens/signup_screen.dart';

// import '../../dashpage/home_screen.dart';
// import '../forget_password/forget_pwd_optn/forget_pwd_buttom_sheet.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline_outlined,
                          ),
                          labelText: 'E-Mail',
                          labelStyle: TextStyle(),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.fingerprint_outlined,
                          ),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
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
                            onPressed: () {},
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
                  const Text(
                    'OR',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage('assets/images/googlelogo.png'),
                          width: 20.0,
                        ),
                        label: const Text('Sign-in with google'),
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            side: const BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const SignUp())));
                      },
                      child: const Text.rich(TextSpan(
                          text: "Don't have an Account? ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: "Signup",
                              style: TextStyle(color: Colors.blue),
                            )
                          ])))
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

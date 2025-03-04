import 'package:flutter/material.dart';
import 'package:flutter_plant/plant/constants.dart';
import 'package:flutter_plant/plant/root_page.dart';
import 'package:flutter_plant/plant/screens/custom_textField.dart';
import 'package:flutter_plant/plant/screens/forgot_password.dart';
import 'package:flutter_plant/plant/screens/signup_page.dart';
import 'package:page_transition/page_transition.dart';






class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/signin.jpg"),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const CustomTextField(
                icon: Icons.alternate_email,
                obscureText: false,
                hintText: 'Enter Email',
              ),
              const CustomTextField(
                icon: Icons.lock,
                obscureText: true,
                hintText: 'Enter Password',
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const RootPage(),
                        type: PageTransitionType.bottomToTop,
                      ));
                },
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text('Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const ForgotPassword(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Center(
                    child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'Forgot Password',
                    style: TextStyle(
                      color: Constants.blackColor,
                    ),
                  ),
                  TextSpan(
                    text: 'Reset Here',
                    style: TextStyle(
                      color: Constants.primaryColor,
                    ),
                  ),
                ]))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('OR'),
                ),
                Expanded(child: Divider()),
              ]),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Image.asset('assets/images/google.jpg'),
                        ),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Constants.blackColor,
                            fontSize: 18.0,
                          ),
                        ),
                      ])),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const SignUp(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Center(
                    child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "New to Natty's plant World",
                    style: TextStyle(
                      color: Constants.blackColor,
                    ),
                  ),
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(
                      color: Constants.primaryColor,
                    ),
                  ),
                ]))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_plant/plant/constants.dart';
import 'package:flutter_plant/plant/screens/custom_textField.dart';
import 'package:flutter_plant/plant/screens/signin_page.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current screen size
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/signup.jpg"),
              const Text(
                'Sign Up',
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
                icon: Icons.person,
                obscureText: false,
                hintText: 'Enter Full Name',
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
                  // Add sign-up logic here
                },
                child: Container(
                  width: size.width, // Use size.width to get the screen width
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
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
                width: size.width, // Use size.width here as well
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
                        'Sign Up with Google',
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const SignIn(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Center(
                    child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Have an account in Natty's plant World?",
                    style: TextStyle(
                      color: Constants.blackColor,
                    ),
                  ),
                  TextSpan(
                    text: 'Login',
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/view/home/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/splash_screen.jpg',
                  fit: BoxFit.cover,
                  width: width* .9,
                  height: height * .5,
                    ),
                    SizedBox(height: height * 0.04,),
                    Text('TOP HEADLINES', style: GoogleFonts.anton(letterSpacing: .6, color: Colors.grey.shade700),),
                    SizedBox(height: height * 0.04),
                    SpinKitChasingDots(
                      color: Colors.blue,
                      size: 40,
                    ),
                ],
              ),
            ),
          );
  }
}

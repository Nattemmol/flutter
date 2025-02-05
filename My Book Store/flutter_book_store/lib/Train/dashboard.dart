import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("DashBoard"),
        ),
        body: Container(
            width: 350.0,
            height: 250.0,
            padding: const EdgeInsets.all(30.0),
            margin: const EdgeInsets.all(40.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey, width: 6.0),
                shape: BoxShape.circle,
                image:const DecorationImage(
                    image: AssetImage("lib/Resources/images/Tsion.jpg"),
                    )
                    ),
            child: const Text(
              'Container',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )));
  }
}

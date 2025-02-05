import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: NinjaCard(),
    ));

class NinjaCard extends StatefulWidget {
  const NinjaCard({super.key});

  @override
  State<NinjaCard> createState() => _NinjaCardState();
}

class _NinjaCardState extends State<NinjaCard> {
  int _level = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("NInja ID card",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _level++;
          });
        },
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            const  Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('Resources/images/Tsion.jpg'),
                  radius: 40.0,
                ),
              ),
            const  Divider(
                height: 60.0,
                color: Colors.amber,
              ),
              const Text('Name',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  )),
            const  SizedBox(height: 10.0),
          const   Text('Natty up',
                  style: TextStyle(
                    color: Colors.yellow,
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  )),
          const    SizedBox(height: 10.0),
          const    Text('Current NInja level:',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  )),
            const  SizedBox(height: 10.0),
              Text('$_level',
                  style:const TextStyle(
                    color: Colors.yellow,
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  )),
            const  SizedBox(height: 30.0),
            const  Row(children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(width: 20.0),
                Text('nattemmol@gmail.com',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    )),
              ]),
            ]),
      ),
    );
  }
}

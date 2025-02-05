import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(
          backgroundColor: Colors.amber,
            child:  Icon(Icons.alarm_on_sharp),),
          title: const Text('sales'),
          subtitle:const Text('sales of the week'),
          trailing:const Text('200'),
          onTap: (){},
          ),
          ListTile(
          leading: const Icon(Icons.alarm_on_sharp),
          title: const Text('customer'),
          subtitle: const Text('sales of the week'),
          trailing: const Text('200'),
          onTap: (){},
          ),
          ListTile(
          leading: const Icon(Icons.alarm_on_sharp),
          title: const Text('owners'),
          subtitle: const Text('sales of the week'),
          trailing: const Text('200'),
          onTap: (){},
          ),
          ListTile(
          leading: const Icon(Icons.alarm_on_sharp),
          title: const Text('sales'),
          subtitle: const Text('sales of the week'),
          trailing: const Text('200'),
          onTap: (){},
          ),
          ListTile(
          leading:  const Icon(Icons.alarm_on_sharp),
          title:  const Text('sales'),
          subtitle: const Text('sales of the week'),
          trailing: const Text('200'),
          onTap: (){},
          ),
        ],
      )
    );
  }
}

void main() {
  runApp(const Home());
}

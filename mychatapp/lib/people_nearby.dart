import 'package:flutter/material.dart';

class PeopleNearbyPage extends StatelessWidget {
  const PeopleNearbyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(72, 33, 149, 243),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('People Nearby'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action to search nearby people
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20, // Example item count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Person $index'),
            subtitle: const Text('Nearby'),
            onTap: () {
              // Action when person is tapped
            },
          );
        },
      ),
    );
  }
}

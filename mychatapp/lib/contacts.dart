import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(15, 33, 149, 243),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action to search contacts
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20, // Example item count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Contact $index'),
            subtitle: const Text('Online'),
            onTap: () {
              // Action when contact is tapped
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new contact
        },
        backgroundColor:const Color.fromARGB(154, 61, 33, 243),
        child: const Icon(Icons.add),
      ),
    );
  }
}

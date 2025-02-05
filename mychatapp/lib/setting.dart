import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('John Doe'),
            Text(
              'Online',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action to search users
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Action to go to profile page
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat Setting'),
            onTap: () {
              // Action for chat setting
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy and Security'),
            onTap: () {
              // Action for privacy and security setting
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification and Sound'),
            onTap: () {
              // Action for notification and sound setting
            },
          ),
          ListTile(
            leading: const Icon(Icons.data_usage),
            title: const Text('Data and Storage'),
            onTap: () {
              // Action for data and storage setting
            },
          ),
          ListTile(
            leading: const Icon(Icons.power),
            title: const Text('Power Saving'),
            onTap: () {
              // Action for power saving setting
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('English'),
            onTap: () {
              // Action for language setting
            },
          ),
        ],
      ),
    );
  }
}

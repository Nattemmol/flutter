import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Name'),
              onTap: () {
                // Action for editing name
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Set Profile Photo'),
              onTap: () {
                // Action for setting profile photo
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Action for setting profile
              },
              icon: const Icon(Icons.person),
              label: const Text('Set Profile'),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                // Action for logging out
              },
            ),
          ],
        ),
      ),
    );
  }
}

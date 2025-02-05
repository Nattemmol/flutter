import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assuming GetX for routing (optional)

void main() {
  runApp(const MaterialApp(
    home: ProfileScreen(),
  ));
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? Icons.brightness_auto : Icons.brightness_high),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildProfileImage(),
              const SizedBox(height: 10),
              buildProfileText(context: context, title: 'Your Name', subtitle: 'Your Description'),
              const SizedBox(height: 20),
              buildEditProfileButton(),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              buildMenuOption(context: context, title: 'Settings', icon: Icons.settings),
              buildMenuOption(context: context, title: 'Billing Details', icon: Icons.account_balance_wallet),
              buildMenuOption(context: context, title: 'User Management', icon: Icons.account_circle),
              const Divider(),
              const SizedBox(height: 10),
              buildMenuOption(context: context, title: 'Information', icon: Icons.info),
              buildMenuOption(
                context: context,
                title: 'Logout',
                icon: Icons.exit_to_app,
                textColor: Colors.red,
              ), // Removed the undefined 'endIcon' parameter
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widgets for better code organization
  Widget buildProfileImage() {
    return const Stack(
      // ... (details remain the same)
    );
  }

  Widget buildProfileText({required BuildContext context, required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
Widget buildEditProfileButton() {
  return SizedBox(
    width: 200,
    child: ElevatedButton(
      onPressed: null, // Disabled for UI-only mode
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        side: BorderSide.none,
        shape: const StadiumBorder(),
      ),
      child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
    ),
  );
}


  Widget buildMenuOption({required BuildContext context, required String title, required IconData icon, Color textColor = Colors.black}) {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}

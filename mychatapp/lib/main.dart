import 'package:flutter/material.dart';
import 'stories.dart'; // Importing the Stories page
import 'profile.dart'; // Importing the Profile page
import 'people_nearby.dart'; // Importing the People Nearby page
import 'contacts.dart'; // Importing the Contacts page
import 'setting.dart'; // Importing the Settings page

void showMenuOverlay(BuildContext context) {
  final overlay = OverlayEntry(
    builder: (context) => GestureDetector(
      onTap: () {
        removeOverlay(context); // Dismiss overlay when tapped outside
      },
      child: Positioned(
        top: kToolbarHeight,
        left: 0,
        right: MediaQuery.of(context).size.width / 2,
        bottom: 0,
        child: Material(
          color: Colors.blue.withOpacity(0.9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuItem(Icons.camera, 'Stories', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StoriesPage()),
                );
                removeOverlay(context);
              }),
              _buildMenuItem(Icons.person, 'Profile', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                removeOverlay(context);
              }),
              _buildMenuItem(Icons.people, 'People Nearby', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PeopleNearbyPage()),
                );
                removeOverlay(context);
              }),
              _buildMenuItem(Icons.contacts, 'Contacts', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactsPage()),
                );
                removeOverlay(context);
              }),
              _buildMenuItem(Icons.settings, 'Settings', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
                removeOverlay(context);
              }),
            ],
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlay);
}

void removeOverlay(BuildContext context) {
  Navigator.pop(context); // Remove overlay by popping the route
}

Widget _buildMenuItem(IconData icon, String title, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

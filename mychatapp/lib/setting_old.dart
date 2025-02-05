import 'package:flutter/material.dart';

void main() {
  runApp(const SettingsPage());
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              ListTile(
                leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Image(
                      image: AssetImage('Resources/1.jpeg'),
                    )),
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Natty Tem',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'nattemmol@gmail.com',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.grey, size: 30),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 30.0),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.language,
                      color: Colors.orange, size: 30),
                ),
                title: const Text('Language'),
                trailing: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.orange, size: 30),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.notifications,
                      color: Colors.blue, size: 30),
                ),
                title: const Text('Notifications'),
                trailing: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.blue, size: 30),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.privacy_tip,
                      color: Colors.red, size: 30),
                ),
                title: const Text('Privacy'),
                trailing: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.red, size: 30),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.help_center,
                      color: Colors.green, size: 30),
                ),
                title: const Text('Help Center'),
                trailing: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.green, size: 30),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.info, color: Colors.blue, size: 30),
                ),
                title: const Text('About Us'),
                trailing: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.blue, size: 30),
                ),
              ),
              const SizedBox(height: 40.0),
              const Divider(height: 20.0),
              const SizedBox(height: 50.0),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.dark_mode,
                      color: Color.fromARGB(255, 18, 54, 117), size: 30),
                ),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  //value: isDarkMode, // Assuming isDarkMode is a boolean variable determining the current mode
                  onChanged: (bool value) {},
                  activeColor: const Color.fromARGB(255, 20, 70, 111),
                  activeTrackColor: Colors.blueAccent[100], value: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

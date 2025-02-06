import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];
          final email = user['email']['first'];
          final name = user['name'];
          final imageUrl = user['picture']['medium'];
          return ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(imageUrl)),
            title: Text(email.toString()),
            subtitle: Text(name),
          );
        },
      ),
    );
  }

  void fetchUsers() async {
    if (kDebugMode) {
      print('fetchUsers called');
    }
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        users = json['results'];
      });
      // ignore: avoid_print
      print('fetchUsers completed');
    } else {
      if (kDebugMode) {
        print('failed to fetch users. Status code: ${response.statusCode}');
      }
    }
  }
}

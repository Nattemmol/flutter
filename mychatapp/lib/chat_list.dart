import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15, // Example item count
      itemBuilder: (context, index) {
        return ChatListItem(
          username: 'User $index',
          message: 'Hello!',
        );
      },
    );
  }
}

class ChatListItem extends StatelessWidget {
  final String username;
  final String message;

  const ChatListItem({
    Key? key,
    required this.username,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Image.asset(
            'Resources/1.jpeg'), // Replace with your image
      ),
      title: Text(
        username,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(message),
      trailing: const Icon(Icons.send),
    );
  }
}

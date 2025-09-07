import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/inbox_service.dart';
import '../../services/auth_service.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  bool _isLoading = false;
  List<dynamic> _messages = [];
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUser = await authService.getCurrentUser();
      setState(() {
        _userId = currentUser.id;
      });
      _loadMessages();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loadMessages() async {
    if (_userId == null) return;

    setState(() => _isLoading = true);
    try {
      final inboxService = Provider.of<InboxService>(context, listen: false);
      final messages = await inboxService.getInboxMessages(_userId!);
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _sendMessage(String receiverId, String message) async {
    if (_userId == null) return;

    try {
      final inboxService = Provider.of<InboxService>(context, listen: false);
      await inboxService.createMessage(
        senderId: _userId!,
        receiverId: receiverId,
        message: message,
      );
      _loadMessages();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _markAsRead(String messageId) async {
    try {
      final inboxService = Provider.of<InboxService>(context, listen: false);
      await inboxService.updateMessage(
        messageId,
        isRead: true,
      );
      _loadMessages();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMessages,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _messages.isEmpty
              ? const Center(
                  child: Text('No messages'),
                )
              : ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          message['sender']['profileImage'] ??
                              'https://placeholder.com/150',
                        ),
                      ),
                      title: Text(message['sender']['name']),
                      subtitle: Text(
                        message['message'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: !message['isRead']
                          ? Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            )
                          : null,
                      onTap: () {
                        if (!message['isRead']) {
                          _markAsRead(message['id']);
                        }
                        // Show message details
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(message['sender']['name']),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(message['message']),
                                const SizedBox(height: 16),
                                Text(
                                  'Sent: ${DateTime.parse(message['createdAt']).toLocal()}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showReplyDialog(message['sender']['id']);
                                },
                                child: const Text('Reply'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }

  void _showReplyDialog(String receiverId) {
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reply'),
        content: TextField(
          controller: messageController,
          decoration: const InputDecoration(
            hintText: 'Type your message...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                _sendMessage(receiverId, messageController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}

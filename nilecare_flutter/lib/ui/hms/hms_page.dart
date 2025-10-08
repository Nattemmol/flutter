import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/hms_service.dart';
import '../../services/auth_service.dart';

class HmsPage extends StatefulWidget {
  const HmsPage({Key? key}) : super(key: key);

  @override
  State<HmsPage> createState() => _HmsPageState();
}

class _HmsPageState extends State<HmsPage> {
  bool _isLoading = false;
  String? _userId;
  String? _roomId;
  String? _token;

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
      if (_userId != null) {
        _joinRoom();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _joinRoom() async {
    setState(() => _isLoading = true);
    try {
      final hmsService = Provider.of<HMSService>(context, listen: false);
      final result = await hmsService.joinRoom(
        userName: _userId!,
        role: 'doctor',
        roomName: 'Hospital Management Room',
      );
      setState(() {
        _roomId = result['roomId'];
        _token = result['token'];
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Management'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _roomId == null || _token == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Unable to join hospital management room',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _joinRoom,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 64,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Successfully joined hospital management room',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Room ID: $_roomId',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to video call or other HMS features
                        },
                        child: const Text('Start Session'),
                      ),
                    ],
                  ),
                ),
    );
  }
}

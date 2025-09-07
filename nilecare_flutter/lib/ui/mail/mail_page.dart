import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mail_service.dart';

class MailPage extends StatefulWidget {
  const MailPage({Key? key}) : super(key: key);

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final _formKey = GlobalKey<FormState>();
  final _toController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _toController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final mailService = Provider.of<MailService>(context, listen: false);
      await mailService.sendEmail(
        to: _toController.text,
        subject: _subjectController.text,
        html: _bodyController.text,
      );

      _toController.clear();
      _subjectController.clear();
      _bodyController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Email'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _toController,
                decoration: const InputDecoration(
                  labelText: 'To',
                  hintText: 'recipient@example.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter recipient email';
                  }
                  if (!value!.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  hintText: 'Enter email subject',
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a subject' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter your message',
                  alignLabelWithHint: true,
                ),
                maxLines: 10,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a message' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _sendEmail,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Send Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthdayController = TextEditingController();

  String _selectedGender = "male";
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final fullName =
          "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}";

      final result = await _authService.register(
        name: fullName,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      );

      if (!mounted) return;

      if (result["success"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful! Please log in.")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result["message"] ?? "Registration failed")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: "First Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter first name" : null,
              ),
              const SizedBox(height: 12),

              // Last Name
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: "Last Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter last name" : null,
              ),
              const SizedBox(height: 12),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter email";
                  if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter phone number" : null,
              ),
              const SizedBox(height: 12),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                    value == null || value.length < 6
                        ? "Password must be at least 6 chars"
                        : null,
              ),
              const SizedBox(height: 12),

              // Birthday (not sent yet, but UI shows)
              TextFormField(
                controller: _birthdayController,
                decoration: const InputDecoration(labelText: "Birthday (yyyy-mm-dd)"),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialDate: DateTime(2000),
                  );
                  if (picked != null) {
                    _birthdayController.text =
                        "${picked.year}-${picked.month}-${picked.day}";
                  }
                },
              ),
              const SizedBox(height: 12),

              // Gender
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: const [
                  DropdownMenuItem(value: "male", child: Text("Male")),
                  DropdownMenuItem(value: "female", child: Text("Female")),
                  DropdownMenuItem(value: "other", child: Text("Other")),
                ],
                onChanged: (val) => setState(() => _selectedGender = val!),
                decoration: const InputDecoration(labelText: "Gender"),
              ),
              const SizedBox(height: 24),

              // Submit button
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _register,
                      child: const Text("Register"),
                    ),

              const SizedBox(height: 16),

              // Go to login
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

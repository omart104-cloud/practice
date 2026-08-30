import 'package:flutter/material.dart';
import 'package:practice/screens/post_screen.dart';
import 'package:practice/screens/widgets/custom_text_field.dart';
import 'package:practice/screens/task_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //1. Global Key
  final _formKey = GlobalKey<FormState>();

  //2. Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //3. Hide Password
  final bool _isPasswordHidden = true;
  bool _rememberMe = false;

  void _submitForm() {
    // trigger validation in all fields
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PostScreen()),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Practice")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Email Field
              CustomTextField(
                controller: _emailController,
                label: "Email Address",
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  // Regular expression for standard email syntax
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                label: "Password",
                prefixIcon: Icons.lock,
                isPassword: true,
                validator: (val) => val != null && val.length >= 6
                    ? null
                    : 'Min 6 characters required',
              ),
              const SizedBox(height: 30),
              //Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Login", style: TextStyle(fontSize: 18)),
                ),
              ),
              CheckboxListTile(
                title: Text("Remember Me"),
                value: _rememberMe,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (bool? newValue) {
                  setState(() {
                    _rememberMe = newValue ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

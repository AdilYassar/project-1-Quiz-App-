import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/utils/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final userName = _userNameController.text.trim();
      final password = _passwordController.text.trim();

      // Check for admin login
      if (userName == "Admin" && password == "admin") {
        // Navigate to AdminDashboard
        Get.toNamed('/AdminDashboard');
      } else if (userName != "" && password != "") {
        // Navigate to QuizCategory
        Get.toNamed('/QuizCategory');
      } else {
        // Show an error message if credentials are incorrect
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid username or password"),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      "Welcome to the Quiz App",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Let's test your knowledge!",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _userNameController,
                            decoration: const InputDecoration(
                              labelText: "Username",
                              hintText: "Enter your username",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your username";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .black, // Set the button background color
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

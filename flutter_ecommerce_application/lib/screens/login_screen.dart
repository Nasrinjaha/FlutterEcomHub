import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_application/screens/admin_home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggingIn = false;

  // Create a GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Check if the form is valid before proceeding
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoggingIn = true;
      });

      try {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

         await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login successful!")));

        // Clear the controllers after successful login
        emailController.clear();
        passwordController.clear();

        // Navigate to the home page or next screen after successful login
         Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>AdminHomeScreen()),
        );

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed: $e")));
      } 
    }
  }

  InputDecoration customInputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      labelText: hintText,
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color.fromARGB(255, 10, 10, 10), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page"),
              backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key
          autovalidateMode: AutovalidateMode.onUserInteraction, // Enable auto-validation
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login to Your Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Email Field
              TextFormField(
                controller: emailController,
                decoration: customInputDecoration("Email", Icons.email),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Password Field
              TextFormField(
                controller: passwordController,
                decoration: customInputDecoration("Password", Icons.lock),
                obscureText: true, // Hide the password
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoggingIn ? null : _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoggingIn
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Login",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("Don't have an account? "),
              //     GestureDetector(
              //       onTap: () {
              //         // Navigate to sign-up page
              //         Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (context) => SignUpPage()),
              //         );
              //       },
              //       child: Text(
              //         "Sign Up",
              //         style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

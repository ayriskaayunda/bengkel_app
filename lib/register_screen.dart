// lib/screens/register_screen_api.dart
import 'package:bengkel_app/constant/app_color.dart';
import 'package:flutter/material.dart';

// Import your API service and models
import 'package:bengkel_app/services/api_service.dart'; // Adjust if your project structure is different
import 'package:bengkel_app/models/register_response.dart'; // Import the RegisterResponse model

class RegisterScreenApi extends StatefulWidget {
  const RegisterScreenApi({super.key});
  static const String id =
      "/register_screen_api"; // Define a route ID for navigation

  @override
  State<RegisterScreenApi> createState() => _RegisterScreenApiState();
}

class _RegisterScreenApiState extends State<RegisterScreenApi> {
  // Instantiate the API service
  final ApiService _apiService =
      ApiService(); // Use ApiService instead of UserService

  // State variables for UI and form handling
  bool isVisibility = false; // For password visibility toggle
  bool isLoading = false; // To show a loading indicator during API calls
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // GlobalKey for form validation

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Handles the registration process by calling the API service.
  Future<void> _handleRegister() async {
    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      return; // If validation fails, stop here
    }

    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      final RegisterResponse? response = await _apiService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (response != null && response.data?.token != null) {
        // Registration successful
        // Token is automatically saved by ApiService internally now.

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration successful! You can now login."),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to the login screen
        Navigator.pop(context);
      } else {
        // Registration failed (e.g., email already taken, validation errors from API)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response?.message ?? 'Registration failed. Please try again.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Catch any unexpected errors (e.g., network issues)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey, // Assign the form key
        child: Stack(
          children: [
            buildBackground(), // Renders the background image
            buildLayer(), // Renders the main content layer
          ],
        ),
      ),
    );
  }

  /// Builds the main content layer including text fields and buttons.
  SafeArea buildLayer() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            // Added SingleChildScrollView to prevent overflow
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ), // Added white color
                ),
                height(12),
                Text(
                  "Register your account",
                  style: TextStyle(fontSize: 14, color: AppColor.gray88),
                ),
                height(24),
                buildTitle("Email Address"),
                height(12),
                buildTextField(
                  hintText: "Enter your email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                height(16),
                buildTitle("Name"), // Changed "Nama" to "Name" for consistency
                height(12),
                buildTextField(
                  hintText: "Enter your name",
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                height(16),
                buildTitle("Password"),
                height(12),
                buildTextField(
                  hintText: "Enter your password",
                  isPassword: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      // Example: Minimum password length
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                height(12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password functionality if applicable for registration flow
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Forgot Password functionality not applicable here.',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?", // This might not be relevant on a registration screen
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                height(24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : _handleRegister, // Disable button when loading
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blueButton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          ) // Show loading indicator
                        : const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                height(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account?",
                      style: TextStyle(fontSize: 12, color: AppColor.gray88),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate back to the login screen
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppColor.blueButton,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the background container with an image.
  Container buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/background.png",
          ), // Ensure this asset is correctly configured in pubspec.yaml
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Helper widget for vertical spacing.
  SizedBox height(double height) => SizedBox(height: height);

  /// Helper widget for horizontal spacing.
  SizedBox width(double width) => SizedBox(width: width);

  /// Builds a title text for input fields.
  Widget buildTitle(String text) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 12, color: AppColor.gray88)),
      ],
    );
  }

  /// Builds a customizable text field.
  Widget buildTextField({
    String? hintText,
    bool isPassword = false,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text, // Default to text
    String? Function(String?)? validator, // Validator function
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType, // Set keyboard type
      validator: validator, // Assign validator
      obscureText: isPassword
          ? !isVisibility
          : false, // Use !isVisibility for obscureText
      style: const TextStyle(color: Colors.black), // Set text color to black
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ), // Hint text color
        filled: true,
        fillColor: Colors.white, // Background color for the text field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          // Error border style
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // Focused error border style
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisibility = !isVisibility;
                  });
                },
                icon: Icon(
                  isVisibility
                      ? Icons.visibility
                      : Icons.visibility_off, // Corrected icon logic
                  color: AppColor.gray88,
                ),
              )
            : null,
      ),
    );
  }
}

// lib/screens/login_screen_api.dart
import 'package:flutter/material.dart';
import 'package:bengkel_app/constant/app_color.dart'; // Ensure this path is correct

// Import your API service and models
import 'package:bengkel_app/services/api_service.dart'; // Adjust if your project structure is different
import 'package:bengkel_app/services/token_manager.dart'; // Adjust if your project structure is different
import 'package:bengkel_app/models/login_response.dart'; // Adjust if your project structure is different

class LoginScreenApi extends StatefulWidget {
  const LoginScreenApi({super.key});
  static const String id =
      "/login_screen_api"; // Define a route ID for navigation

  @override
  State<LoginScreenApi> createState() => _LoginScreenApiState();
}

class _LoginScreenApiState extends State<LoginScreenApi> {
  // State variables for UI and form handling
  bool isVisibility = false; // For password visibility toggle
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // GlobalKey for form validation
  bool _isLoading = false; // To show a loading indicator during API calls

  // Instantiate the API service and token manager
  final ApiService _apiService = ApiService();
  final TokenManager _tokenManager = TokenManager();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Handles the login process by calling the API service.
  Future<void> _handleLogin() async {
    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      return; // If validation fails, stop here
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      final LoginResponse? response = await _apiService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response != null && response.data?.token != null) {
        // Login successful
        // Token is automatically saved by ApiService internally now.
        // You might want to save user details too, if your User model contains more info
        // and you need it globally (e.g., using Provider or Riverpod).

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful!')));

        // Navigate to your main application screen, e.g., HomeScreen
        // Make sure '/home_screen' is defined in your MaterialApp routes.
        // Replace with your desired home screen route.
        Navigator.pushReplacementNamed(context, '/home_screen');
      } else {
        // Login failed (e.g., wrong credentials, API error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response?.message ??
                  'Login failed. Please check your credentials.',
            ),
          ),
        );
      }
    } catch (e) {
      // Catch any unexpected errors (e.g., network issues)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
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
            // Added SingleChildScrollView to prevent overflow on small screens
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ), // Added white color
                ),
                height(12),
                Text(
                  "Login to access your account",
                  style: TextStyle(fontSize: 14, color: AppColor.gray88),
                ),
                height(24),
                buildTitle("Email Address"),
                height(12),
                buildTextField(
                  hintText: "Enter your email",
                  controller: emailController,
                  keyboardType:
                      TextInputType.emailAddress, // Set keyboard type for email
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
                      // TODO: Implement forgot password functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Forgot Password functionality not implemented yet.',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
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
                    onPressed: _isLoading
                        ? null
                        : _handleLogin, // Disable button when loading
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blueButton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          ) // Show loading indicator
                        : const Text(
                            "Login",
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
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Or Sign In With",
                      style: TextStyle(fontSize: 12, color: AppColor.gray88),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                height(16),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(
                          color: Colors.grey,
                        ), // Add a border for better visibility
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement Google Sign-In
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Google Sign-In not implemented yet.'),
                        ),
                      );
                      // Navigator.pushNamed(context, "/meet_2"); // This route seems unrelated to API login
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ensure 'assets/images/icon_google.png' exists in your pubspec.yaml
                        Image.asset(
                          "assets/images/icon_google.png",
                          height: 16,
                          width: 16,
                        ),
                        width(4),
                        const Text(
                          "Google",
                          style: TextStyle(
                            color: Colors.black,
                          ), // Set text color for visibility
                        ),
                      ],
                    ),
                  ),
                ),
                height(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 12, color: AppColor.gray88),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to RegisterScreenAPI
                        // Ensure RegisterScreenAPI.id is correctly defined and routed in your MaterialApp
                        // Example: Navigator.pushNamed(context, RegisterScreenAPI.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Navigate to Register Screen.'),
                          ),
                        );
                        // Uncomment the line below when you have RegisterScreenAPI setup as a route
                        // Navigator.pushNamed(context, RegisterScreenAPI.id);
                      },
                      child: Text(
                        "Sign Up",
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

// Placeholder for RegisterScreenAPI - define your actual register screen here
class RegisterScreenAPI extends StatelessWidget {
  static const String id = "/register_screen_api";
  const RegisterScreenAPI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: const Center(child: Text('This is the Register Screen')),
    );
  }
}

// Placeholder for HomeScreen - define your actual home screen here
class HomeScreen extends StatelessWidget {
  static const String id = "/home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: const Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}

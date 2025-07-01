import 'package:bengkel_app/constant/app_color.dart';
import 'package:bengkel_app/models/login_response.dart';
import 'package:bengkel_app/services/api_service.dart';
import 'package:bengkel_app/services/token_manager.dart';
import 'package:flutter/material.dart';

class LoginScreenApi extends StatefulWidget {
  const LoginScreenApi({super.key});
  static const String id = "/login_screen_api";

  @override
  State<LoginScreenApi> createState() => _LoginScreenApiState();
}

class _LoginScreenApiState extends State<LoginScreenApi> {
  // State variables untuk ui nya
  bool isVisibility = false; // untuk password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // untuk menampilkan loading

  //  API service and token manager
  final ApiService _apiService = ApiService();
  final TokenManager _tokenManager = TokenManager();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// untuk handle login dengan memanggil layannan API
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
      // jika validasi gagal , stop disini
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final LoginResponse? response = await _apiService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response != null && response.data?.token != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacementNamed(context, '/home_screen');
      } else {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(children: [buildBackground(), buildLayer()]),
      ),
    );
  }

  SafeArea buildLayer() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            // menggunakan singleChildScrollview agar menghindari overflow
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "MECHANIC ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.beige1,
                  ),
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
                      // untuk minimal password
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
                      backgroundColor: Colors.transparent,
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
                              color: Colors.black,
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
                      style: TextStyle(fontSize: 12, color: Colors.black),
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
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Google Sign-In not implemented yet.'),
                        ),
                      );
                      // Navigator.pushNamed(context, "/meet_2");
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
                          style: TextStyle(color: Colors.black),
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
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Navigate to Register Screen.'),
                          ),
                        );

                        Navigator.pushNamed(context, RegisterScreenAPI.id);
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

  /// ini untuk background login
  Container buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background8.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  SizedBox height(double height) => SizedBox(height: height);

  SizedBox width(double width) => SizedBox(width: width);

  Widget buildTitle(String text) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 12, color: AppColor.beige2)),
      ],
    );
  }

  /// menggunakan text fromfield.
  Widget buildTextField({
    String? hintText,
    bool isPassword = false,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator, // fungsi untuk validator
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType, // Set keyboard type
      validator: validator,
      obscureText: isPassword
          ? !isVisibility
          : false, // gunakan !isVisibility untuk obscureText
      style: const TextStyle(color: Colors.black), // Set text color to black
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.transparent,
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
        // untuk style error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // untuk Focused error border
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
                      : Icons.visibility_off, // icon logic
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

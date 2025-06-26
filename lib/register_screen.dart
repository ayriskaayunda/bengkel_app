import 'package:bengkel_app/constant/app_color.dart';
import 'package:bengkel_app/models/register_response.dart';
import 'package:bengkel_app/services/api_service.dart';
import 'package:flutter/material.dart';

class RegisterScreenApi extends StatefulWidget {
  const RegisterScreenApi({super.key});
  static const String id = "/register_screen_api";

  @override
  State<RegisterScreenApi> createState() => _RegisterScreenApiState();
}

class _RegisterScreenApiState extends State<RegisterScreenApi> {
  final ApiService _apiService = ApiService();

  // untuk variable ui dan menghandle
  bool isVisibility = false;
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// ini untuk menghandle proses registrasi dari APi servis
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true; // untuk menampilkan loading
    });

    try {
      final RegisterResponse? response = await _apiService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (response != null && response.data?.token != null) {
        // Registrasi berhasil
        //  token otomatis save dari API

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration successful! You can now login."),
            backgroundColor: Colors.green,
          ),
        );

        // Navigator untuk kembali ke login
        Navigator.pop(context);
      } else {
        // Registrasi gagal ( E,G , email sudah bisa , validasi error dari API)
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
        isLoading = false;
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

  /// menggunakan text fields dan tombol.
  SafeArea buildLayer() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            // menggunakan SingleChildScrollView agar menghindari overflow
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 94, 78, 73),
                  ),
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
                buildTitle("Name"),
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
                      // Minimal password
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
                            'Forgot Password functionality not applicable here.',
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
                    onPressed: isLoading
                        ? null
                        : _handleRegister, // non aktifkan tombol saat loading
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.beige2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          ) // tampilkan loading
                        : const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 235, 230, 229),
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
                        // Navigator untuk kembali ke halaman login
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

  /// untuk background
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
        Text(text, style: TextStyle(fontSize: 12, color: AppColor.gray88)),
      ],
    );
  }

  /// menggunakan text formfield
  Widget buildTextField({
    String? hintText,
    bool isPassword = false,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator, // Validator fungsi
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType, // ini keyboard type
      validator: validator, // Assign validator
      obscureText: isPassword ? !isVisibility : false,
      style: const TextStyle(color: Colors.black),
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
                  isVisibility ? Icons.visibility : Icons.visibility_off,
                  color: AppColor.gray88,
                ),
              )
            : null,
      ),
    );
  }
}

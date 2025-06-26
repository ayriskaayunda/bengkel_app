// lib/screens/create_servis_screen.dart
import 'package:bengkel_app/constant/app_color.dart';
import 'package:bengkel_app/models/servis_response.dart';
import 'package:bengkel_app/services/api_service.dart';
import 'package:flutter/material.dart';

class CreateServisScreen extends StatefulWidget {
  const CreateServisScreen({super.key});
  static const String id = "/create_servis_screen";

  @override
  State<CreateServisScreen> createState() => _CreateServisScreenState();
}

class _CreateServisScreenState extends State<CreateServisScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();

  Future<void> _handleCreateServis() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final CreateServisResponse? response = await _apiService.createServis(
        vehicleType: _vehicleTypeController.text,
        complaint: _complaintController.text,
      );

      if (response != null && response.data != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Service request created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // kembali ke halaman home
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response?.message ??
                  'Failed to create service request. Please try again.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _vehicleTypeController.dispose();
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Service'),
        centerTitle: true,
        backgroundColor: AppColor.beige8,
        foregroundColor: Colors.white,
      ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Service Request",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.beige1,
                  ),
                ),
                height(12),
                Text(
                  "Describe your vehicle issue for a service request",
                  style: TextStyle(fontSize: 14, color: AppColor.beige2),
                  textAlign: TextAlign.center,
                ),
                height(24),
                buildTitle("Vehicle Type"),
                height(12),
                buildTextField(
                  hintText: "e.g., Motor Bebek, Mobil MPV",
                  controller: _vehicleTypeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle type';
                    }
                    return null;
                  },
                ),
                height(16),
                buildTitle("Complaint"),
                height(12),
                buildTextField(
                  hintText: "e.g., Mesin berisik saat dinyalakan, dll",
                  controller: _complaintController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe your complaint';
                    }
                    return null;
                  },
                ),
                height(24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleCreateServis,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.beige8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Submit Request",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background6.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildTextField({
    String? hintText,
    bool isPassword = false,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: isPassword ? false : false,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.white38,
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
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
}

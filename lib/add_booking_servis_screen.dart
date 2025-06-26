// lib/screens/booking_servis_screen.dart
import 'package:bengkel_app/constant/app_color.dart';
import 'package:bengkel_app/models/booking_servis_response.dart';
import 'package:bengkel_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class BookingServisScreen extends StatefulWidget {
  const BookingServisScreen({super.key});
  static const String id = "/booking_servis_screen";

  @override
  State<BookingServisScreen> createState() => _BookingServisScreenState();
}

class _BookingServisScreenState extends State<BookingServisScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _handleBookingServis() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final BookingServisResponse? response = await _apiService.bookServis(
        bookingDate: _dateController.text,
        vehicleType: _vehicleTypeController.text,
        description: _descriptionController.text,
      );

      if (response != null && response.data != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Service booked successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back to the previous screen (Home)
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response?.message ?? 'Failed to book service. Please try again.',
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
    _dateController.dispose();
    _vehicleTypeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Service'),
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
                  "Add Service Booking",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 83, 73, 69),
                  ),
                ),
                height(12),
                Text(
                  "Fill in the details for your service appointment",
                  style: TextStyle(fontSize: 14, color: AppColor.beige1),
                  textAlign: TextAlign.center,
                ),
                height(24),
                buildTitle("Booking Date"),
                height(12),
                buildDateField(
                  controller: _dateController,
                  hintText: "Select Date",
                  onTap: () => _selectDate(context),
                ),
                height(16),
                buildTitle("Vehicle Type"),
                height(12),
                buildTextField(
                  hintText: "e.g., Motor Matic, Mobil Sedan",
                  controller: _vehicleTypeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle type';
                    }
                    return null;
                  },
                ),
                height(16),
                buildTitle("Description"),
                height(12),
                buildTextField(
                  hintText: "e.g., Ganti oli dan servis ringan",
                  controller: _descriptionController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                height(24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleBookingServis,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.beige8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Book Service",
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

  // untuk logic nya
  Widget buildTextField({
    String? hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: false,
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

  Widget buildDateField({
    required TextEditingController controller,
    String? hintText,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date';
        }
        return null;
      },
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
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
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

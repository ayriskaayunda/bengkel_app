import 'package:bengkel_app/add_booking_servis_screen.dart';
import 'package:bengkel_app/constant/app_color.dart';
import 'package:bengkel_app/login_screen.dart';
import 'package:bengkel_app/my_services_screen.dart';
import 'package:bengkel_app/request_servis_screen.dart';
import 'package:bengkel_app/services/api_service.dart';
import 'package:bengkel_app/servis_history_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen16 extends StatelessWidget {
  const HomeScreen16({super.key});
  static const String id = "/home_screen";

  Container buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background11.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.beige7,
        title: const Text('Home of Mechanic'),
        foregroundColor: AppColor.beige2,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              final bool? shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Logout'),
                    backgroundColor: const Color.fromARGB(255, 221, 210, 206),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            163,
                            140,
                            132,
                          ),
                        ),
                        child: const Text('Logout'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout == true) {
                await apiService.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil logout!')),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreenApi(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          buildBackground(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Ayundaars App!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColor.beige2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, BookingServisScreen.id);
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: const Text('Book a Service'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColor.beige7,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, CreateServisScreen.id);
                        },
                        icon: const Icon(Icons.build),
                        label: const Text('Request a Service'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColor.beige7,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, MyServicesScreen.id);
                        },
                        icon: const Icon(Icons.list_alt),
                        label: const Text('status Services'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColor.beige7,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, ServisHistoryScreen.id);
                        },
                        icon: const Icon(Icons.history),
                        label: const Text('Service History'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColor.beige7,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

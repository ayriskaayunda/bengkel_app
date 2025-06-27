import 'package:bengkel_app/add_booking_servis_screen.dart';
import 'package:bengkel_app/home_screen.dart';
import 'package:bengkel_app/login_screen.dart';
import 'package:bengkel_app/my_services_screen.dart';
import 'package:bengkel_app/register_screen.dart';
import 'package:bengkel_app/request_servis_screen.dart';
import 'package:bengkel_app/servis_history_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',

      routes: {
        '/': (context) => LoginScreenApi(),
        RegisterScreenApi.id: (context) => RegisterScreenApi(),
        HomeScreen16.id: (context) => HomeScreen16(),
        MyServicesScreen.id: (context) => MyServicesScreen(),
        ServisHistoryScreen.id: (context) => ServisHistoryScreen(),
        BookingServisScreen.id: (context) => BookingServisScreen(),
        CreateServisScreen.id: (context) => CreateServisScreen(),
      },

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

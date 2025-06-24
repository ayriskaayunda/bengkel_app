// lib/screens/servis_history_screen.dart
import 'package:flutter/material.dart';
import 'package:bengkel_app/constant/app_color.dart';
import 'package:bengkel_app/services/api_service.dart';
import 'package:bengkel_app/models/servis.dart'; // Import the Servis model
import 'package:bengkel_app/models/servis_history_response.dart'; // Import response model

/// Screen to display the user's completed service history.
class ServisHistoryScreen extends StatefulWidget {
  const ServisHistoryScreen({super.key});
  static const String id = "/servis_history_screen";

  @override
  State<ServisHistoryScreen> createState() => _ServisHistoryScreenState();
}

class _ServisHistoryScreenState extends State<ServisHistoryScreen> {
  final ApiService _apiService = ApiService();
  late Future<ServisHistoryResponse?> _historyFuture;

  @override
  void initState() {
    super.initState();
    _fetchServisHistory();
  }

  /// Fetches service history from the API.
  Future<void> _fetchServisHistory() async {
    setState(() {
      _historyFuture = _apiService.getServisHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service History'),
        backgroundColor: AppColor.blueButton,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchServisHistory,
            tooltip: 'Refresh History',
          ),
        ],
      ),
      body: FutureBuilder<ServisHistoryResponse?>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data?.data == null ||
              snapshot.data!.data!.isEmpty) {
            return const Center(child: Text('No service history found.'));
          } else {
            final List<Servis> history = snapshot.data!.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final servis = history[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Service ID: ${servis.id}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Vehicle Type: ${servis.vehicleType}'),
                        Text('Complaint: ${servis.complaint}'),
                        Text(
                          'Status: ${servis.status}',
                          style: TextStyle(
                            color: _getStatusColor(servis.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Created: ${servis.createdAt?.toLocal().toString().split(' ')[0]}',
                        ),
                        Text(
                          'Completed: ${servis.updatedAt?.toLocal().toString().split(' ')[0]}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Helper function to get status color (consistent with MyServicesScreen)
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Menunggu':
        return Colors.orange;
      case 'Diproses':
        return Colors.blue;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

import 'package:bengkel_app/constant/app_color.dart';
import 'package:bengkel_app/models/servis.dart';
import 'package:bengkel_app/models/servis_list_response.dart';
import 'package:bengkel_app/services/api_service.dart';
import 'package:flutter/material.dart';

class MyServicesScreen extends StatefulWidget {
  const MyServicesScreen({super.key});
  static const String id = "/my_services_screen";

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  final ApiService _apiService = ApiService();
  late Future<ServisListResponse?> _servicesFuture;

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    setState(() {
      _servicesFuture = _apiService.getAllServis();
    });
  }

  /// ini untuk delete
  Future<void> _deleteService(int servisId) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this service?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColor.beige6),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Deleting service...')));
      try {
        final response = await _apiService.deleteServis(servisId: servisId);
        if (response != null && response.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message!),
              backgroundColor: Colors.green,
            ),
          );
          _fetchServices(); // untuk refresh setelah delete
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to delete service.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting service: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // ini untuk menampilkan dialog untuk mmemperbarui layanan
  Future<void> _updateServiceStatus(int servisId, String currentStatus) async {
    String? selectedStatus = currentStatus; // Initialize with current status
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Service Status'),
          content: DropdownButtonFormField<String>(
            value: selectedStatus,
            onChanged: (String? newValue) {
              if (newValue != null) {
                selectedStatus = newValue;
              }
            },
            items:
                <String>[
                      'Menunggu',
                      'Diproses',
                      'Selesai',
                    ] // untuk status motor/mobil
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedStatus != null && selectedStatus != currentStatus) {
                  Navigator.of(context).pop(); // Close the dialog first
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Updating service status...')),
                  );
                  try {
                    final response = await _apiService.updateServisStatus(
                      servisId: servisId,
                      status: selectedStatus!,
                    );

                    if (!context.mounted) return; // ✅ Cek mounted dulu

                    if (response != null && response.message != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response.message!),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _fetchServices(); // Refresh
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to update status.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    if (!context.mounted)
                      return; // ✅ Cek lagi sebelum pakai context
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error updating status: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'No new status selected or status is the same.',
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service status'),
        centerTitle: true,
        backgroundColor: AppColor.beige4,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchServices,
            tooltip: 'Refresh Services',
          ),
        ],
      ),
      backgroundColor: AppColor.beige5,
      body: FutureBuilder<ServisListResponse?>(
        future: _servicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data?.data == null ||
              snapshot.data!.data!.isEmpty) {
            return const Center(
              child: Text('No current service requests found.'),
            );
          } else {
            final List<Servis> services = snapshot.data!.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final servis = services[index];
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
                          'Last Updated: ${servis.updatedAt?.toLocal().toString().split(' ')[0]}',
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => _updateServiceStatus(
                                servis.id!,
                                servis.status!,
                              ),
                              child: const Text('Update Status'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _deleteService(servis.id!),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
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

  // ini fungsi untuk mendapatkan warna status
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

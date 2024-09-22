import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/screens/designer/views/appointment_screen.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  List<dynamic> appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  
Future<void> fetchAppointments() async {
  const String apiUrl = 'http://10.0.2.2:8080/api/v1/appointments/user/3?page=1&limit=10';

  // Retrieve the access token from Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('accessToken');

  // Check if the token is not null
  if (token == null) {
    print('No access token found');
    return; // Handle the case where no token is available (e.g., show a login screen)
  }

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        appointments = data['data']['content'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  } catch (error) {
    setState(() {
      isLoading = false;
    });
    print('Error fetching appointments: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Appointment List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        'Appointment ID: ${appointment['id']}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Start: ${appointment['datetimeStart']}\n'
                        'End: ${appointment['datetimeEnd']}\n'
                        'Status: ${appointment['status']}',
                      ),
                      onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentScreen(
                                designerId: appointment['designerId'],
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

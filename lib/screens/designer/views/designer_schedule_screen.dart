import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/designer/views/designer_appointment_detail.dart';
import 'package:shop/services/appointment_service.dart';

class DesignerScheduleScreen extends StatefulWidget {
  const DesignerScheduleScreen({super.key});

  @override
  _DesignerScheduleScreenState createState() => _DesignerScheduleScreenState();
}

class _DesignerScheduleScreenState extends State<DesignerScheduleScreen> {
  final AppointmentService _appointmentService = AppointmentService();
  List<Map<String, dynamic>> availableTimes = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchAvailableTimes();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      _fetchAvailableTimes();
    }
  }

  Future<void> _fetchAvailableTimes() async {
    try {
      final List<Map<String, dynamic>> slots = await _appointmentService.getAvailableSlots(selectedDate);
      setState(() {
        availableTimes = slots;
      });
    } catch (e) {
      print('Error fetching available times: $e'); // In ra lỗi trong console
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch available times: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Designer Schedule'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Day: $formattedDate',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.blueAccent),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  final slot = availableTimes[index];
                  final String start = DateFormat('HH:mm').format(DateTime.parse(slot['datetimeStart']));
                  final String end = DateFormat('HH:mm').format(DateTime.parse(slot['datetimeEnd']));
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDetail(
                            appointmentId: slot['id'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Start: $start, End: $end',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, createScheduleScreenRoute);
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/models/bookings_model.dart';

class EditBookingPage extends StatefulWidget {
  final Booking booking;

  const EditBookingPage({super.key, required this.booking});

  @override
  _EditBookingPageState createState() => _EditBookingPageState();
}

class _EditBookingPageState extends State<EditBookingPage> {
  late TextEditingController _busIdController;
  late TextEditingController _dateController;
  late TextEditingController _departureTimeController;
  late TextEditingController _routeController;
  late TextEditingController _seatController;
  late TextEditingController _tripIdController;
  late TextEditingController _userIdController;

  @override
  void initState() {
    super.initState();
    _busIdController = TextEditingController(text: widget.booking.busId);
    _dateController = TextEditingController(text: widget.booking.date.toIso8601String().split('T').first);
    _departureTimeController = TextEditingController(text: widget.booking.departureTime);
    _routeController = TextEditingController(text: widget.booking.route);
    _seatController = TextEditingController(text: widget.booking.seat);
    _tripIdController = TextEditingController(text: widget.booking.tripId);
    _userIdController = TextEditingController(text: widget.booking.userId);
  }

  @override
  void dispose() {
    _busIdController.dispose();
    _dateController.dispose();
    _departureTimeController.dispose();
    _routeController.dispose();
    _seatController.dispose();
    _tripIdController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  void _saveBooking() {
    // Save booking logic here, e.g., update Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _busIdController,
              decoration: const InputDecoration(labelText: 'Bus ID'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _departureTimeController,
              decoration: const InputDecoration(labelText: 'Departure Time'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _routeController,
              decoration: const InputDecoration(labelText: 'Route'),
            ),
            TextField(
              controller: _seatController,
              decoration: const InputDecoration(labelText: 'Seat'),
            ),
            TextField(
              controller: _tripIdController,
              decoration: const InputDecoration(labelText: 'Trip ID'),
            ),
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveBooking,
              child: const Text('Save Booking'),
            ),
          ],
        ),
      ),
    );
  }
}

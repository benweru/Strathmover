import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/models/trip_model.dart';

class EditTripPage extends StatefulWidget {
  final TripModel trip;

  const EditTripPage({required this.trip, Key? key}) : super(key: key);

  @override
  _EditTripPageState createState() => _EditTripPageState();
}

class _EditTripPageState extends State<EditTripPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dateController;
  late TextEditingController _departureTimeController;
  late TextEditingController _busIdController;
  late TextEditingController _routeController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.trip.date);
    _departureTimeController = TextEditingController(text: widget.trip.departureTime);
    _busIdController = TextEditingController(text: widget.trip.busId);
    _routeController = TextEditingController(text: widget.trip.route);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _departureTimeController.dispose();
    _busIdController.dispose();
    _routeController.dispose();
    super.dispose();
  }

  void _saveTrip() async {
    if (_formKey.currentState!.validate()) {
      final trip = widget.trip.copyWith(
        date: _dateController.text,
        departureTime: _departureTimeController.text,
        busId: _busIdController.text,
        route: _routeController.text,
      );

      await FirebaseFirestore.instance.collection('trips').doc(trip.id).update(trip.toJson());

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) => value!.isEmpty ? 'Please enter a date' : null,
              ),
              TextFormField(
                controller: _departureTimeController,
                decoration: const InputDecoration(labelText: 'Departure Time'),
                validator: (value) => value!.isEmpty ? 'Please enter a departure time' : null,
              ),
              TextFormField(
                controller: _busIdController,
                decoration: const InputDecoration(labelText: 'Bus ID'),
                validator: (value) => value!.isEmpty ? 'Please enter a bus ID' : null,
              ),
              TextFormField(
                controller: _routeController,
                decoration: const InputDecoration(labelText: 'Route'),
                validator: (value) => value!.isEmpty ? 'Please enter a route' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveTrip,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

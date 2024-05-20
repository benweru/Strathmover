import 'package:flutter/material.dart';

class JourneyDetailsScreen extends StatelessWidget {
  final List<String> selectedSeats;
  final String startingPoint;
  final String destination;

  const JourneyDetailsScreen({super.key, 
    required this.selectedSeats,
    required this.startingPoint,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(247, 41, 55, 83),
        title: const Text('Journey Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400.0), 
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text(
                    'Ticket Details',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    title: const Text(
                      'Selected Seats:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      children: selectedSeats.map((seat) {
                        return Text(seat);
                      }).toList(),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Starting Point:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(startingPoint),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Destination:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(destination),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

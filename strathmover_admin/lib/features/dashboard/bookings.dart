import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_admin_dashboard_template/models/bookings_model.dart';
import 'package:go_router/go_router.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  Future<List<Booking>> fetchBookings() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('bookings').get();
    return snapshot.docs.map((doc) => Booking.fromSnapshot(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: FutureBuilder<List<Booking>>(
        future: fetchBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookings available'));
          }

          final bookings = snapshot.data!;
          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return ListTile(
                title: Text(booking.route),
                subtitle: Text('${booking.date} - ${booking.departureTime}'),
                onTap: () {
                  context.go('/bookings/${booking.busId}', extra: booking);
                },
              );
            },
          );
        },
      ),
    );
  }
}

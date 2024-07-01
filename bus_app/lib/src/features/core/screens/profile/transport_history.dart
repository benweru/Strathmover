import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/core/controllers/transport_history_controller.dart';

class TransportHistoryScreen extends StatelessWidget {
  const TransportHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TransportHistoryController controller =
        Get.put(TransportHistoryController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Transport History',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.bookings.isEmpty) {
          return Center(child: Text('No bookings found.'));
        }

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final booking = controller.bookings[index];
            return ListTile(
              title: Text('Date: ${booking.date}'),
              subtitle: Text(
                  'Route: ${booking.route}, Departure Time: ${booking.departureTime}'),
            );
          },
        );
      }),
    );
  }
}

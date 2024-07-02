import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/core/controllers/transport_history_controller.dart';
// import 'package:intl/intl.dart'; // Add this for date formatting

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
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Filter by Time') {
                _selectDepartureTime(context, controller);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Filter by Date', 'Filter by Time'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
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

  // void _selectDateRange(BuildContext context, TransportHistoryController controller) async {
  //   final DateTimeRange? picked = await showDateRangePicker(
  //     context: context,
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2025),
  //   );
  //   if (picked != null && picked.start != null && picked.end != null) {
  //     controller.filterByDateRange(picked.start, picked.end);
  //   }
  // }

  void _selectDepartureTime(
      BuildContext context, TransportHistoryController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Departure Time'),
          content: SingleChildScrollView(
            child: ListBody(
              children: ['08:00 AM', '12:00 PM', '06:00 PM'].map((time) {
                return GestureDetector(
                  onTap: () {
                    controller.filterByDepartureTime(time);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(time),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

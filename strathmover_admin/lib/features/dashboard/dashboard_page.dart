import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/bookings_chart.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:gap/gap.dart';
import 'package:intersperse/intersperse.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../widgets/widgets.dart';
import '../../models/bookings_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedView = 'Week';

  Future<Map<String, int>> fetchCounts() async {
    final usersSnapshot = await FirebaseFirestore.instance.collection('Users').get();
    final busesSnapshot = await FirebaseFirestore.instance.collection('buses').get();
    final routesSnapshot = await FirebaseFirestore.instance.collection('routes').get();

    return {
      'totalUsers': usersSnapshot.size,
      'totalBuses': busesSnapshot.size,
      'totalRoutes': routesSnapshot.size,
    };
  }

  Future<List<Booking>> fetchBookings() async {
    final snapshot = await FirebaseFirestore.instance.collection('bookings').get();
    final bookings = snapshot.docs.map((doc) => Booking.fromSnapshot(doc)).toList();
    return bookings;
  }

  Map<int, int> processBookingsData(List<Booking> bookings, String view) {
    final Map<int, int> counts = {};
    for (var booking in bookings) {
      int key;
      if (view == 'Week') {
        key = getWeekOfYear(booking.date);
      } else if (view == 'Month') {
        key = booking.date.month;
      } else { // Year
        key = booking.date.year;
      }

      if (counts.containsKey(key)) {
        counts[key] = counts[key]! + 1;
      } else {
        counts[key] = 1;
      }
    }
    return counts;
  }

  int getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return (daysSinceFirstDay / 7).floor() + 1;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return ContentView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Dashboard',
            description: 'A summary of key data.',
          ),
          const Gap(16),
          FutureBuilder<Map<String, int>>(
            future: fetchCounts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available'));
              }

              final counts = snapshot.data!;
              final summaryCards = [
                SummaryCard(title: 'Total Users', value: counts['totalUsers'].toString()),
                SummaryCard(title: 'Total Buses', value: counts['totalBuses'].toString()),
                SummaryCard(title: 'Total Routes', value: counts['totalRoutes'].toString()),
              ];

              if (responsive.isMobile) {
                return Column(
                  children: summaryCards,
                );
              } else {
                return Row(
                  children: summaryCards
                      .map<Widget>((card) => Expanded(child: card))
                      .intersperse(const Gap(16))
                      .toList(),
                );
              }
            },
          ),
          const Gap(16),
          DropdownButton<String>(
            value: _selectedView,
            items: ['Week', 'Month', 'Year']
                .map((view) => DropdownMenuItem<String>(
                      value: view,
                      child: Text(view),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedView = value!;
              });
            },
          ),
          FutureBuilder<List<Booking>>(
            future: fetchBookings(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No bookings data available'));
              }
              final bookings = snapshot.data!;
              final counts = processBookingsData(bookings, _selectedView);

              return BookingsChart(data: counts, view: _selectedView);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({super.key});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  final bookings = <BookingModel>[].obs;
  final isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    fetchBookingsForToday();
  }

  Future<void> fetchBookingsForToday() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final date = DateTime.now();
      final today = '${date.year}-${date.month}-${date.day}';

      QuerySnapshot userBookingSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: user.uid)
          .where('date', isEqualTo: today)
          .orderBy('departureTime')
          .get();

      final fetchedBookings = userBookingSnapshot.docs.map((doc) {
        return BookingModel.fromSnapshot(
          doc as DocumentSnapshot<Map<String, dynamic>>,
        );
      }).toList();

      bookings.value = fetchedBookings;
    } catch (e) {
      print("Error fetching bookings: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void cancelBooking(BookingModel booking) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(booking.id)
          .delete();
      bookings.remove(booking);
    } catch (e) {
      print("Error canceling booking: $e");
    }
  }

  void showCancelDialog(BuildContext context, BookingModel booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Cancellation'),
          content: const Text('Are you sure you want to cancel this booking?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                cancelBooking(booking);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(tDefaultSize * 0.7),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'My Bookings',
                        style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (bookings.isEmpty) {
                  return Text(
                    'No bookings for today',
                    style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                  );
                } else {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        return ScheduleCard(
                          date: booking.date,
                          departureTime: booking.departureTime,
                          route: booking.route,
                          onCancel: () => showCancelDialog(context, booking),
                        );
                      },
                    ),
                  );
                }
              }),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tSecondaryColor,
                  ),
                  child: Text(
                    'Cancel',
                    style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                  ),
                  onPressed: () {
                    if (bookings.isNotEmpty) {
                      showCancelDialog(context, bookings.first);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String date;
  final String departureTime;
  final String route;
  final VoidCallback onCancel;

  const ScheduleCard({
    Key? key,
    required this.date,
    required this.departureTime,
    required this.route,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(tDefaultSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: tWhiteColor,
                size: 15,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  date,
                  style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.access_alarm,
                color: tWhiteColor,
                size: 17,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  departureTime,
                  style: textTheme.bodySmall?.copyWith(color: tWhiteColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                child: Text(
                  route,
                  style: textTheme.bodySmall?.copyWith(color: tWhiteColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 20),
              
            ],
          ),
        ],
      ),
    );
  }
}

class BookingModel {
  final String? id;
  final String userId;
  final String tripId;
  final String date;
  final String departureTime;
  final String busId;
  final String route;

  BookingModel({
    this.id,
    required this.userId,
    required this.tripId,
    required this.date,
    required this.departureTime,
    required this.busId,
    required this.route,
  });

  factory BookingModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BookingModel(
      id: document.id,
      userId: data['userId'] ?? '',
      tripId: data['tripId'] ?? '',
      date: data['date'] ?? '',
      departureTime: data['departureTime'] ?? '',
      busId: data['busId'] ?? '',
      route: data['route'] ?? '',
    );
  }
}

import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/core/controllers/booking_controller.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({super.key});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  final BookingController bookingController = Get.put(BookingController());

  @override
  void initState() {
    super.initState();
    bookingController.fetchUserBooking();
  }

  @override
  void dispose() {
    bookingController.dispose();
    super.dispose();
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
                        style:
                            textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() {
                final userBooking = bookingController.userBooking.value;
                if (userBooking == null) {
                  return Text(
                    'No bookings for today',
                    style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                  );
                } else {
                  return ScheduleCard(
                    date: userBooking.date,
                    departureTime: userBooking.departureTime,
                    route: userBooking.route,
                  );
                }
              }),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tSecondaryColor,
                      ),
                      child: Text(
                        'Cancel',
                        style:
                            textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                      ),
                      onPressed: () {
                        // Add your cancel booking logic here
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tSecondaryColor,
                      ),
                      child: Text(
                        'Completed',
                        style:
                            textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                      ),
                      onPressed: () {
                        // Add your complete booking logic here
                      },
                    ),
                  ),
                ],
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

  const ScheduleCard({
    Key? key,
    required this.date,
    required this.departureTime,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(tDefaultSize),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: tWhiteColor,
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            date,
            style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
          ),
          const SizedBox(width: 20),
          const Icon(
            Icons.access_alarm,
            color: tWhiteColor,
            size: 17,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              departureTime,
              style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              route,
              style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}

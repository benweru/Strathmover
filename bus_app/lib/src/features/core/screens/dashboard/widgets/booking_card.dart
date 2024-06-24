import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({super.key});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
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
              const ScheduleCard(),
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
                        style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                      ),
                      onPressed: () {},
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
                        style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
                      ),
                      onPressed: () {},
                    ),
                  )
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
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
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
            'Day, dd/mm/yyyy',
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
              '25:00',
              style: textTheme.bodyMedium?.copyWith(color: tWhiteColor),
            ),
          )
        ],
      ),
    );
  }
}

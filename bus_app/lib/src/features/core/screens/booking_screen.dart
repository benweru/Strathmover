import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/core/controllers/booking_controller.dart';
import 'package:bus_app/src/features/core/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_app/src/features/authentication/models/trip_model.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());

    return Scaffold(
      appBar: TAppBar(
        title: Text(tBooking, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Obx(() => Column(
                children: [
                  const SizedBox(height: 10),
                  Text(tBookingHeading,
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text(tBookingSubHeading,
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  Stepper(
                    currentStep: controller.currentStep.value,
                    onStepTapped: (step) => controller.goToStep(step),
                    onStepContinue: controller.currentStep.value == 1 &&
                            controller.selectedTrip.value != null
                        ? controller.bookSeat
                        : controller.nextStep,
                    onStepCancel: controller.previousStep,
                    steps: [
                      Step(
                        title: const Text('Choose trip'),
                        content: Obx(() {
                          if (controller.trips.isEmpty) {
                            return const Text('No trips available for today');
                          }
                          return Column(
                            children: controller.trips.map((trip) {
                              return ListTile(
                                title: Text('Trip at ${trip.departureTime}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Route: ${trip.route}'),
                                    Text('Bus ID: ${trip.busId}'),
                                  ],
                                ),
                                onTap: () {
                                  controller.selectTrip(trip);
                                  controller.nextStep();
                                },
                              );
                            }).toList(),
                          );
                        }),
                        isActive: controller.currentStep.value >= 0,
                      ),
                      Step(
                        title: const Text('Choose Seat'),
                        content: Obx(() {
                          if (controller.availableSeats.isEmpty) {
                            return const Text(
                                'No available seats for the selected trip');
                          }
                          return Container(
                            height:
                                300, // Set a fixed height to make it scrollable
                            child: ListView(
                              children: controller.availableSeats.map((seat) {
                                return ListTile(
                                  title: Text('Seat $seat'),
                                  onTap: () {
                                    controller.selectSeat(seat);
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        }),
                        isActive: controller.currentStep.value >= 1,
                      ),
                      Step(
                        title: const Text('Confirm your selections'),
                        content: Obx(() {
                          if (controller.selectedTrip.value == null ||
                              controller.selectedSeat.isEmpty) {
                            return const Text('No selections made');
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Selected Trip: ${controller.selectedTrip.value!.departureTime}'),
                              Text(
                                  'Route: ${controller.selectedTrip.value!.route}'),
                              Text(
                                  'Bus ID: ${controller.selectedTrip.value!.busId}'),
                              Text(
                                  'Selected Seat: ${controller.selectedSeat.value}'),
                            ],
                          );
                        }),
                        isActive: controller.currentStep.value >= 2,
                      ),
                      Step(
                        title: const Text('Step 4'),
                        content: const Text('Content for Step 4'),
                        isActive: controller.currentStep.value >= 3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (controller.currentStep.value > 0)
                        ElevatedButton(
                          onPressed: controller.previousStep,
                          child: const Text('Previous'),
                        ),
                      if (controller.currentStep.value < 4)
                        ElevatedButton(
                          onPressed: controller.nextStep,
                          child: const Text('Next'),
                        ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

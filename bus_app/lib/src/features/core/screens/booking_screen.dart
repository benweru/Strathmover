import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/constants/text_strings.dart';
import 'package:bus_app/src/features/core/controllers/booking_controller.dart';
import 'package:bus_app/src/features/core/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();

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
                    onStepContinue: () {
                      if (controller.currentStep.value == 2) {
                        controller.confirmBooking();
                      } else {
                        controller.nextStep();
                      }
                    },
                    onStepCancel: controller.previousStep,
                    controlsBuilder: (context, details) {
                      final isLastStep = controller.currentStep.value == 2;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (controller.currentStep.value > 0)
                            ElevatedButton(
                              onPressed: details.onStepCancel,
                              child: const Text('Previous'),
                            ),
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: Text(isLastStep ? 'Confirm' : 'Next'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  isLastStep ? Colors.green : Colors.blue),
                            ),
                          ),
                        ],
                      );
                    },
                    steps: [
                      Step(
                        title: const Text('Choose trip'),
                        content: Obx(() {
                          if (controller.trips.isEmpty) {
                            return const Text('No available trips for today.');
                          }
                          return Column(
                            children: controller.trips.map((trip) {
                              bool isSelected =
                                  controller.selectedTrip.value?.tripId ==
                                      trip.tripId;
                              return Card(
                                color: isSelected
                                    ? Color.fromARGB(255, 159, 250, 253)
                                    : Colors.white,
                                shape: isSelected
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.purple, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      )
                                    : null,
                                child: ListTile(
                                  title: Text(
                                      'Trip at ${trip.departureTime} - Route: ${trip.route}'),
                                  subtitle: Text('Bus ID: ${trip.busId}'),
                                  selected: isSelected,
                                  onTap: () => controller.selectTrip(trip),
                                ),
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
                            return const Text('No available seats.');
                          }
                          return SizedBox(
                            height: 300, // Adjust height as needed
                            child: SingleChildScrollView(
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: controller.availableSeats.map((seat) {
                                  return ChoiceChip(
                                    label: Text(seat),
                                    selected:
                                        controller.selectedSeat.value == seat,
                                    onSelected: (selected) {
                                      controller.selectSeat(seat);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        }),
                        isActive: controller.currentStep.value >= 1,
                      ),
                      Step(
                        title: const Text('Confirm your selections'),
                        content: Obx(() {
                          final trip = controller.selectedTrip.value;
                          final seat = controller.selectedSeat.value;
                          if (trip == null || seat.isEmpty) {
                            return const Text('No trip or seat selected.');
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Trip: ${trip.departureTime} - ${trip.route}'),
                              Text('Bus ID: ${trip.busId}'),
                              Text('Seat: $seat'),
                            ],
                          );
                        }),
                        isActive: controller.currentStep.value >= 2,
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

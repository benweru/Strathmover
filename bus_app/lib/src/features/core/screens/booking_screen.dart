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
                    onStepContinue: controller.nextStep,
                    onStepCancel: controller.previousStep,
                    steps: [
                      Step(
                        title: const Text('Choose trip'),
                        content: Obx(() {
                          if (controller.trips.isEmpty) {
                            return const Text('No trips available for today.');
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.trips.length,
                            itemBuilder: (context, index) {
                              final trip = controller.trips[index];
                              return ListTile(
                                title: Text('Trip at ${trip.departureTime}'),
                                subtitle: Text('Bus ID: ${trip.busId}'),
                                onTap: () {
                                  // Handle trip selection
                                },
                              );
                            },
                          );
                        }),
                        isActive: controller.currentStep.value >= 0,
                      ),
                      Step(
                        title: const Text('Choose Seat'),
                        content:
                            const Text('Select from these available seats'),
                        isActive: controller.currentStep.value >= 1,
                      ),
                      Step(
                        title: const Text('Confirm your selections'),
                        content: const Text(
                            'Ensure the selections made are correct'),
                        isActive: controller.currentStep.value >= 2,
                      ),
                      Step(
                        title: const Text('Step 4'),
                        content: const Text('Content for Step 4'),
                        isActive: controller.currentStep.value >= 3,
                      ),
                      Step(
                        title: const Text('Step 5'),
                        content: const Text('Content for Step 5'),
                        isActive: controller.currentStep.value >= 4,
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

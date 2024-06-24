import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/images_strings.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/core/screens/dashboard/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RouteDetails extends StatefulWidget {
  const RouteDetails({super.key});

  @override
  State<RouteDetails> createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppbar(
        appTitle: 'Route Details',
        icon: FaIcon(Icons.arrow_back_rounded, color: colorScheme.onPrimary),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: FaIcon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: tAccentColor,
            ),
          ),
        ],
        onBackPressed: () {
          Get.back();
        },
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: <Widget>[
              AboutRoute(),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutRoute extends StatelessWidget {
  const AboutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage(tProfileImage),
            backgroundColor: tWhiteColor,
          ),
          const SizedBox(height: spaceBtwItems),
          Text(
            'Route1',
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: spaceBtwItems),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              'Stop1 - Stop2 - Stop3...',
              style: textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: spaceBtwItems),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              'Stop1 - Stop2 - Stop3...',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(tDashboardPadding),
      margin: const EdgeInsets.only(bottom: tDashboardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: spaceBtwItems),
          Text(
            'Details',
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: spaceBtwItems),
          const RouteDetails(),
        ],
      ),
    );
  }
}

class TripInfo extends StatelessWidget {
  const TripInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        InfoCard(
          label: 'Placeholder',
          value: 'Placeholder',
        ),
        SizedBox(width: spaceBtwItems),
        InfoCard(
          label: 'Placeholder',
          value: 'Placeholder',
        ),
        SizedBox(width: spaceBtwItems),
        InfoCard(
          label: 'Placeholder',
          value: 'Placeholder',
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusMd),
          color: tPrimaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: buttonHeight,
          horizontal: tDashboardPadding,
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: spaceBtwItems),
            Text(
              value,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

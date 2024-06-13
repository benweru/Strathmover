import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/core/utils/circular_container.dart';
import 'package:bus_app/src/features/core/utils/curved_edges.dart';
import 'package:bus_app/src/features/core/utils/curved_edges_widget.dart';
import 'package:bus_app/src/features/core/utils/primary_header_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
              tPrimaryHeaderContainer(
                child: Container(),
              ),
            ],
          ),
        ),
    );
  }
}





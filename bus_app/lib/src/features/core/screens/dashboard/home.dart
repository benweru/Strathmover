
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

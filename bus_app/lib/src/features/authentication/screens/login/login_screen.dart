import 'package:bus_app/src/constants/sizes.dart';
import 'package:bus_app/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:bus_app/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:bus_app/src/features/authentication/screens/login/login_header_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {


    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeaderWidget(),
                LoginForm(),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}

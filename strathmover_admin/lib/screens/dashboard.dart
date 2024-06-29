import 'package:flutter/material.dart';
import 'package:strathmover_admin/widgets/header.dart';
import 'package:strathmover_admin/widgets/sidebar.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Dashboard',
      ),
      drawer: Sidebar(),
      body: Center(
        child: Text('Welcome to Admin Dashboard'),
      ),
    );
  }
}

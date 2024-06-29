import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Admin Dashboard'),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            title: Text('Users'),
            onTap: () {
              Navigator.pushNamed(context, '/users');
            },
          ),
          ListTile(
            title: Text('Trips'),
            onTap: () {
              Navigator.pushNamed(context, '/trips');
            },
          ),
          ListTile(
            title: Text('Routes'),
            onTap: () {
              Navigator.pushNamed(context, '/routes');
            },
          ),
        ],
      ),
    );
  }
}

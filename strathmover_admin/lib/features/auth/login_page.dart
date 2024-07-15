import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'admin@strathmover.app');
  final _passwordController = TextEditingController(text: 'admin');
  final _auth = FirebaseAuth.instance;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _error = null; // Reset error before login attempt
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final userDoc = await FirebaseFirestore.instance
          .collection('admin')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        await _auth.signOut();
        setState(() {
          _error = 'You do not have admin access.';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'invalid-email':
            _error = 'The email address is badly formatted.';
            break;
          case 'user-disabled':
            _error = 'The user has been disabled.';
            break;
          case 'user-not-found':
            _error = 'No user found for that email.';
            break;
          case 'wrong-password':
            _error = 'Wrong password provided.';
            break;
          default:
            _error = 'An undefined Error happened: ${e.message}';
        }
      });
      print('FirebaseAuthException: ${e.code} - ${e.message}'); // Debugging statement
    } catch (e) {
      setState(() {
        _error = 'An unknown error occurred: ${e.toString()}';
      });
      print('Exception: ${e.toString()}'); // Debugging statement
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _error!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

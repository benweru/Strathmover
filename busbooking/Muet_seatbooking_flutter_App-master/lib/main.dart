import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_seat_booking_app/firebase_options.dart';
import 'package:online_seat_booking_app/login-page.dart';
import 'package:online_seat_booking_app/signup_page.dart';



//Entry point of flutter app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform.then(
    (FirebaseApp value) => Get.put(AuthenticationRepository())
  ),
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seat Booking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(
            255, 12, 127, 123), 
      ),
      home: const ImageScreen(title: 'MUET seat booking App',),
    //  home: MainScreen(),
    );
  }
}

class ImageScreen extends StatefulWidget {
const ImageScreen({super.key, required this.title});
  final String title;
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();
    
    
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BackgroundScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor:  const Color(0xFF44474C),
      ),

    body: Center(
  child: Container(
    color: const Color(0xFF44474C),
    constraints: const BoxConstraints.expand(),
    child: Transform.scale(
      scale: 2.0,
      child: Image.asset(
        'assets/images/logo1.png',
        fit: BoxFit.contain,
      ),
    ),
  ),
)

    );
  }
}

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MUET seat booking App'),
        backgroundColor: const Color.fromARGB(
            247, 41, 55, 83), 
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: const DecorationImage(
            image: AssetImage(
                'assets/images/bg.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment
            .bottomCenter, 
        child: FloatingActionButton(
          onPressed: () {
           
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const SignUpLoginScreen(), 
              ),
            );
          },
          backgroundColor: const Color.fromARGB(247, 216, 90,
              45), 
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class SignUpLoginScreen extends StatelessWidget {
  const SignUpLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up & Login'),
         backgroundColor: const Color.fromARGB(
            247, 41, 55, 83),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Signup(),
                  ),
                );
                
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(
                          247, 41, 55, 83), 
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18, 
                ),
              ),
            ),
            const SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
                
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(
                          247, 41, 55, 83), 
                padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


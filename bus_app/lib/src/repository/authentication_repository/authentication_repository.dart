import 'package:bus_app/src/constants/t_exceptions.dart';
import 'package:bus_app/src/features/authentication/screens/login/login_screen.dart';
import 'package:bus_app/src/features/authentication/screens/mail_verification/mail_verification.dart';
import 'package:bus_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:bus_app/src/repository/authentication_repository/exceptions/login_email_password_failure.dart';
import 'package:bus_app/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../features/core/screens/dashboard/dashboard.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  /// Getters
  //String get getUserID => firebaseUser.uid ?? "";
  //String get getUserEmail => firebaseUser.email ?? "";

  // Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    super.onReady(); // Ensure you call super.onReady()
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    //FlutterNativeSplash.remove();
    ever(firebaseUser, setInitialScreen);
    setInitialScreen(firebaseUser.value);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : user.emailVerified
            ? Get.offAll(() => const Dashboard())
            : Get.offAll(() => const MailVerification());
  }

  // FUNC - Register
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const Dashboard())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message} ');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print(' EXCEPTION - ${ex.message}');
      throw ex;
    }
    return null;
  }

// FUNC - Login
  Future<void> loginWithEmailAndPassword(String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    final ex = LogInWithEmailAndPasswordFailure.fromCode(e.code);
    print('FIREBASE AUTH EXCEPTION - ${ex.message}');
    throw ex;
  } catch (_) {
    const ex = LogInWithEmailAndPasswordFailure();
    print('EXCEPTION - ${ex.message}');
    throw ex;
  }
  
}

  // FUNC - Email Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }



  // FUNC - Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on FormatException catch (e) {
      throw e.message;
    } catch (e) {
      throw "Unable to logout. Try again.";
    }
  }

  // FUNC
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again.');
        }
      },
    );
  }

  //OTP
  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  


  //[GoogleAuthentication]
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      throw TExceptions.fromCode(e.code).message;
    } catch (e) {
      // Handle generic exception
      throw 'An error occurred: $e';
    }
  }
}

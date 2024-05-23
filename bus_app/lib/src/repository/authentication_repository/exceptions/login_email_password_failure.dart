class LogInWithEmailAndPasswordFailure {
  final String message;
  const LogInWithEmailAndPasswordFailure([this.message = "An unknown error occurred."]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure('No user found for that email.');
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure('Wrong password provided.');
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure('This user has been disabled. Please contact support for help.');
      case 'operation-not-allowed':
        return const LogInWithEmailAndPasswordFailure('Operation not allowed. Please contact support.');
      case 'too-many-requests':
        return const LogInWithEmailAndPasswordFailure('Too many requests. Try again later.');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

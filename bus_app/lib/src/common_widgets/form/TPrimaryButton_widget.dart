import 'package:flutter/material.dart';

class TPrimaryButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onPressed;

  const TPrimaryButton({
    required this.isLoading,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(text),
    );
  }
}

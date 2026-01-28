import 'package:flutter/material.dart';

// Removed the underscore so it can be imported in LoginPage
class CustomLoadingDialog extends StatelessWidget {
  const CustomLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                // Color matches your "Log in" purple theme
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9181F4)),
                backgroundColor: Color(0xFFE0E0E0),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Log in",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
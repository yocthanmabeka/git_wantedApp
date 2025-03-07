import 'package:flutter/material.dart';

/// **LogoutScreen**
/// This screen informs the user that they have been logged out and provides
/// an option to navigate back to the sign-in screen.
class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  /// Navigates the user to the SignInScreen.
  /// Uses `Navigator.pushReplacementNamed` to replace the current screen
  /// and prevent users from navigating back to the logout screen.
  void _goToSignInScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Logout Icon
              const Icon(
                Icons.logout,
                size: 100,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 16),

              // ✅ Logout Confirmation Message
              const Text(
                'You are logged out.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // ✅ Thank You Message
              const Text(
                'Thank you for using Wanted.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),

              // ✅ Reconnect Button
              ElevatedButton(
                onPressed: () => _goToSignInScreen(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Reconnect'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

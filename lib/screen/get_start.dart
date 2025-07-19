import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/pages/homepage.dart'; // Make sure this path is correct

class GetStartScreen extends ConsumerWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF9),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // 🖼️ Illustration Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                'assets/images/getstart.jpg',
                height: 400,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 50),

            // 📢 Title
            const Text(
              'Spend Smarter\nSave More',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF217472),
                fontFamily: 'Inter',
              ),
            ),

            const SizedBox(height: 40),

            // ✅ Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF209E9F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔐 Log In Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already Have Account? ',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Replace with real login screen navigation
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Navigate to login")),
                    );
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF209E9F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

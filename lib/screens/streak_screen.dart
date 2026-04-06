import 'package:flutter/material.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streaks'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.whatshot, size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            const Text(
              'Your Current Streak',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '5 Days',
              style: TextStyle(fontSize: 32, color: Colors.orange),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle streak details
              },
              child: const Text('View Streak Details'),
            ),
          ],
        ),
      ),
    );
  }
}

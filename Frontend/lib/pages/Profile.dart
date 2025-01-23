import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the currently logged-in user
    User? user = FirebaseAuth.instance.currentUser;

    // If no user is logged in, redirect to login page
    if (user == null) {
      return const Center(
        child: Text('No user is logged in'),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display user's profile photo
            CircleAvatar(
              radius: 50,
              backgroundImage: user.photoURL != null
                  ? NetworkImage(user.photoURL!)
                  : null,
              child: user.photoURL == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            // Display user's name
            Text(
              user.displayName ?? 'No Name Available',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Display user's email
            Text(
              user.email ?? 'No Email Available',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            // Additional user info
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('UID'),
              subtitle: Text(user.uid),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email Verified'),
              subtitle: Text(user.emailVerified ? 'Yes' : 'No'),
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Last Sign-In Time'),
              subtitle: Text(
                user.metadata.lastSignInTime != null
                    ? user.metadata.lastSignInTime.toString()
                    : 'Not Available',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('Account Creation Time'),
              subtitle: Text(
                user.metadata.creationTime != null
                    ? user.metadata.creationTime.toString()
                    : 'Not Available',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

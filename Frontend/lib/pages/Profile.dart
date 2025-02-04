import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// setting components
import 'profile _components/Myprofile.dart';
import './profile _components/settings/setting.dart';
import './profile _components/notification/notification.dart';
// Main User Profile Screen
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildProfileHeader(),
          _buildMenuList(context),
        ],
      ),
    );
  }

  // Profile Header Section
  Widget _buildProfileHeader() {
    // Get the currently logged-in user
    User? user = FirebaseAuth.instance.currentUser;

    // If no user is logged in, redirect to login page
    if (user == null) {
      return const Center(
        child: Text('No user is logged in'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Display user's profile photo
          CircleAvatar(
            radius: 50,
            backgroundImage:
                user.photoURL != null ? NetworkImage(user.photoURL!) : null,
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
        ],
      ),
    );
  }

  // Menu List Section
  Widget _buildMenuList(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          _buildMenuItem(
              context, Icons.person, "My Profile", const ProfileScreen()),
          _buildMenuItem(context, Icons.color_lens, "Appearance",
              const AppearanceScreen()),
          _buildMenuItem(context, Icons.notifications, "Notifications",
              const NotificationScreen()),
          _buildMenuItem(context, Icons.privacy_tip, "Privacy Policy",
              const PrivacyPolicyScreen()),
          _buildMenuItem(
              context, Icons.settings, "Settings", const UserSettingsScreen()),
          _buildMenuItem(
              context, Icons.logout, "Log Out", const LogoutScreen()),
        ],
      ),
    );
  }

  // Menu Item Widget
  Widget _buildMenuItem(BuildContext context, IconData icon, String title,
      Widget destinationScreen) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationScreen),
      ),
    );
  }
}

// Placeholder Screens for Each Menu Option
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyProfileScreen(),
    );
  }
}

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context, "Appearance");
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmsReaderScreen(),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context, "Privacy Policy");
  }
}

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsScreen(),
    );
  }
}

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context, "Log Out");
  }
}

// Reusable Screen Builder for Placeholder Screens
Widget _buildScreen(BuildContext context, String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(
      child: Text(title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    ),
  );
}

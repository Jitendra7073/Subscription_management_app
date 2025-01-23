import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/settings_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildSectionCard(
                    title: 'Theme Settings',
                    icon: Icons.color_lens,
                    child: _buildColorThemeSection(settings),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Account Settings',
                    icon: Icons.person,
                    child: _buildAccountSection(settings),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Privacy & Policy',
                    icon: Icons.privacy_tip,
                    child: _buildPrivacyPolicySection(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue, size: 24),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildColorThemeSection(SettingsModel settings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Theme Mode:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Radio<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: settings.themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) settings.setThemeMode(value);
                  },
                ),
                const Text('Light'),
              ],
            ),
            Row(
              children: [
                Radio<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: settings.themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) settings.setThemeMode(value);
                  },
                ),
                const Text('Dark'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountSection(SettingsModel settings) {
    return Column(
      children: [
        ListTile(
          title: Text(
            settings.isLoggedIn ? settings.userEmail : 'Login to Account',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            settings.isLoggedIn ? 'Tap to logout' : 'Tap to login',
            style: TextStyle(color: Colors.grey[600]),
          ),
          leading: Icon(
            settings.isLoggedIn ? Icons.logout : Icons.login,
            color: settings.isLoggedIn ? Colors.red : Colors.green,
          ),
          onTap: () async {
            if (settings.isLoggedIn) {
              // Handle logout
              try {
                await FirebaseAuth.instance.signOut();
                settings.logoutUser(); // Update settings model
                print("Logged out successfully");
              } catch (e) {
                print("Error logging out: $e");
              }
            } else {
              // Handle login
              // You may want to navigate to the login page here
              print("Already logged in");
            }
          },
        ),
      ],
    );
  }

  Widget _buildPrivacyPolicySection() {
    return Column(
      children: [
        ListTile(
          title: const Text('Read Documentation'),
          leading: const Icon(Icons.description, color: Colors.blue),
          onTap: () {
            // Add documentation logic here
          },
        ),
      ],
    );
  }
}

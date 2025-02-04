import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal:10,vertical: 20),
        children: [
          _buildSettingItem(
            context,
            icon: Icons.lock_outline,
            title: "Change password",
            onTap: () => _navigateTo(context, const ChangePasswordScreen()),
          ),
          _buildSettingItem(
            context,
            icon: Icons.policy_outlined,
            title: "Terms & Condition",
            onTap: () => _navigateTo(context, const TermsAndConditionsScreen()),
          ),
          _buildSettingItem(
            context,
            icon: Icons.info_outline,
            title: "About us",
            onTap: () => _navigateTo(context, const AboutUsScreen()),
          ),
          _buildSettingItem(
            context,
            icon: Icons.delete_outline,
            title: "Delete account",
            onTap: () => _navigateTo(context, const DeleteAccountScreen()),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      bool isDestructive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: isDestructive ? Colors.red : Colors.black),
        ),
        title: Text(title, style: TextStyle(color: isDestructive ? Colors.red : Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// Placeholder Screens for Navigation
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Change Password")));
}

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Terms & Conditions")));
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("About Us")));
}

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Delete Account")));
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/login.dart';
import '../pages/Settings.dart';

class MenuHeader extends StatefulWidget {
  const MenuHeader({super.key});

  @override
  State<MenuHeader> createState() => _MenuHeaderState();
}

class _MenuHeaderState extends State<MenuHeader> {
  final GlobalKey _menuKey = GlobalKey(); // Key for positioning the menu
  OverlayEntry? _menuOverlay; // Store reference to the overlay entry

  void _toggleMenu() {
    if (_menuOverlay != null) {
      // If the menu is already open, close it
      _menuOverlay!.remove();
      _menuOverlay = null;
    } else {
      // If the menu is not open, show it
      _showMenu();
    }
  }

  void _showMenu() {
    final RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final overlay = Overlay.of(context);

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    _menuOverlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: position.dy + renderBox.size.height,
          right: 8,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    title: Text(
                      'Settings',
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    onTap: () {
                      _closeMenu(); // Close the menu
                      // Navigate to settings page or perform an action
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()));
                    },
                  ),
                  FirebaseAuth.instance.currentUser != null
                      ? ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                          onTap: () {
                            _closeMenu(); // Close the menu
                            _logout();
                          },
                        )
                      : ListTile(
                          leading: Icon(
                            Icons.login,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          title: Text(
                            'Login',
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                          onTap: () {
                            _closeMenu(); // Close the menu
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_menuOverlay!);
  }

  void _closeMenu() {
    if (_menuOverlay != null) {
      _menuOverlay!.remove();
      _menuOverlay = null;
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully')),
      );
      setState(() {}); // Update UI after logout
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during logout: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('TrackItAll'),
          actions: [
            IconButton(
              key: _menuKey,
              icon: const Icon(Icons.more_vert),
              onPressed: _toggleMenu,
            ),
          ],
        ),
      ],
    );
  }
}

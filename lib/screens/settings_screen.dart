import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart'; // Uncomment this if using GoRouter for navigation

/// **SettingsScreen**
/// This screen allows users to configure their application preferences.
/// It includes options for appearance, notifications, language selection, account management, and more.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // State for dark mode toggle
  bool _notificationsEnabled = true; // State for notifications toggle
  String _selectedLanguage = "Français"; // Default language selection

  /// ✅ **Function to log out the user**
  void _logout() {
    //context.go('/signin'); // Redirect to the sign-in page after logout (Uncomment if using GoRouter)
  }

  /// ✅ **Function to confirm account deletion**
  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to permanently delete your account?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement account deletion logic
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          // ✅ Appearance Section
          _buildSectionTitle("Appearance"),
          _buildSwitchTile(
            title: "Dark Mode",
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),

          // ✅ Notifications Section
          _buildSectionTitle("Notifications"),
          _buildSwitchTile(
            title: "Enable Notifications",
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),

          // ✅ Language Section
          _buildSectionTitle("Language"),
          _buildLanguageSelector(),

          // ✅ Account Management Section
          _buildSectionTitle("Account"),
          _buildListTile(
            title: "Change Password",
            icon: Icons.lock_outline,
            onTap: () {
              // TODO: Navigate to the password change screen
            },
          ),
          _buildListTile(
            title: "Delete Account",
            icon: Icons.delete_outline,
            onTap: _confirmDeleteAccount,
            color: Colors.red,
          ),

          // ✅ Support Section
          _buildSectionTitle("Support"),
          _buildListTile(
            title: "Help Center",
            icon: Icons.help_outline,
            onTap: () {
              // TODO: Navigate to the help center
            },
          ),
          _buildListTile(
            title: "Privacy Policy",
            icon: Icons.privacy_tip_outlined,
            onTap: () {
              // TODO: Navigate to privacy policy
            },
          ),

          // ✅ Data & Storage Section
          _buildSectionTitle("Data & Storage"),
          _buildListTile(
            title: "Data Usage",
            icon: Icons.storage_outlined,
            onTap: () {
              // TODO: Navigate to data usage settings
            },
          ),

          const SizedBox(height: 20),

          // ✅ Logout Button
          Center(
            child: ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// ✅ **Widget: Section Title**
  /// Displays a title for different sections (e.g., "Appearance", "Account").
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// ✅ **Widget: List Tile (Option Selection)**
  /// Generates a clickable list item with an icon and title.
  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  /// ✅ **Widget: Toggle Switch**
  /// Used for enabling/disabling settings such as Dark Mode and Notifications.
  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  /// ✅ **Widget: Language Selector**
  /// Allows users to select their preferred language from a dropdown menu.
  Widget _buildLanguageSelector() {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text("Language"),
      subtitle: Text(_selectedLanguage),
      trailing: DropdownButton<String>(
        value: _selectedLanguage,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLanguage = newValue;
            });
          }
        },
        items: ["Français", "English", "Español"]
            .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
            .toList(),
      ),
    );
  }
}

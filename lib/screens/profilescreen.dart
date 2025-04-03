import 'package:flutter/material.dart';
import 'package:mental_health/service/auth_service.dart';
import 'package:mental_health/service/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:mental_health/providers/theme_provider.dart';
import 'emergency_contact_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, String?>> _userData;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _userData = _fetchUserData();
  }

  Future<Map<String, String?>> _fetchUserData() async {
    final user = await _authService.getCurrentUser();

    if (user == null) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      });
      return {};
    }
    return {
      "name": user.name,
      "email": user.email,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('images/signup.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt,
                                  color: colorScheme.onPrimary, size: 20),
                              onPressed: () {
                                // Change profile pic logic
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<Map<String, String?>>(
                      future: _userData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            color: colorScheme.primary,
                          );
                        }
                        if (snapshot.hasError) {
                          return Text(
                            "Failed to load user data",
                            style: TextStyle(color: colorScheme.error),
                          );
                        }

                        final userData = snapshot.data!;
                        return Column(
                          children: [
                            Text(
                              userData["name"] ?? "",
                              style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onBackground,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              userData["email"] ?? "",
                              style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onBackground
                                      .withOpacity(0.7)),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              sectionTitle(context, "General Settings"),
              settingOption(context, Icons.notifications, "Notifications"),
              settingOption(context, Icons.person, "Personal Information"),
              settingOption(context, Icons.contact_phone, "Emergency Contact",
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmergencyContactsScreen()),
                );
              }),
              settingOption(context, Icons.language, "Language",
                  trailingText: "English (EN)"),
              switchOption(context, Icons.dark_mode, "Dark Mode"),
              const SizedBox(height: 10),
              sectionTitle(context, "Security & Privacy"),
              settingOption(context, Icons.security, "Security"),
              settingOption(context, Icons.help, "Help Center"),
              const SizedBox(height: 10),
              sectionTitle(context, "Danger Zone"),
              dangerOption(context, Icons.delete, "Close Account"),
              const SizedBox(height: 10),
              sectionTitle(context, "Log Out"),
              settingOption(context, Icons.logout, "Log Out", onTap: () async {
                try {
                  await _authService.logoutUser();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Logout failed: $e")),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget settingOption(BuildContext context, IconData icon, String title,
      {String? trailingText, VoidCallback? onTap}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        trailing: trailingText != null
            ? Text(
                trailingText,
                style: textTheme.bodySmall
                    ?.copyWith(color: colorScheme.onSurface.withOpacity(0.7)),
              )
            : Icon(Icons.arrow_forward_ios,
                size: 18, color: colorScheme.onSurface.withOpacity(0.7)),
        onTap: onTap,
      ),
    );
  }

  Widget switchOption(BuildContext context, IconData icon, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Card(
          color: colorScheme.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(icon, color: colorScheme.primary),
            title: Text(
              title,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            trailing: Switch(
              activeColor: colorScheme.primary,
              value: themeProvider.isDarkMode,
              onChanged: (bool newValue) {
                themeProvider.toggleTheme();
              },
            ),
          ),
        );
      },
    );
  }

  Widget dangerOption(BuildContext context, IconData icon, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.errorContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.error),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.error),
        ),
        onTap: () {},
      ),
    );
  }
}

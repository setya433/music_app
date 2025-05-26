import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final user = ref.watch(authRepositoryProvider).currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(height: 16),
              Text(
                "${user?.userMetadata?['fullname'] ?? 'Unknown'}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${user?.email ?? 'Unknown'}",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              SwitchListTile(
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                secondary: const Icon(Icons.dark_mode, color: AppColors.accent),
                value: isDarkMode,
                onChanged: (value) {
                  ref.read(themeModeProvider.notifier).state =
                      value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.settings, color: AppColors.accent),
                title: const Text("Settings", style: TextStyle(color: AppColors.textPrimary)),
                onTap: () {
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout", style: TextStyle(color: Colors.red)),
                
                onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: AppColors.background,
                    icon: const Icon(Icons.logout, color: Colors.red, size: 25),
                    title: const Text(
                      textAlign: TextAlign.center,
                      "Log Out?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      textAlign: TextAlign.center,
                      "We'll miss you! Are you sure you want to log out?",
                      style: TextStyle(fontSize: 16),
                    ),

                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), // cancel
                        child: const Text("Cancel"),
                        
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context); // close dialog
                          await ref.read(authRepositoryProvider).signOut();
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/signin',
                              (route) => false,
                            );
                          }
                        },
                        child: const Text("Logout", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

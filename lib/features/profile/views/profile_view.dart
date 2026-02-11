import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.snackbar('Settings', 'Settings page coming soon');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final user = controller.user.value;
        if (user == null) {
          return const Center(
            child: Text('Unable to load profile'),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Profile Header
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                          child: user.avatar != null
                              ? ClipOval(
                                  child: Image.network(
                                    user.avatar!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Theme.of(context).primaryColor,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 18,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt, size: 16),
                              color: Colors.white,
                              onPressed: () {
                                Get.snackbar(
                                  'Update Photo',
                                  'Photo upload coming soon',
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.role,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Profile Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _InfoRow(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: user.email,
                      ),
                      const Divider(height: 24),
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: user.phone ?? 'Not provided',
                      ),
                      const Divider(height: 24),
                      _InfoRow(
                        icon: Icons.badge_outlined,
                        label: 'User ID',
                        value: user.id,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Action Buttons
              Card(
                child: Column(
                  children: [
                    _ActionTile(
                      icon: Icons.edit_outlined,
                      title: 'Edit Profile',
                      onTap: controller.editProfile,
                    ),
                    const Divider(height: 1),
                    _ActionTile(
                      icon: Icons.lock_outlined,
                      title: 'Change Password',
                      onTap: controller.changePassword,
                    ),
                    const Divider(height: 1),
                    _ActionTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      trailing: Obx(() => Switch(
                        value: true,
                        onChanged: (value) {
                          controller.toggleNotifications();
                        },
                      )),
                    ),
                    const Divider(height: 1),
                    _ActionTile(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {
                        Get.snackbar('Help', 'Support resources coming soon');
                      },
                    ),
                    const Divider(height: 1),
                    _ActionTile(
                      icon: Icons.info_outline,
                      title: 'About',
                      onTap: () {
                        Get.snackbar('About', 'Ternak In v1.0.0');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Logout Button
              Card(
                color: Colors.red[50],
                child: _ActionTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  iconColor: Colors.red,
                  titleColor: Colors.red,
                  onTap: controller.logout,
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        );
      }),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? titleColor;

  const _ActionTile({
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

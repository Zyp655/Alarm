import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'dart:io' show Platform;
import '../../../core/dependencies.dart';
import '../../../core/theme/theme_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _enableNotifications = true;
  String _currentLanguage = 'Tiếng Việt';

  String _fixImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (Platform.isAndroid && url.contains('localhost')) {
      return url.replaceFirst('localhost', '10.0.2.2');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final user = sessionManager.signedInUser;
    final isDarkMode = context.watch<ThemeCubit>().state;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CircularProfileAvatar(
                    _fixImageUrl(user?.imageUrl),
                    radius: 50,
                    backgroundColor: Colors.white,
                    borderWidth: 2,
                    initialsText: Text(
                      (user?.userName?.isNotEmpty == true)
                          ? user!.userName![0].toUpperCase()
                          : '?',
                      style: const TextStyle(fontSize: 35, color: Colors.blue),
                    ),
                    borderColor: Colors.white,
                    elevation: 5.0,
                    cacheImage: true,
                    showInitialTextAbovePicture: false,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    user?.userName ?? 'Sinh viên',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user?.email ?? 'Chưa cập nhật email',
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Tài khoản'),
            _buildSettingsTile(
              icon: Icons.person_outline,
              title: 'Chỉnh sửa thông tin',
              cardColor: cardColor,
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.lock_outline,
              title: 'Đổi mật khẩu',
              cardColor: cardColor,
              onTap: () {},
            ),
            const SizedBox(height: 10),
            _buildSectionHeader('Ứng dụng'),
            _buildSettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Cài đặt thông báo',
              cardColor: cardColor,
              trailing: Switch(
                value: _enableNotifications,
                onChanged: (val) => setState(() => _enableNotifications = val),
              ),
            ),
            _buildSettingsTile(
              icon: Icons.language,
              title: 'Ngôn ngữ',
              subtitle: _currentLanguage,
              cardColor: cardColor,
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Giao diện tối',
              cardColor: cardColor,
              trailing: Switch(
                value: isDarkMode,
                onChanged: (val) {
                  context.read<ThemeCubit>().toggleTheme(val);
                },
              ),
            ),
            const SizedBox(height: 10),
            _buildSectionHeader('Khác'),
            _buildSettingsTile(
              icon: Icons.info_outline,
              title: 'Về ứng dụng',
              cardColor: cardColor,
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.logout,
              title: 'Đăng xuất',
              textColor: Colors.red,
              iconColor: Colors.red,
              cardColor: cardColor,
              onTap: () {},
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Color? textColor,
    Color? iconColor,
    required Color cardColor,
  }) {
    return Container(
      color: cardColor,
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? Theme.of(context).iconTheme.color,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing:
            trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

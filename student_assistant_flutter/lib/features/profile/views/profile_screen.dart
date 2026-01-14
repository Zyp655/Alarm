import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;
import '../../../core/dependencies.dart';
import '../../../config/app_routes.dart';
import '../../../core/theme/theme_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  bool _enableNotifications = true;
  String _currentLanguage = 'Tiếng Việt';

  String _fixImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (Platform.isAndroid && url.contains('localhost')) {
      return url.replaceFirst('localhost', '10.0.2.2');
    }
    return url;
  }

  Future<void> _handleSignOut() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await sessionManager.signOutDevice();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.signIn,
                      (route) => false,
                );
              }
            },
            child: const Text('Đồng ý', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    final user = sessionManager.signedInUser;
    final nameController = TextEditingController(text: user?.userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chỉnh sửa thông tin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên hiển thị'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã cập nhật thông tin (Demo)')),
              );
              setState(() {});
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đổi mật khẩu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Mật khẩu hiện tại'),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Mật khẩu mới'),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Nhập lại mật khẩu mới'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đổi mật khẩu thành công (Demo)')),
              );
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }

  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Text('🇻🇳', style: TextStyle(fontSize: 24)),
            title: const Text('Tiếng Việt'),
            trailing: _currentLanguage == 'Tiếng Việt'
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              setState(() => _currentLanguage = 'Tiếng Việt');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
            title: const Text('English'),
            trailing: _currentLanguage == 'English'
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              setState(() => _currentLanguage = 'English');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = sessionManager.signedInUser;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildSectionHeader('Tài khoản'),
            _buildSettingsTile(
              icon: Icons.person_outline,
              title: 'Chỉnh sửa thông tin',
              onTap: _showEditProfileDialog,
            ),
            _buildSettingsTile(
              icon: Icons.lock_outline,
              title: 'Đổi mật khẩu',
              onTap: _showChangePasswordDialog,
            ),

            const SizedBox(height: 10),

            _buildSectionHeader('Ứng dụng'),
            _buildSettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Cài đặt thông báo',
              trailing: Switch(
                value: _enableNotifications,
                onChanged: (val) {
                  setState(() => _enableNotifications = val);
                },
                activeColor: Colors.blue,
              ),
            ),
            _buildSettingsTile(
              icon: Icons.language,
              title: 'Ngôn ngữ',
              subtitle: _currentLanguage,
              onTap: _showLanguageSheet,
            ),
            _buildSettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Giao diện tối',
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (val) {
                  context.read<ThemeCubit>().toggleTheme(val);
                },
                activeColor: Colors.blue,
              ),
            ),

            const SizedBox(height: 10),

            _buildSectionHeader('Khác'),
            _buildSettingsTile(
              icon: Icons.info_outline,
              title: 'Về ứng dụng',
              onTap: () {
              },
            ),
            _buildSettingsTile(
              icon: Icons.logout,
              title: 'Đăng xuất',
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: _handleSignOut,
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
            color: Colors.grey[600],
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
  }) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.blueGrey),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: trailing ??
            const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
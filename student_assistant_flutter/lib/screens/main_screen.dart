import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import '../features/schedule/views/schedule_screen.dart';
import '../features/subject/views/subject_screen.dart';
import '../../main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  Widget _buildProfileTab() {
    final user = sessionManager.signedInUser;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProfileAvatar(
            user?.imageUrl ?? '',
            radius: 60,
            backgroundColor: Colors.blue,
            borderWidth: 2,
            initialsText: Text(
              (user?.userName?.isNotEmpty == true)
                  ? user!.userName![0].toUpperCase()
                  : '?',
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
            borderColor: Colors.white,
            elevation: 5.0,
            cacheImage: true,
            showInitialTextAbovePicture: false,
          ),
          const SizedBox(height: 16),
          Text(
            user?.userName ?? 'Người dùng',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            user?.email ?? 'Chưa cập nhật email',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () async {
              await sessionManager.signOutDevice();
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              "Đăng xuất",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      SubjectScreen(),
      const ScheduleScreen(),
      _buildProfileTab(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Môn học'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch biểu',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
      ),
    );
  }
}

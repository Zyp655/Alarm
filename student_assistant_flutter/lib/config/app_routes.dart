import 'package:flutter/material.dart';
import '../features/subject/views/subject_screen.dart';
import '../features/subject/views/subject_detail_screen.dart';
import '../screens/sign_in_screen.dart';
import 'package:student_assistant_client/student_assistant_client.dart';

class AppRoutes {
  static const String root = '/';
  static const String signIn = '/sign-in';
  static const String home = '/home';
  static const String subjectDetail = '/subject-detail';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case home:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
          settings: settings,
        );

      case signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );

      case subjectDetail:
        final args = settings.arguments;

        if (args is Subject) {
          return MaterialPageRoute(
            builder: (_) => SubjectDetailScreen(subject: args),
            settings: settings,
          );
        }
        return _errorRoute();

      case root:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lỗi')),
        body: const Center(child: Text('Không tìm thấy trang yêu cầu!')),
      );
    });
  }
}
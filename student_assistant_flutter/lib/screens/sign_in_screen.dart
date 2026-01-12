import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';
import '../main.dart';
import '../config/app_routes.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Center(
        child: Dialog(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SignInWithEmailButton(
                  caller: client.modules.auth,
                  onSignedIn: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                ),
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Divider(),
                    Container(
                      color: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        'HOẶC',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SignInWithGoogleButton(
                  caller: client.modules.auth,
                  clientId: config.googleClientId,
                  serverClientId: config.googleServerClientId,
                  redirectUri: Uri.parse(config.googleRedirectUri),
                  onSignedIn: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

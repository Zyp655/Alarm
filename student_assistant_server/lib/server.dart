import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart'
    hide Protocol, Endpoints;
import 'src/generated/endpoints.dart' as project_endpoints;
import 'src/generated/protocol.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';

void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    project_endpoints.Endpoints(),
    authenticationHandler: authenticationHandler,
  );

  AuthConfig.set(
    AuthConfig(
      sendValidationEmail: _sendValidationEmail,
      sendPasswordResetEmail: _sendPasswordResetEmail,
    ),
  );

  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(Uri(path: 'web/app').toFilePath()),
      ),
      '/app',
    );
  } else {
    pod.webServer.addRoute(
      StaticRoute.file(
        File(Uri(path: 'web/pages/build_flutter_app.html').toFilePath()),
      ),
      '/app/**',
    );
  }

  await pod.start();
}


Future<bool> _sendValidationEmail(session, email, validationCode) async {
  print('>>> [AuthConfig] MÃ XÁC THỰC: $validationCode <<<');
  return true;
}

Future<bool> _sendPasswordResetEmail(session, userInfo, validationCode) async {
  print('>>> [AuthConfig] MÃ ĐỔI PASS: $validationCode <<<');
  return true;
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  print('>>> [IDP Old] Code đăng ký: $verificationCode');
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  print('>>> [IDP Old] Code đổi pass: $verificationCode');
}

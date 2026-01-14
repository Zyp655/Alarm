import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart'
    hide Protocol, Endpoints;

import 'package:mailer/mailer.dart' as mail;
import 'package:mailer/smtp_server.dart';

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
    tokenManagerBuilders: [JwtConfigFromPasswords()],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCodeOld,
        sendPasswordResetVerificationCode: _sendPasswordResetCodeOld,
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
      FlutterRoute(Directory(Uri(path: 'web/app').toFilePath())),
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

final String _gmailUser = 'nguyendinhminhhieu03@gmail.com';
final String _gmailAppPassword = 'qogi psls grfx icle';

Future<bool> _sendValidationEmail(session, email, validationCode) async {
  final smtpServer = gmail(_gmailUser, _gmailAppPassword);

  final message = mail.Message()
    ..from = mail.Address(_gmailUser, 'Student Assistant Support')
    ..recipients.add(email)
    ..subject = 'Mã xác thực tài khoản Student Assistant'
    ..text =
        'Xin chào,\n\nMã xác thực của bạn là: $validationCode\n\nVui lòng nhập mã này vào ứng dụng để hoàn tất đăng ký.';

  try {
    final sendReport = await mail.send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
    return true;
  } catch (e) {
    print('LỖI GỬI MAIL: $e');
    return false;
  }
}

Future<bool> _sendPasswordResetEmail(session, userInfo, validationCode) async {
  final smtpServer = gmail(_gmailUser, _gmailAppPassword);

  final message = mail.Message()
    ..from = mail.Address(_gmailUser, 'Student Assistant Support')
    ..recipients.add(userInfo.email!)
    ..subject = 'Đặt lại mật khẩu Student Assistant'
    ..text = 'Xin chào,\n\nMã đặt lại mật khẩu của bạn là: $validationCode';

  try {
    await mail.send(message, smtpServer);
    return true;
  } catch (e) {
    print('LỖI GỬI MAIL RESET PASSWORD: $e');
    return false;
  }
}

void _sendRegistrationCodeOld(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {}

void _sendPasswordResetCodeOld(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {}

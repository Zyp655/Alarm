import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:student_assistant_client/student_assistant_client.dart';

import 'config/app_config.dart';
import 'config/app_routes.dart';
import 'features/subject/bloc/subject_bloc.dart';
import 'features/schedule/bloc/schedule_bloc.dart';
import 'screens/main_screen.dart';
import 'screens/sign_in_screen.dart';

late final Client client;
late final AppConfig config;
late final SessionManager sessionManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  config = await AppConfig.loadConfig();

  final keyManager = FlutterAuthenticationKeyManager();

  client = Client(
    config.apiUrl,
    authenticationKeyManager: keyManager,
  )..connectivityMonitor = FlutterConnectivityMonitor();

  sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  await sessionManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SubjectBloc()..add(LoadSubjects()),
        ),
        BlocProvider(
          create: (_) {
            final now = DateTime.now();
            final start = now.subtract(Duration(days: now.weekday - 1));
            final end = start.add(const Duration(days: 7));
            return ScheduleBloc()..add(LoadWeeklySchedule(start, end));
          },
        ),
      ],
      child: MaterialApp(
        title: 'Student Assistant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: ListenableBuilder(
          listenable: sessionManager,
          builder: (context, child) {
            if (sessionManager.signedInUser != null) {
              return const MainScreen();
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:student_assistant_client/student_assistant_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/app_config.dart';
import 'features/subject/bloc/subject_bloc.dart';
import 'features/subject/views/subject_screen.dart';

late final Client client;
late final AppConfig config;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  config = await AppConfig.loadConfig();

  final String serverUrl = config.apiUrl;

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  await client.auth.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Assistant',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => SubjectBloc()..add(LoadSubjects()),
        child: SubjectScreen(),
      ),
    );
  }
}
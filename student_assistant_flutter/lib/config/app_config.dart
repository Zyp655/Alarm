import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;
  final String googleClientId;
  final String googleServerClientId;
  final String googleRedirectUri;

  AppConfig({
    required this.apiUrl,
    required this.googleClientId,
    required this.googleServerClientId,
    required this.googleRedirectUri,
  });

  static Future<AppConfig> loadConfig() async {
    final config = await _loadJsonConfig();

    return AppConfig(
      apiUrl: config['apiUrl'] ?? '',
      googleClientId: config['googleClientId'] ?? '',
      googleServerClientId: config['googleServerClientId'] ?? '',
      googleRedirectUri: config['googleRedirectUri'] ?? '',
    );
  }

  static Future<Map<String, dynamic>> _loadJsonConfig() async {
    final data = await rootBundle.loadString('assets/config.json');
    return jsonDecode(data);
  }
}
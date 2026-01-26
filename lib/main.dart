import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routes/route_config.dart';
import 'core/routes/route_name.dart';
import 'core/routes/route_import_path.dart'; // if used
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🔥 REQUIRED
      initialRoute: RouteName.splash,

      // 🔥 REQUIRED
      onGenerateRoute: RouteConfig.generate,

      theme: AppTheme.light(),
    );
  }
}

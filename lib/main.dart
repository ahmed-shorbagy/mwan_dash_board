import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:dash_board/views/dash_board_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MwanDashBoard());
}

class MwanDashBoard extends StatelessWidget {
  const MwanDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: DashboardView(), // Use a separate widget for the home screen
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'EG'),
      themeMode: ThemeMode.dark,
      // Set text direction to RTL for Arabic
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}

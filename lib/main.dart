import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:dash_board/generated/l10n.dart';
import 'package:dash_board/views/dash_board_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      home: DashboardView(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'EG'),
      themeMode: ThemeMode.dark,
      // Add localization delegates
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Add supported locales
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', ''),
      ],
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

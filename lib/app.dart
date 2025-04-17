import 'package:flutter/material.dart';
import 'package:layer/core/theme/app_theme.dart';
import 'package:layer/main.dart';
import 'package:layer/presentation/screens/auth/LogInScreen.dart';
import 'package:provider/provider.dart';

class LayerAdvisor extends StatelessWidget {
  const LayerAdvisor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Legal Advisor',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return authProvider.isLoggedIn ? const LegalAdvisorApp() : const LogInScreen();
        },
      ),
    );
  }
}

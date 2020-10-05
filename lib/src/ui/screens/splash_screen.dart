import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import './login_screen.dart';
import './welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenTemplate(
        image: GRotateAnimation(
          child: Image.asset(
            'assets/images/logo.png',
            height: sizes.height(context) / 4,
            //width: 100,
          ),
        ),
        navigateAfterSplashScreen:
            context.watch<UserProvider>().user.idUser == null
                ? LoginScreen()
                : WelcomeScreen(),
      ),
    );
  }
}

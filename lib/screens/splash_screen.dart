import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/screens/home_nav.dart';

import '../utility/constants/colors.dart';
import '../utility/constants/image_strings.dart';
import '../view_Models/user_settings_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() async{
    await Future.delayed(const Duration(seconds: 5));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomeNav()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<UserSettingsProvider>().isLightMode
      ? TColors.primary : TColors.scaffoldBGDark,
      body: SafeArea(
        child: GestureDetector(
          onTap: context.read<UserSettingsProvider>().changeLightMode,
          child: Center(
            child: Image.asset(TImages.whiteAppLogo),
          ),
        ),
      ),
    );
  }
}

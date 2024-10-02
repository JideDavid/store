import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/screens/splash_screen.dart';
import 'package:store/utility/constants/size_config.dart';
import 'package:store/utility/theme/theme.dart';
import 'package:store/view_Models/products_provider.dart';
import 'package:store/view_Models/user_settings_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserSettingsProvider()),
      ChangeNotifierProvider(create: (_) => ProductsProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    context.read<UserSettingsProvider>().getSavedThemeMode();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<UserSettingsProvider>().isLightMode
          ? TAppTheme.lightTheme
          : TAppTheme.darkTheme,
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   colorScheme:
      //   useMaterial3: true,
      // ),
      home: const SplashScreen(),
    );
  }
}

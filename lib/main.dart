// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punto_de_reunion/Pages/home.dart';
import 'package:punto_de_reunion/Pages/login_screen.dart';
import 'package:punto_de_reunion/Pages/splash_page.dart';
import 'package:punto_de_reunion/Pages/promotion_splash.dart';
import 'package:punto_de_reunion/bloc/theme.dart';
import 'package:punto_de_reunion/providers/categories_provider.dart';
import 'package:punto_de_reunion/providers/organizations_provider.dart';
import 'package:punto_de_reunion/providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrganizationsProvider>(create: (_) => OrganizationsProvider()),
        ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
        ChangeNotifierProvider<CategoriesProvider>(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
      ],
      child: Builder(
        builder: (context) {
          final themeChanger = Provider.of<ThemeChanger>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Punto de reunión',
            theme: themeChanger.isDarkMode
                ? ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark().copyWith(
                      primary: Colors.teal,
                      secondary: Colors.deepOrange,
                      surface: Colors.grey[600]!,
                      background: const Color(0xFF111111),
                      error: Colors.red,
                      onPrimary: Colors.white,
                      onSecondary: Colors.white,
                      onSurface: Colors.white,
                      onBackground: Colors.white,
                      onError: Colors.white,
                    ),
                  )
                : ThemeData(
                    brightness: Brightness.light,
                    colorScheme: const ColorScheme.light().copyWith(
                      background: Colors.white,
                      primary: Colors.blue,
                      secondary: Colors.red,
                    ),
                  ),
            initialRoute: '/SplashPageRoute',
            routes: {
              'view_Home': (context) => const Home(),
              '/SplashPageRoute': (context) => const SplashPage(),
              '/PromotionSplashPageRoute': (context) => const PromotionSplashPage(),
              'LoginPageRoute': (context) => const LoginPage(),
            },
          );
        },
      ),
    );
  }
}

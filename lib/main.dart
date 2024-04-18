import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punto_de_reunion/Pages/Splash_Page.dart';
import 'package:punto_de_reunion/Pages/home.dart';
import 'package:punto_de_reunion/bloc/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeChanger()),
        ],
        child: Builder(
          builder: (context) {
            final themeChanger = Provider.of<ThemeChanger>(context);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Punto de reunión',
                theme: themeChanger.isDarkMode
                    ? ThemeData.dark()
                    : ThemeData.light().copyWith(
                        //primaryColor: Colors.blue,
                        colorScheme: ColorScheme.fromSwatch().copyWith(
                          primary: Colors.purple,
                          secondary: Colors.red, // Your accent color
                        ),
                      ),
                initialRoute: '/SplashPageRoute',
                routes: {
                  'view_Home': (context) => const Home(),
                  '/SplashPageRoute': (context) => const SplashPage(),
                });
          },
        ));
  }
}

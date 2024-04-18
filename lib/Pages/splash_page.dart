// ignore_for_file: library_prefixes

// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:punto_de_reunion/utils/responsive.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String splashRoute = '/SplashPageRoute';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        'view_Home',
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '¡Bienvenido!',
            style: TextStyle(
              fontSize: responsive.fontSizeTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

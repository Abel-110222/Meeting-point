import 'package:flutter/material.dart';
import 'package:punto_de_reunion/Pages/promotion_splash.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class SplashPage extends StatelessWidget {
 const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: const SplashContent(), // Aquí debes devolver tu contenido personalizado
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const PromotionSplashPage(),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    //Responsive responsive = Responsive(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logo.png', // Asegúrate de que la ruta del archivo sea correcta
            height: 200,
            width: 200,
          ),
          Text(
            'Meeting Point!',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade300,
            ),
          ),
        ],
      ),
    );
  }
}

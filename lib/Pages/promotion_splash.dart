// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromotionSplashPage extends StatefulWidget {
  const PromotionSplashPage({super.key});

  static const String promotionSplashRoute = '/PromotionSplashPageRoute';

  @override
  _PromotionSplashPageState createState() => _PromotionSplashPageState();
}

class _PromotionSplashPageState extends State<PromotionSplashPage> {
  final PageController _controller = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Aquí puedes manejar el evento de presionar el botón "Skip"
                    // Por ejemplo, puedes navegar a la siguiente pantalla o hacer lo que necesites.
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'view_Home',
                      (route) => false,
                    );
                  },
                  child: const Text('Skip'),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(activeDotColor: Colors.blue),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes manejar el evento de presionar el botón "Next" o "Empezar"
                    if (currentPage < 2) {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                    } else {
                    
                           Navigator.pushNamedAndRemoveUntil(
                              context,
                              'view_Home',
                              (route) => false,
                            );
                    }
                  },
                  child: Text(currentPage < 2 ? 'Next' : 'Empezar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mostrar la imagen desde los assets
          Image.asset(
            'assets/Order-food-amico.png',
            width: MediaQuery.of(context).size.width *
                0.5, // Ancho ajustado al 80% del ancho de la pantalla
          ),
          const SizedBox(height: 20), // Espacio entre la imagen y el texto
          // Agregar el texto debajo de la imagen
          const SizedBox(height: 20), // Espacio entre la imagen y el texto
          // Agregar el eslogan en mayúsculas, blanco y negrita debajo de la imagen
          const Text(
            'PIDE EN CUALQUIER MOMENTO',
            style: TextStyle(
              fontSize: 24, // Tamaño de fuente del eslogan
              fontWeight: FontWeight.bold, // Peso de la fuente en negrita
              color: Colors.black, // Color del texto (blanco)
            ),
          ),
          const SizedBox(height: 10), // Espacio adicional entre el eslogan y el texto descriptivo
          // Agregar el texto descriptivo más pequeño y gris debajo del eslogan
          const Text(
            'Haz tu pedido en línea y disfruta de la entrega rápida y conveniente de tus productos favoritos.',
            style: TextStyle(
              fontSize: 16, // Tamaño de fuente del texto descriptivo
              color: Colors.grey, // Color del texto (gris)
            ),
            textAlign: TextAlign.center, // Alineación del texto al centro
          ),
        ],
      ),
    );
  }
}

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(202, 255, 229, 167),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mostrar la imagen desde los assets
          Image.asset(
            'Online-Groceries-pana.png',
            width: MediaQuery.of(context).size.width *
                0.5, // Ancho ajustado al 80% del ancho de la pantalla
          ),
          const SizedBox(height: 20), // Espacio entre la imagen y el texto
          // Agregar el texto debajo de la imagen
          const Text(
            'ENTREGA HASTA TU LUGAR',
            style: TextStyle(
              fontSize: 24, // Tamaño de fuente del eslogan
              fontWeight: FontWeight.bold, // Peso de la fuente en negrita
              color: Colors.black, // Color del texto (blanco)
            ),
          ),
          const SizedBox(height: 10), // Espacio adicional entre el eslogan y el texto descriptivo
          // Agregar el texto descriptivo más pequeño y gris debajo del eslogan
          const Text(
            'Realizamos entregas a domicilio en toda la ciudad para que recibas tus productos en la comodidad de tu hogar.',
            style: TextStyle(
              fontSize: 16, // Tamaño de fuente del texto descriptivo
              color: Colors.grey, // Color del texto (gris)
            ),
            textAlign: TextAlign.center, // Alineación del texto al centro
          ),
        ],
      ),
    );
  }
}

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 250, 205),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mostrar la imagen desde los assets
          Image.asset(
            'In-no-time-cuate.png',
            width: MediaQuery.of(context).size.width *
                0.5, // Ancho ajustado al 80% del ancho de la pantalla
          ),
          const SizedBox(height: 20), // Espacio entre la imagen y el texto
          // Agregar el texto debajo de la imagen
          const Text(
            'EMPIEZA A VENDER',
            style: TextStyle(
              fontSize: 24, // Tamaño de fuente del eslogan
              fontWeight: FontWeight.bold, // Peso de la fuente en negrita
              color: Colors.black, // Color del texto (blanco)
            ),
          ),
          const SizedBox(height: 10), // Espacio adicional entre el eslogan y el texto descriptivo
          // Agregar el texto descriptivo más pequeño y gris debajo del eslogan
          const Text(
            'Crea tu propia organización y empieza a vender tus productos de manera fácil y rápida a través de nuestra plataforma.',
            style: TextStyle(
              fontSize: 16, // Tamaño de fuente del texto descriptivo
              color: Colors.grey, // Color del texto (gris)
            ),
            textAlign: TextAlign.center, // Alineación del texto al centro
          ),
        ],
      ),
    );
  }
}

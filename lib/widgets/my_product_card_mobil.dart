// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProductCardMobil extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Widget? image;
  final Color backColor;
  final bool isCarrito;

  const MyProductCardMobil({
    super.key,
    this.label = '',
    required this.onPressed,
    required this.image,
    this.backColor = Colors.white,
    this.isCarrito = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backColor = theme.cardColor;
    final textColor = theme.textTheme.bodyLarge!.color;

    return Card(
      child: Container(
        width: 300,
        height: 180,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen a la izquierda
            Container(
              width: 130, // Ancho de la imagen
              height: 150, // Alto de la tarjeta
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/hamburger-and-fries.jpg"),
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
            ),
            const SizedBox(width: 10), // Espacio entre la imagen y la información

            // Información y botón
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Texto de la tarjeta
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: ' Cangreburger\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'cangreburger con queso',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 201, 200, 200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5), // Espacio entre el texto y el precio

                  // Icono de favorito
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      FontAwesomeIcons.heart,
                      color: Colors.black,
                    ),
                  ),

                  // Precio
                  Text(
                    !isCarrito ? " \$250.00" : "",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5), // Espacio entre el precio y el botón

                  // Botón
                ],
              ),
            ),
            !isCarrito
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.red,
                          size: 15,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text("x2",
                            style: TextStyle(
                                color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

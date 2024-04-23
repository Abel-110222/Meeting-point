import 'package:flutter/material.dart';

class MyOrganizationCard extends StatelessWidget {
  final void Function() onPressed;
  final Widget? image;
  final bool isCarrito;

  const MyOrganizationCard({
    super.key,
    required this.onPressed,
    required this.image,
    this.isCarrito = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen a la izquierda
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre el contenedor y el texto
                const Text(
                  "Organización",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                          text: ' DESCRIPCION\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 201, 200, 200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyProductCard extends StatelessWidget {
  final String label;
  final Color? backColor;
  final TextStyle style;
  final void Function() onPressed;
  final Widget image;

  const MyProductCard({
    this.label = '',
    this.backColor = const Color.fromARGB(255, 232, 87, 87),
    this.style = const TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
    required this.onPressed,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen en la parte superior
          Container(
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: image,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Aquí puedes agregar información adicional sobre el producto
                  Text(
                    label,
                    style: style,
                  ),
                  const SizedBox(height: 8),
                  // Botón de acción
                  ElevatedButton(
                    onPressed: onPressed,
                    child: const Text('Ver detalles'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProductCard extends StatefulWidget {
  final bool skeleton;
  final String label;
  final String description;
  final String price;

  final void Function() onPressed;
  final Widget? image;
  final String url;
  final Color backColor;
  final bool isCarrito;

  const MyProductCard({
    super.key,
    this.skeleton = true,
    this.label = '',
    this.description = '',
    this.price = '',
    required this.onPressed,
    required this.image,
    required this.url,
    this.backColor = Colors.white,
    this.isCarrito = false,
  });

  @override
  State<MyProductCard> createState() => _MyProductCardState();
}

class _MyProductCardState extends State<MyProductCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backColor = theme.cardColor;
    final textColor = theme.textTheme.bodyLarge!.color;

    return Card(
      child: Container(
        width: 200,
        height: 260, // Ajuste en la altura de la tarjeta
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen en la parte superior
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120, // El 50% del alto de la tarjeta
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.url),
                  ),
                  color: theme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Texto de la tarjeta
                        Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.description,
                          maxLines: 2, // Número máximo de líneas permitidas
                          overflow: TextOverflow.ellipsis, // Manejo del desbordamiento de texto
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 201, 200, 200),
                          ),
                        ),

                        // RichText(
                        //   text: TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text: label,
                        //         style: TextStyle(
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black,
                        //         ),
                        //       ),
                        //       TextSpan(
                        //         text: "\n$description",
                        //         style: TextStyle(
                        //           fontSize: 12,
                        //           color: Color.fromARGB(255, 201, 200, 200),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // Precio
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    FontAwesomeIcons.heart,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //! precio

              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Text(
                  !widget.isCarrito ? widget.price : "",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 5),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.orange,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}

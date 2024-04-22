// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProductCard extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Widget? image;
  final Color backColor;

  const MyProductCard({
    super.key,
    this.label = '',
    required this.onPressed,
    required this.image,
    this.backColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backColor = theme.cardColor;
    final textColor = theme.textTheme.bodyLarge!.color;

    return Card(
      child: Container(
        width: 200,
        height: 235, // Ajuste en la altura de la tarjeta
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
                height: 100, // El 50% del alto de la tarjeta
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/hamburger-and-fries.jpg"),
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
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: RichText(
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
                              fontSize: 12, color: Color.fromARGB(255, 201, 200, 200)),
                        ),
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

              const Padding(
                padding: EdgeInsets.only(left: 5, bottom: 5),
                child: Text(
                  " \$250.00",
                  style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
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

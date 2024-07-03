// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:punto_de_reunion/widgets/my_text_class.dart';

class MyOrganizationCard extends StatelessWidget {
  final void Function() onPressed;
  final String? title;
  final String? description;
  final String? image;
  final bool isCarrito;
  final bool myOrganization;

  const MyOrganizationCard({
    super.key,
    required this.onPressed,
    required this.image,
    required this.title,
    required this.description,
    this.isCarrito = false,
    this.myOrganization = false,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener el tema actual
    final theme = Theme.of(context);
    // Verificar si el tema es oscuro
    final bool isDarkTheme = theme.brightness == Brightness.dark;

    // Obtener los colores del tema
    final backgroundColor = theme.colorScheme.background;
    final textColor = theme.textTheme.bodyLarge!.color;
    // double myWidthWork = (resp.widthPercent(100));
    return Card(
      child: Container(
        width: 250,
        height: 200,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
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
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover, // Opcional: ajusta la imagen dentro del contenedor
                  ),
                ),
                const SizedBox(width: 5),
                MyTextClass(text: title!, fontSize: 20, isTextColor: true, wrap: false),
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
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: ' DESCRIPCION\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        TextSpan(
                          text: description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 90, 90, 90),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: myOrganization,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton.icon(
                            icon: const Icon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {},
                            label: Text(
                              "Editar",
                              style: TextStyle(
                                color: Colors.teal.shade400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5), // Espacio entre los botones
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton.icon(
                            icon: Icon(
                              FontAwesomeIcons.xmark,
                              color: Colors.red.shade800,
                              size: 15,
                            ),
                            onPressed: () {},
                            label: Text(
                              "Eliminar",
                              style: TextStyle(
                                color: Colors.red.shade800,
                                fontSize: 15,
                              ),
                            ),
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

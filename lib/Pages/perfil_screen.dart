// ignore_for_file: unused_local_variable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:punto_de_reunion/utils/responsive.dart';
import 'package:responsive_grid/responsive_grid.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    //! -----------------------------------
    //! PROVIDER TEMA
    final theme = Theme.of(context);
    final bool isDarkTheme = theme.brightness == Brightness.dark;
    final backgroundColor = theme.colorScheme.surface;
    final textColor = theme.textTheme.bodyLarge!.color;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Acción para retroceder
          },
        ),
        title: const Text('Perfil de usuario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            width: resp.width,
            height: resp.height,
            color: backgroundColor,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const NetworkImage(
                    'https://cdn.pixabay.com/photo/2023/09/30/09/11/dachshund-8285216_1280.jpg', // Reemplaza con la URL de la imagen
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: textColor,
                      radius: 15,
                      child: Icon(
                        Icons.edit,
                        size: 15,
                        color: backgroundColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Información de tu cuenta",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ResponsiveGridRow(
                          rowSegments: 12,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ResponsiveGridCol(
                              xs: 12,
                              sm: 6,
                              md: 6,
                              lg: 4,
                              xl: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(labelText: 'Nombre(s)'),
                                  initialValue: 'Abel',
                                ),
                              ),
                            ),
                            ResponsiveGridCol(
                              xs: 12,
                              sm: 6,
                              md: 6,
                              lg: 4,
                              xl: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(labelText: 'Apellido(s)'),
                                  initialValue: 'Balam',
                                ),
                              ),
                            ),
                            ResponsiveGridCol(
                              xs: 12,
                              sm: 6,
                              md: 6,
                              lg: 4,
                              xl: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Correo Electrónico',
                                    suffixIcon: Icon(Icons.lock),
                                  ),
                                  initialValue: 'abelbalam.98@gmail.com',
                                ),
                              ),
                            ),
                            ResponsiveGridCol(
                              xs: 12,
                              sm: 6,
                              md: 6,
                              lg: 4,
                              xl: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(labelText: 'Celular'),
                                  initialValue: '9995095720',
                                ),
                              ),
                            ),
                            ResponsiveGridCol(
                              xs: 12,
                              sm: 6,
                              md: 6,
                              lg: 4,
                              xl: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(labelText: 'Número de identidad'),
                                ),
                              ),
                            ),
                            ResponsiveGridCol(
                              xs: 12,
                              sm: 6,
                              md: 6,
                              lg: 4,
                              xl: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Fecha de nacimiento',
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  initialValue: '01/01/1970',
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(height: 20),
                      const Text("Género", style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                          const Text("Hombre"),
                          Radio(value: 2, groupValue: 1, onChanged: (value) {}),
                          const Text("Mujer"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.lock),
                        title: const Text('Cambiar contraseña'),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          // Acción para cambiar contraseña
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Cerrar Sesión'),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          // Acción para cerrar sesión
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: resp.width > 500 ? 300 : double.infinity,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 81, 0),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton.icon(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            label: const Text('Eliminar Cuenta', style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              // Acción para eliminar cuenta
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

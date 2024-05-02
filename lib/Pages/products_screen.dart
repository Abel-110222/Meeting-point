// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:punto_de_reunion/utils/responsive.dart';
import 'package:punto_de_reunion/widgets/my_filter_card_product.dart';
import 'package:punto_de_reunion/widgets/my_product_card.dart';
import 'package:punto_de_reunion/widgets/my_product_card_mobil.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isLoading = false;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);

    // Obtener el tema actual
    final theme = Theme.of(context);
    // Verificar si el tema es oscuro
    // ignore: unused_local_variable
    final bool isDarkTheme = theme.brightness == Brightness.dark;

    // Obtener los colores del tema
    final backgroundColor = theme.colorScheme.background;
    final textColor = theme.textTheme.bodyLarge!.color;
    // double myWidthWork = (resp.widthPercent(100));
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: const Color.fromARGB(255, 54, 76, 244),
              size: 30,
            ),
            Text("     Cargando....", style: TextStyle(fontSize: resp.fontSizeTitle)),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            AnimSearchBar(
              width: 300,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              onSubmitted: (String) {},
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Cargando...."),
                  ],
                ),
              )
            : ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: resp.height,
                    width: resp.width,
                    // padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    color: Colors.white,
                    //decoration: BoxDecoration(border: Border.all(width: 0, color: Colors.amber)),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'NUESTROS PRODUCTOS\n',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
                                      ),
                                      const TextSpan(
                                        text: 'Pide tu producto ahora',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(255, 201, 200, 200)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                    MyFilterCardProduct(
                                      isActive: true,
                                      backgraundColor: textColor,
                                      colorText: backgroundColor,
                                      title: 'Categoría',
                                      onTap: () {
                                        // Acción al seleccionar el filtro de categoría
                                      },
                                    ),
                                    MyFilterCardProduct(
                                      backgraundColor: textColor,
                                      colorText: backgroundColor,
                                      title: 'Categoría',
                                      onTap: () {
                                        // Acción al seleccionar el filtro de categoría
                                      },
                                    ),
                                    MyFilterCardProduct(
                                      backgraundColor: textColor,
                                      colorText: backgroundColor,
                                      title: 'Categoría',
                                      onTap: () {
                                        // Acción al seleccionar el filtro de categoría
                                      },
                                    ),
                                    Card(
                                      elevation: 0.3,
                                      child: Container(
                                          width: 20,
                                          height: 20,
                                          color: Colors.transparent,
                                          child: const Icon(FontAwesomeIcons.sliders)),
                                    )
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              resp.width >= 700
                                  ? SizedBox(
                                      height: 235,
                                      child: Center(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 10,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 5, top: 15),
                                              child: MyProductCard(
                                                skeleton: isLoading,
                                                isCarrito: false,
                                                description:  '',
                                                price: "${12.00}",
                                                url:'',
                                                onPressed: () {
                                                  // Navegar a ProductScreen
                                                  Navigator.pushNamed(context, '/product');
                                                },
                                                image: null, // Usa la URL de la imagen del producto
                                                label: '',
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: List.generate(
                                          10,
                                          (rowIndex) {
                                            return Row(
                                              children: List.generate(
                                                MediaQuery.of(context).size.width >= 600
                                                    ? 2
                                                    : 1, // Verificar el ancho de la pantalla
                                                (columnIndex) {
                                                  return SizedBox(
                                                    width: MediaQuery.of(context).size.width >= 600
                                                        ? resp.width / 2
                                                        : resp.width,
                                                    height: 180,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15, right: 5, top: 15),
                                                      child: MyProductCardMobil(
                                                        url: "",
                                                        skeleton: isLoading,
                                                        isCarrito: false,
                                                        onPressed: () {
                                                          Navigator.pushNamed(context, '/product');
                                                        },
                                                        image: Image.asset(
                                                            'assets/hamburger-and-fries.jpg'),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
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
}

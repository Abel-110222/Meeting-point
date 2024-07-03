// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:punto_de_reunion/models/category/categories_model.dart';
import 'package:punto_de_reunion/providers/categories_provider.dart';
import 'package:punto_de_reunion/utils/responsive.dart';
import 'package:punto_de_reunion/widgets/my_category_card.dart';
import 'package:punto_de_reunion/widgets/my_filter_card_product.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isLoading = false;
  TextEditingController textController = TextEditingController();
  List<Categories> categories = [];

  @override
  void initState() {
    super.initState();
    //  loadcategories();
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    categoriesProvider.getCategories();
    categories = categoriesProvider.category;

    // Obtener el tema actual
    final theme = Theme.of(context);
    // Verificar si el tema es oscuro
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
              color: backgroundColor,
              searchIconColor: textColor,
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
                    color: backgroundColor,
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
                                        text: 'NUESTRAS CATEGORÍAS\n',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
                                      ),
                                      const TextSpan(
                                        text: 'Escoje tu categoría favorita',
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
                              ResponsiveGridRow(
                                rowSegments: 12,
                                children: List.generate(
                                  categories.length,
                                  (index) {
                                    final category = categories[index];
                                    return ResponsiveGridCol(
                                      xs: 12,
                                      sm: 6,
                                      md: 6,
                                      lg: 6,
                                      xl: 3,
                                      child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15, right: 5, top: 15),
                                            child: MyCategoryCard(
                                              skeleton: isLoading,
                                              label: category.name!,
                                              backColor: backgroundColor,
                                              textColor: textColor,
                                              width: resp.width,
                                              height: 250,
                                              onPressed: () {},
                                              image: const Icon(Icons.abc),
                                              widthScreen: resp.width,
                                            ),
                                          )),
                                    );
                                  },
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

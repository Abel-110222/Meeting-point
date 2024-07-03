// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:punto_de_reunion/models/organization/organization_model.dart';
import 'package:punto_de_reunion/providers/organizations_provider.dart';
import 'package:punto_de_reunion/utils/responsive.dart';
import 'package:punto_de_reunion/widgets/my_filter_card_product.dart';
import 'package:punto_de_reunion/widgets/my_organization_card.dart';
import 'package:responsive_grid/responsive_grid.dart';

class MiOrganizationsScreen extends StatefulWidget {
  const MiOrganizationsScreen({super.key});

  @override
  _MiOrganizationsScreenState createState() => _MiOrganizationsScreenState();
}

class _MiOrganizationsScreenState extends State<MiOrganizationsScreen> {
  bool isLoading = false;
  TextEditingController textController = TextEditingController();
  List<OrganizationModel> organizations = [];

  @override
  void initState() {
    super.initState();
    //  loadOrganizations();
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    final organizationsProvider = Provider.of<OrganizationsProvider>(context);
    organizationsProvider.getOrganizations();
    organizations = organizationsProvider.organizationList;

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
                                        text: 'ADMINISTRAR ORGANIZACIONES\n',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
                                      ),
                                      const TextSpan(
                                        text: 'Todas tus organizaciones\n',
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
                                  2,
                                  (index) {
                                    final itemOrganization = organizations[index];
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
                                            child: MyOrganizationCard(
                                              myOrganization: true,
                                              onPressed: () {},
                                              image: itemOrganization.imageUrl,
                                              description: itemOrganization.description,
                                              title: itemOrganization.name,
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

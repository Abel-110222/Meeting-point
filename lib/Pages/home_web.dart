import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:punto_de_reunion/bloc/theme.dart';
import 'package:punto_de_reunion/utils/responsive.dart';
import 'package:punto_de_reunion/widgets/my_category_card.dart';
import 'package:punto_de_reunion/widgets/my_text_form_field.dart';
import 'package:responsive_grid/responsive_grid.dart';

class HomeWeb extends StatefulWidget {
  static String routeName = 'View_Home_web';
  const HomeWeb({
    super.key,
  });

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  //!-------------------------------
  //! Variables
  bool isLoading = false;
  bool showCard = true;
  bool showWriter = false;

  ///
  ///!  *************************************************************
  ///!  GLOBALS KEYS
  ///!  *************************************************************
  ///
  //* GENERALES
  GlobalKey keyRespuesta = GlobalKey();

  ///!  *************************************************************
  ///!  TEXTE EDITING CONTROLLERS
  ///!  *************************************************************

  //*BUSCADOR SECUNDARIO
  TextEditingController respuestaController = TextEditingController();
  TextEditingController findControllerActividades = TextEditingController();

  ///
  ///!  *************************************************************
  ///!  FOCUS NODE
  ///!  *************************************************************
  ///
  ///
  ///FocusNode bloqueoEditarFocusNode = FocusNode();
  FocusNode respuestaFocusNode = FocusNode();

  //!-------------------------------
  //! Listas
  int currentIndex = 0; // Asegúrate de inicializar currentIndex
  int score = 0;

  @override
  void initState() {
    super.initState();
  }

  ///!  *************************************************************
  ///!  DISPOSE
  ///!  *************************************************************
  @override
  void dispose() {
    super.dispose();
    //general
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
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
          toolbarHeight: 100,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 50),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hola Abel\n',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '¿Qué vas a ordenar hoy?',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.account_circle, size: 40),
            ),
          ],
        ),
        drawer: buildDrawer(context), // Agrega el Drawer aquí
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
                              Column(
                                children: [
                                  //! RESPONSIVE GRID ROW
                                  ResponsiveGridRow(
                                    children: <ResponsiveGridCol>[
                                      //! SECCION DEL NOMBRE

                                      //!RESPONSIVE GRID COL
                                      ResponsiveGridCol(
                                        lg: 6,
                                        //md: 12,
                                        xs: 12,
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                                          height: 50,
                                          width: resp.widthPercent(30),
                                          child: MyTextFormField(
                                            label: 'Buscar',
                                            maxLength: 25,
                                            fontSize: 13,
                                            fontSizeLabel: 12,
                                            paddingBotton: 12,
                                            borderCircularSize: 5,
                                            borderWrap: true,
                                            underLineColor: Colors.grey,
                                            counterText: false,
                                            textEditingController: findControllerActividades,
                                            showUnderLine: false,
                                            suffixIcon: const Icon(Icons.search),
                                            validator: (value) {
                                              return null;
                                            },
                                            onChanged: (text) {
                                              //String str = text.trim().toUpperCase();

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 160,
                                    child: ListView.builder(
                                      scrollDirection:
                                          Axis.horizontal, // Para desplazamiento horizontal
                                      itemCount: 5, // Se repetirá 6 veces
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 30, right: 5),
                                          child: MyCategoryCard(
                                            width: 300,
                                            height: 250,
                                            onPressed: () {},
                                            image: const Icon(Icons.abc), widthScreen: resp.width,
                                          ),
                                        );
                                      },
                                    ),
                                  )

                                  // MyProductCard(
                                  //   onPressed: () {},
                                  //   image: const Icon(Icons.abc),
                                  // ),
                                ],
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

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Acción al seleccionar el elemento del Drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Cambiar tema
              final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
              themeChanger.isDarkMode = !themeChanger.isDarkMode;
            },
          ),
          // Agrega más elementos del Drawer según sea necesario
        ],
      ),
    );
  }
}

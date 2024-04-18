import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:punto_de_reunion/bloc/theme.dart';
import 'package:punto_de_reunion/utils/responsive.dart';

class Home extends StatefulWidget {
  static String routeName = 'view_Home';
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          title: const Text('Punto de reunión'),
          actions: [
            IconButton(
              icon: const Icon(Icons.lightbulb),
              onPressed: () {
                // Cambiar tema
                final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
                themeChanger.isDarkMode = !themeChanger.isDarkMode;
              },
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
            : SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0B132B), // Color inicial
                        Color(0xFF37547D), // Color final
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: const Column(
                    children: [],
                  ),
                ),
              ),
      );
    }
  }
}

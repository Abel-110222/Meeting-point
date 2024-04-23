// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:punto_de_reunion/Pages/categories_screen.dart';
import 'package:punto_de_reunion/Pages/organizations_screen.dart';
import 'package:punto_de_reunion/Pages/products_screen.dart';
import 'package:punto_de_reunion/bloc/theme.dart';
import 'package:punto_de_reunion/models/categories_model.dart';
import 'package:punto_de_reunion/utils/responsive.dart';
import 'package:punto_de_reunion/widgets/my_category_card.dart';
import 'package:punto_de_reunion/widgets/my_product_card.dart';
import 'package:punto_de_reunion/widgets/my_product_card_mobil.dart';
import 'package:punto_de_reunion/widgets/my_text_form_field.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _advancedDrawerController = AdvancedDrawerController();

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
  List<Categories> categories = []; // Variable para almacenar las categorías
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {});
    });
    // loadCategories();
  }

  ///!  *************************************************************
  ///!  DISPOSE
  ///!  *************************************************************
  @override
  void dispose() {
    super.dispose();
    //general
  }

  // Future<void> loadCategories() async {
  //   try {
  //     final categoryProvider = Provider.of<CategoryServices>(context, listen: false);
  //     final loadedCategories = await categoryProvider.getCategories();
  //     setState(() {
  //       categories = loadedCategories;
  //     });
  //   } catch (e) {
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);

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
      return AdvancedDrawer(
          backdrop: Container(
            width: 300,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
              ),
            ),
          ),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          // openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            // NOTICE: Uncomment if you want to add shadow behind the page.
            // Keep in mind that it may cause animation jerks.
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 0.0,
            //   ),
            // ],
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: kIsWeb ? buildDrawerWeb(context, isDarkTheme) : buildDrawer(context),
          child: Scaffold(
            persistentFooterAlignment: AlignmentDirectional.bottomCenter,
            resizeToAvoidBottomInset: false,

            extendBodyBehindAppBar: true,
            endDrawer: const Drawer(),
            drawerScrimColor: Colors.transparent, // Hace que el scrim del Drawer sea transparente
            appBar: null,
            drawer: kIsWeb ? buildDrawerWeb(context, isDarkTheme) : buildDrawer(context),
            key: _scaffoldKey,
            body: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  actions: const [SizedBox(height: 0, width: 0)],
                  scrolledUnderElevation: 3,
                  automaticallyImplyLeading: false,
                  expandedHeight: 70,
                  pinned: true,
                  floating: false,
                  elevation: 0,
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final double offset =
                          constraints.biggest.height; // Obtener el desplazamiento actual
                      double opacity =
                          1 - (offset / 200); // Calcular la opacidad basada en el desplazamiento
                      opacity = opacity.clamp(
                          0.0, 1.0); // Asegurar que la opacidad esté dentro del rango válido
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                            duration: const Duration(milliseconds: 250),
                            opacity: opacity,
                            child: null // Texto que puede desaparecer gradualmente
                            ),
                        background: const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      );
                    },
                  ),
                  title: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Builder(
                                builder: (BuildContext context) {
                                  return IconButton(
                                      onPressed: () {
                                        _scaffoldKey.currentState?.openDrawer();
                                      },
                                      icon: const Icon(Icons.menu));
                                },
                              ),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: const Color.fromARGB(255, 56, 56, 56),
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   width: 50,
                            //   height: 50,
                            //   child: !kIsWeb
                            //       ? IconButton(
                            //           onPressed: _handleMenuButtonPressed,
                            //           icon: ValueListenableBuilder<AdvancedDrawerValue>(
                            //             valueListenable: _advancedDrawerController,
                            //             builder: (_, value, __) {
                            //               return AnimatedSwitcher(
                            //                 duration: const Duration(milliseconds: 250),
                            //                 child: Icon(
                            //                   value.visible ? Icons.clear : Icons.menu,
                            //                   key: ValueKey<bool>(value.visible),
                            //                 ),
                            //               );
                            //             },
                            //           ),
                            //         )
                            //       : IconButton(
                            //           onPressed: () {
                            //             _scaffoldKey.currentState?.openDrawer();
                            //           },
                            //           icon: const Icon(Icons.menu)),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Hola Abel\n',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: textColor),
                                    ),
                                    TextSpan(
                                      text: '¿Qué vas a ordenar hoy?',
                                      style: TextStyle(fontSize: 15, color: textColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text('${resp.width}x${resp.height}', style: const TextStyle(fontSize: 12)),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Builder(
                            builder: (BuildContext context) {
                              return IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer(); // Abre el EndDrawer
                                },
                                icon: const Icon(FontAwesomeIcons.cartShopping),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 19, bottom: 10, right: 19, top: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ResponsiveGridRow(
                              children: <ResponsiveGridCol>[
                                ResponsiveGridCol(
                                  lg: 6,
                                  xs: 12,
                                  child: SizedBox(
                                    height: 50,
                                    width: resp.widthPercent(30),
                                    child: MyTextFormField(
                                      label: 'Buscar',
                                      maxLength: 25,
                                      fontSize: 14,
                                      fontSizeLabel: 14,
                                      paddingBotton: 0,
                                      borderCircularSize: 10,
                                      borderWrap: true,
                                      backColor: backgroundColor,
                                      underLineColor: Colors.grey,
                                      counterText: false,
                                      textEditingController: findControllerActividades,
                                      showUnderLine: false,
                                      suffixIcon: const Icon(FontAwesomeIcons.magnifyingGlass,
                                          color: Colors.grey),
                                      validator: (value) {
                                        return null;
                                      },
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
                SliverAppBar(
                    expandedHeight: 110,
                    scrolledUnderElevation: 0,
                    backgroundColor: backgroundColor,
                    actions: const [SizedBox(height: 0, width: 0)],
                    iconTheme: const IconThemeData(color: Colors.black),
                    pinned: true,
                    floating: false,
                    automaticallyImplyLeading: false,
                    shadowColor: textColor,
                    elevation: 0,
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 3,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: textColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(FontAwesomeIcons.arrowUpZA, color: backgroundColor),
                            ),
                          ),
                          FilterCard(
                            backgraundColor: textColor,
                            colorText: backgroundColor,
                            title: 'Precio',
                            icon: Icons.attach_money,
                            onTap: () {
                              // Acción al seleccionar el filtro de precio
                            },
                          ),
                          FilterCard(
                            backgraundColor: textColor,
                            colorText: backgroundColor,
                            title: 'Fecha',
                            icon: Icons.calendar_today,
                            onTap: () {
                              // Acción al seleccionar el filtro de fecha
                            },
                          ),
                          FilterCard(
                            backgraundColor: textColor,
                            colorText: backgroundColor,
                            title: 'Ubicación',
                            icon: Icons.location_on,
                            onTap: () {
                              // Acción al seleccionar el filtro de ubicación
                            },
                          ),
                          FilterCard(
                            backgraundColor: textColor,
                            colorText: backgroundColor,
                            title: 'Categoría',
                            icon: Icons.category,
                            onTap: () {
                              // Acción al seleccionar el filtro de categoría
                            },
                          ),
                        ],
                      ),
                    )),
                SliverToBoxAdapter(
                  child: isLoading
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
                      : GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            color: backgroundColor,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Align(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30, right: 30),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CATEGORIAS',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: resp.width <= 600 ? 80 : 160,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 30, right: 5),
                                        child: MyCategoryCard(
                                          backColor: backgroundColor,
                                          textColor: textColor,
                                          width: 300,
                                          height: 250,
                                          onPressed: () {},
                                          image: const Icon(Icons.abc),
                                          widthScreen: resp.width,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                resp.width >= 700
                                    ? SizedBox(
                                        height: 235,
                                        child: Center(
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 8,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 5, top: 15),
                                                child: MyProductCard(
                                                  onPressed: () {},
                                                  image:
                                                      Image.asset('assets/hamburger-and-fries.jpg'),
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
                                            4 ~/
                                                2, // Dividir el número total de elementos entre 2 para obtener la cantidad de filas
                                            (rowIndex) {
                                              return Row(
                                                children: List.generate(
                                                  MediaQuery.of(context).size.width >= 600
                                                      ? 2
                                                      : 1, // Verificar el ancho de la pantalla
                                                  (columnIndex) {
                                                    final index = rowIndex * 2 + columnIndex;
                                                    return SizedBox(
                                                      width:
                                                          MediaQuery.of(context).size.width >= 600
                                                              ? resp.width / 2
                                                              : resp.width,
                                                      height: 180,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 15, right: 5, top: 15),
                                                        child: MyProductCardMobil(
                                                          isCarrito: true,
                                                          onPressed: () {},
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
                                // ignore: prefer_const_constructors
                                SizedBox(height: 20),
                                Visibility(
                                  visible: resp.width >= 900,
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        height: 125,
                                        width: resp.width,
                                        child: Text(
                                            '© 2023 Punto de Reunión. Todos los derechos reservados.',
                                            style: TextStyle(color: textColor)),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ));
    }
  }

  Widget buildDrawer(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 300,
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 128.0,
                height: 130,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text('Profile'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.favorite),
                title: const Text('Favourites'),
              ),
              ListTile(
                onTap: () {
                  // Cambiar tema
                  final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
                  themeChanger.isDarkMode = !themeChanger.isDarkMode;
                },
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerWeb(BuildContext context, bool isDarkTheme) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkTheme
                ? [Colors.black87, Colors.black54]
                : [Colors.grey, Colors.grey.withOpacity(0.2)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'M E T I N G   P O I N T',
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 9, top: 9),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.house,
              ),
              title: const Text(' Home '),
              onTap: () {
                // Acción al seleccionar el elemento del Drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.bagShopping,
              ),
              title: const Text(' Productos '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductsScreen()),
                );
                // Cambiar tema
              },
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.tags,
              ),
              title: const Text(' Categorias '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.buildingUser,
              ),
              title: const Text(' Organizaciones '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrganizationsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                !isDarkTheme ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
              title: Text(
                isDarkTheme ? ' Modo claro ' : ' Modo oscuro ',
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              trailing: Transform.scale(
                scale: 0.8, // Ajusta este valor para cambiar el tamaño del switch
                child: Switch(
                  value: isDarkTheme,
                  onChanged: (value) {
                    final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
                    themeChanger.isDarkMode = value;
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.white.withOpacity(0.5),
                ),
              ),
              onTap: () {
                final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
                themeChanger.isDarkMode = !themeChanger.isDarkMode;
              },
            ),

            // Agrega más elementos del Drawer según sea necesario
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  CustomSliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant CustomSliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class FilterCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? backgraundColor;
  final Color? colorText;

  const FilterCard({
    super.key,
    this.title = "",
    required this.icon,
    required this.onTap,
    this.backgraundColor = Colors.white,
    this.colorText = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgraundColor,
              ),
              height: 40,
              width: 115,
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: colorText),
                  const SizedBox(width: 5),
                  Text(title ?? "", style: TextStyle(color: colorText)),
                ],
              ))),
    );
  }
}

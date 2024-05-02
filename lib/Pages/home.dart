// ignore_for_file: unused_local_variable, sized_box_for_whitespace, use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:punto_de_reunion/Pages/categories_screen.dart';
import 'package:punto_de_reunion/Pages/organizations_screen.dart';
import 'package:punto_de_reunion/Pages/products_screen.dart';
import 'package:punto_de_reunion/bloc/theme.dart';
import 'package:punto_de_reunion/models/category/categories_model.dart';
import 'package:punto_de_reunion/models/organization/organization_model.dart';
import 'package:punto_de_reunion/models/product/Product_Model.dart';
import 'package:punto_de_reunion/providers/organizations_provider.dart';
import 'package:punto_de_reunion/services_providers/Product_services.dart';
import 'package:punto_de_reunion/utils/struct_response.dart';
import 'package:punto_de_reunion/services_providers/category_services.dart';
import 'package:punto_de_reunion/utils/responsive.dart';
import 'package:punto_de_reunion/widgets/my_category_card.dart';
import 'package:punto_de_reunion/widgets/my_filter_card.dart';
import 'package:punto_de_reunion/widgets/my_product_card.dart';
import 'package:punto_de_reunion/widgets/my_product_card_mobil.dart';
import 'package:punto_de_reunion/widgets/my_text_form_field.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
  bool showButton = false;

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
  final AutoScrollController _autoScrollController = AutoScrollController();

  ///
  ///!  *************************************************************
  ///!  FOCUS NODE
  ///!  *************************************************************

  //!-------------------------------
  //! Listas
  int currentIndex = 0; // Asegúrate de inicializar currentIndex
  int score = 0;
  List<Categories> categories = []; // Variable para almacenar las categorías
  List<ProductModel> products = [];
  List<OrganizationModel> organizations = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _autoScrollController.addListener(_scrollListener);
    _scrollController.addListener(() {
      setState(() {});
    });
    loadCategories();
  }

  ///!  *************************************************************
  ///!  DISPOSE
  ///!  *************************************************************
  @override
  void dispose() {
    super.dispose();
    //general
  }

  void _scrollListener() {
    if (_autoScrollController.offset >= 150) {
      // Cambia 200 a la cantidad de desplazamiento que desees
      setState(() {
        showButton = true;
      });
    } else {
      setState(() {
        showButton = false;
      });
    }
  }

  Future<void> loadCategories() async {
    setState(() {
      isLoading = true;
    });
    StructResponse serviceResponse = StructResponse();

    try {
      final categoryProvider = Provider.of<CategoryServices>(context, listen: false);
      final loadedCategories = await categoryProvider.getCategories();
      setState(() {
        categories = loadedCategories.categories!;
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
    }

    try {
      final productProvider = Provider.of<ProductServices>(context, listen: false);
      final loadedProducts = await productProvider.getProducts();
      setState(() {
        products = loadedProducts.products!;
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    final organizationsProvider = Provider.of<OrganizationsProvider>(context);
    organizationsProvider.getOrganizations();
    organizations = organizationsProvider.organizationList;

    // double myWidthWork = (resp.widthPercent(100));
    // Obtener el tema actual
    final theme = Theme.of(context);
    //! -----------------------------------
    //! VARIBLE PARA SABER EL TEMA ACTUAL
    final bool isDarkTheme = theme.brightness == Brightness.dark;
    //! -----------------------------------
    //! COLORES DETEMA ACTUAL
    final backgroundColor = theme.colorScheme.background;
    final textColor = theme.textTheme.bodyLarge!.color;

    return Scaffold(
      floatingActionButton: showButton
          ? FloatingActionButton(
              backgroundColor: textColor,
              onPressed: () {
                _autoScrollController.animateTo(
                  0.0, // Posición a la que deseas desplazarte (inicio de la lista)
                  duration: const Duration(milliseconds: 500), // Duración de la animación
                  curve: Curves.easeInOut, // Curva de animación
                );
                setState(() {});
              },
              child: Icon(FontAwesomeIcons.arrowUp, color: backgroundColor),
            )
          : null,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      endDrawer: const Drawer(),
      drawerScrimColor: Colors.transparent, // Hace que el scrim del Drawer sea transparente
      appBar: null,
      drawer: buildDrawer(context, isDarkTheme),
      key: _scaffoldKey,
      body: CustomScrollView(
        controller: _autoScrollController,
        slivers: <Widget>[
          //! SLIVER APP BAR Drawer - Nombre de usuario - Carrito
          SliverAppBar(
            actions: const [SizedBox(height: 0, width: 0)],
            scrolledUnderElevation: 3,
            automaticallyImplyLeading: false,
            expandedHeight: 70,
            pinned: true,
            floating: false,
            elevation: 0,
            title: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! DRAWER
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
                      //! NOMBRE USUARIO
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hola Abel\n',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
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
                  //! CARRITO
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
          //! SLIVER BUSCADOR  ESCROLLABLE
          SliverToBoxAdapter(
            child: Container(
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 19, bottom: 10, right: 19, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${resp.width}x${resp.height}', style: const TextStyle(fontSize: 12)),
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
                                  String str = text.trim().toUpperCase();

                                  for (ProductModel item in products) {
                                    if (item.name!.toUpperCase().contains(str)) {
                                      products.add(item);
                                    }
                                  }
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
          //! SLIVER APP BAR FILTROS FIJOS
          SliverAppBar(
              expandedHeight: 59,
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
                //? tittedBox temporal ver su comportamiento
                child: FittedBox(
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Card(
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
                ),
              )),
          //! SLIVER  CATEGORIAS Y PRODUCTOS
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: backgroundColor,
                child: Column(
                  children: [
                    //!  TITLE CATEGORIAS
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
                    //!CARD CATEGORIAS
                    SizedBox(
                      height: resp.width <= 600 ? 80 : 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 30, right: 5),
                            child: MyCategoryCard(
                              skeleton: isLoading,
                              label: category.name!,
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
                    isLoading
                        //! PRODUCTOS
                        //! CircularProgressIndicator -> HAY QUE REMPLAZAR POR EL SKELETON

                        ? const CircularProgressIndicator()
                        : resp.width > 1350
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                    products.length,
                                    (index) {
                                      final product = products[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 5, top: 15),
                                        child: SizedBox(
                                          width: 350,
                                          height: 250,
                                          child: MyProductCard(
                                            onPressed: () {
                                              // Navegar a ProductScreen
                                              Navigator.pushNamed(context, '/product');
                                            },
                                            skeleton: isLoading,
                                            isCarrito: false,
                                            description: product.description ?? '',
                                            price: "${12.00}",
                                            url: product.images![0].url ?? '',

                                            image: null, // Usa la URL de la imagen del producto
                                            label: product.name!,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : resp.width < 1000
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: List.generate(
                                        products.length,
                                        (index) {
                                          final product = products[index];
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15, right: 5, top: 15),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              height: 180,
                                              child: MyProductCardMobil(
                                                skeleton: isLoading,
                                                isCarrito: false,
                                                description: product.description ?? '',
                                                price: "${12.00}",
                                                url: product.images![0].url ?? '',
                                                onPressed: () {
                                                  // Navegar a ProductScreen
                                                  Navigator.pushNamed(context, '/product');
                                                },
                                                image: null, // Usa la URL de la imagen del producto
                                                label: product.name!,
                                              ),
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
                                        (products.length / 2)
                                            .ceil(), // Dividir el número total de elementos entre 2 para obtener la cantidad de filas
                                        (rowIndex) {
                                          return Row(
                                            children: List.generate(
                                              MediaQuery.of(context).size.width >= 760
                                                  ? 2
                                                  : 1, // Verificar el ancho de la pantalla
                                              (columnIndex) {
                                                final index = rowIndex * 2 + columnIndex;
                                                if (index < products.length) {
                                                  // Verificar si el índice es válido
                                                  final product = products[index];
                                                  return SizedBox(
                                                    width: MediaQuery.of(context).size.width / 2,
                                                    height: 180,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15, right: 5, top: 15),
                                                      child: MyProductCardMobil(
                                                        skeleton: isLoading,
                                                        isCarrito: false,
                                                        description: product.description ?? '',
                                                        price: "${12.00}",

                                                        url: product.images![0].url ?? '',
                                                        onPressed: () {
                                                          // Navegar a ProductScreen
                                                          Navigator.pushNamed(context, '/product');
                                                        },
                                                        image:
                                                            null, // Usa la URL de la imagen del producto
                                                        label: product.name!,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox(); // Devuelve un contenedor vacío si el índice está fuera de rango
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                    // //! PRODUCTOS
                    // resp.width >= 850
                    //     //! RESOLUCION WEB
                    //     ? SizedBox(
                    //         height: 235,
                    //         child: Center(
                    //           child: ListView.builder(
                    //             scrollDirection: Axis.horizontal,
                    //             itemCount: products.length,
                    //             itemBuilder: (context, index) {
                    //               final product = products[index];
                    //               return Padding(
                    //                 padding: const EdgeInsets.only(left: 15, right: 5, top: 15),
                    //                 child: MyProductCard(
                    //                   onPressed: () {},
                    //                   image: null, // Usa la URL de la imagen del producto
                    //                   label: product.name!, // Usa el nombre del producto
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       )
                    //     //! RESOLUCION TABLETA Y MOVIL
                    //     : SingleChildScrollView(
                    //         scrollDirection: Axis.vertical,
                    //         child: Column(
                    //           children: List.generate(
                    //             (products.length / 2)
                    //                 .ceil(), // Dividir el número total de elementos entre 2 para obtener la cantidad de filas
                    //             (rowIndex) {
                    //               return Row(
                    //                 children: List.generate(
                    //                   MediaQuery.of(context).size.width >= 600
                    //                       ? 2
                    //                       : 1, // Verificar el ancho de la pantalla
                    //                   (columnIndex) {
                    //                     final index = rowIndex * 2 + columnIndex;
                    //                     if (index < products.length) {
                    //                       // Verificar si el índice es válido
                    //                       final product = products[index];
                    //                       return SizedBox(
                    //                         width: MediaQuery.of(context).size.width >= 600
                    //                             ? resp.width / 2
                    //                             : resp.width,
                    //                         height: 180,
                    //                         child: Padding(
                    //                           padding: const EdgeInsets.only(
                    //                               left: 15, right: 5, top: 15),
                    //                           child: MyProductCardMobil(
                    //                             skeleton: isLoading,
                    //                             isCarrito: false,
                    //                             description: product.description ?? '',
                    //                             price: "${12.00}",

                    //                             url: product.images![0].url ?? '',
                    //                             onPressed: () {
                    //                               // Navegar a ProductScreen
                    //                               Navigator.pushNamed(context, '/product');
                    //                             },
                    //                             image: null, // Usa la URL de la imagen del producto
                    //                             label: product.name!,
                    //                           ),
                    //                         ),
                    //                       );
                    //                     } else {
                    //                       return const SizedBox(); // Devuelve un contenedor vacío si el índice está fuera de rango
                    //                     }
                    //                   },
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    const SizedBox(height: 20),
                    //! FOOTER
                    Visibility(
                      visible: resp.width >= 900,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: 125,
                            width: resp.width,
                            child: Text('© 2023 Punto de Reunión. Todos los derechos reservados.',
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
    );
  }

//!------------------------------------------------------------------------------------------------
//! BUILD-DRAWER
  Widget buildDrawer(
    BuildContext context,
    bool isDarkTheme,
  ) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 130,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      const Border(bottom: BorderSide(color: Color.fromARGB(255, 151, 151, 151))),
                  color:
                      !isDarkTheme ? Colors.grey.shade100 : const Color.fromARGB(255, 48, 48, 48),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          child: CircularPercentIndicator(
                            radius: 16.0,
                            lineWidth: 3.0,
                            percent: 0.5,
                            center: const Text("50%", style: TextStyle(fontSize: 10.0)),
                            progressColor: Colors.orange, // Color de progreso naranja
                          ),
                        ),
                        const Icon(FontAwesomeIcons.xmark)
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        RichText(
                            text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Acompleta tu perfil\n',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'Completa tu perfil para terminar',
                              style:
                                  TextStyle(fontSize: 12, color: Color.fromARGB(255, 66, 66, 66)),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        width: 200,
                        height: 30, // Ajusta el ancho según sea necesario
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                          gradient: LinearGradient(
                            colors: [Colors.orange.shade400, Colors.orange.shade800],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Acción al presionar el botón
                          },
                          child: const Text(
                            "Editar Perfil",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDarkTheme
                        ? [const Color.fromARGB(221, 39, 39, 39), Colors.black54]
                        : [Colors.grey, Colors.grey.withOpacity(0.2)],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.abc,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    RichText(
                        text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Bienvenido\n',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Abel Balam',
                          style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 66, 66, 66)),
                        ),
                      ],
                    )),
                    const Spacer(),
                    Icon(
                      FontAwesomeIcons.xmark,
                      color: Colors.red.shade400,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

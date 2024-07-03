// ignore_for_file: use_build_context_synchronously, prefer_const_declarations

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:punto_de_reunion/utils/responsive.dart';
import 'package:punto_de_reunion/widgets/my_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String loginPageRoute = 'LoginPageRoute';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool textInvalid = false;
  GlobalKey<FormState> formKey = GlobalKey();
  bool activo = false;
  TextEditingController userController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmarPasswordController = TextEditingController();

  bool obscureTextPassword = true;
  @override
  void initState() {
    super.initState();
  }

  void login() async {
    final isOk = formKey.currentState!.validate();
    if (isOk) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //! -----------------------------------
    //! PROVIDER TEMA
    final theme = Theme.of(context);
    // ignore: unused_local_variable
    final bool isDarkTheme = theme.brightness == Brightness.dark;
    final backgroundColor = Colors.white;
    final textColor = Colors.black;
    final cardColor = theme.colorScheme.surface;
    Responsive resp = Responsive(context);
    double widthScreen = 700;
    bool mustBePortrait = resp.width < 650;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: !mustBePortrait ? const Color(0xFF2C5364) : backgroundColor,
        ),
        body: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: !mustBePortrait ? const Color(0xFF2C5364) : backgroundColor,
            ),
            child: ListView(
              children: [
                Center(
                  child: SizedBox(
                    width: widthScreen,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ///!  Panel Information
                        mustBePortrait
                            ? Container(
                                width: 0,
                                height: 350,
                                color: Colors.green[500],
                              )
                            : Container(
                                width: 350,
                                height: isLogin ? 500 : 525,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  boxShadow: const [
                                    // BoxShadow(
                                    //   color: !mustBePortrait
                                    //       ? backgroundColor
                                    //       : Colors.grey.withOpacity(0.5),
                                    //   offset: const Offset(0,
                                    //       5), // Ajusta el offset para mover la sombra hacia la derecha
                                    //   blurRadius: 7,
                                    //   spreadRadius: 0, // Cambia el spreadRadius según sea necesario
                                    // ),
                                  ],
                                ),
                                child: CustomPaint(
                                    painter: CustomShapePainter(), child: panelInformation()),
                              ),

                        ///!  Panel Data Input
                        Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            boxShadow: const [
                              // BoxShadow(
                              //   color: !mustBePortrait ? backgroundColor : Colors.grey.withOpacity(0.5),
                              //   offset: const Offset(
                              //       10, 0), // Ajusta el offset para mover la sombra hacia la derecha
                              //   blurRadius: 7,
                              //   spreadRadius: 0, // Cambia el spreadRadius según sea necesario
                              // ),
                            ],
                          ),
                          child: panelDataInput(
                            cardColor,
                            textColor,
                            backgroundColor,
                            mustBePortrait ? true : false,
                            resp,
                            440,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  Widget panelInformation() {
    return const Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.passthrough,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SizedBox(height: 35),
            SizedBox(height: 55),
            SizedBox(height: 30),
          ],
        ),

        ///!  Copy Right
        Positioned(
          left: 15,
          bottom: 75,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              " ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        )
      ],
    );
  }

  IconButton iconButtonAuth({
    required Function() onPressed,
    required double heightCard,
    required double widthCard,
    required Color color,
    required Icon icon, // Parámetro para recibir el ícono de awesome_icons
  }) {
    return IconButton(
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        fixedSize: Size(widthCard, heightCard),
        foregroundColor: color,
      ),
      icon: icon, // Utiliza el ícono recibido como parámetro
      onPressed: onPressed,
    );
  }

  Widget panelDataInput(
    Color cardColor,
    Color? textColor,
    Color backgColor,
    bool show,
    Responsive pResp,
    double pHeight,
  ) {
    return Form(
      key: formKey,
      autovalidateMode: activo ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      child: SizedBox(
        width: show ? pResp.width : 340,
        height: show
            ? pResp.heightPercent(90)
            : isLogin
                ? 500
                : 525,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///
            Expanded(
              flex: 10,
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    ///
                    ///!  Logo KananFleet
                    const SizedBox(height: 35),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                        ),
                      ),
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: 39,
                      child: Text("Bienvenido", style: TextStyle(fontSize: 24, color: textColor)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        iconButtonAuth(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.black,
                          heightCard: 60,
                          widthCard: show ? 90 : 60,
                          icon: const Icon(FontAwesomeIcons.github), // Pasa el ícono como parámetro
                        ),
                        iconButtonAuth(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.red,
                          heightCard: 60,
                          widthCard: show ? 90 : 60,
                          icon: const Icon(FontAwesomeIcons.google), // Pasa el ícono como parámetro
                        ),
                        iconButtonAuth(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.blue,
                          heightCard: 60,
                          widthCard: show ? 90 : 60,
                          icon:
                              const Icon(FontAwesomeIcons.facebook), // Pasa el ícono como parámetro
                        ),
                        iconButtonAuth(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.lightBlueAccent,
                          heightCard: 60,
                          widthCard: show ? 90 : 60,
                          icon: const Icon(
                              FontAwesomeIcons.microsoft), // Pasa el ícono como parámetro
                        ),
                      ],
                    ),

                    ///!  User
                    const SizedBox(height: 10),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Card(
                        elevation: 5,
                        child: MyTextFormField(
                          label: 'Email',
                          textEditingController: usernameController,
                          backColor: backgColor,
                          textoColor: textColor,
                          fontSize: pResp.isWeb ? 13 : 15,
                          borderWrap: true,
                          showUnderLine: false,
                          underLineColor: textColor!,
                          fontSizeLabel: pResp.isWeb ? 12 : 14,
                          borderCircularSize: 5,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (textInvalid) {
                              return 'Correo o contraseña incorrecta';
                            } else {
                              if (text!.trim().length <= 3) {
                                return 'Email invalido';
                              }
                            }

                            return null;
                          },
                          onChanged: (text) {},
                        ),
                      ),
                    ),

                    ///!  Password
                    //////!  Password
                    const SizedBox(height: 7),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Card(
                        elevation: 5,
                        child: MyTextFormField(
                            label: 'Contraseña',
                            textEditingController: passwordController,
                            backColor: backgColor,
                            textoColor: textColor,
                            borderWrap: true,
                            showUnderLine: false,
                            underLineColor: textColor,
                            fontSize: pResp.isWeb ? 13 : 15,
                            fontSizeLabel: pResp.isWeb ? 12 : 14,
                            borderCircularSize: 5,
                            obscureText: obscureTextPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureTextPassword = !obscureTextPassword;
                                });
                              },
                              icon: Tooltip(
                                message: "Mostrar contraseña",
                                child: Icon(
                                  obscureTextPassword
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.password,
                                  color: textColor,
                                ),
                              ),
                            ),
                            validator: (text) {
                              if (textInvalid) {
                                return 'Correo o contraseña incorrecta';
                              } else {
                                if (text!.trim().length <= 3) {
                                  return 'Contraseña invalida';
                                }
                              }
                              return null;
                            },
                            onChanged: (text) {},
                            onFieldSubmitted: (text) {}),
                      ),
                    ),

                    ///    ///!  Password
                    ///!  User
                    const SizedBox(height: 10),
                    Visibility(
                      visible: !isLogin,
                      child: Container(
                        height: isLogin ? 0 : 60,
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Card(
                          elevation: 5,
                          child: MyTextFormField(
                              label: 'Confirmar contraseña',
                              textEditingController: confirmarPasswordController,
                              backColor: backgColor,
                              underLineColor: textColor,
                              textoColor: textColor,
                              borderWrap: true,
                              showUnderLine: false,
                              fontSize: pResp.isWeb ? 13 : 15,
                              fontSizeLabel: pResp.isWeb ? 12 : 14,
                              borderCircularSize: 5,
                              obscureText: obscureTextPassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureTextPassword = !obscureTextPassword;
                                  });
                                },
                                icon: Tooltip(
                                  message: "Mostrar contraseña",
                                  child: Icon(
                                    obscureTextPassword
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.password,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              validator: (text) {
                                if (text!.trim().length <= 3) {
                                  return 'La contraseña debe tener al menos 4 caracteres';
                                } else {
                                  if (passwordController.text.trim() !=
                                      confirmarPasswordController.text.trim()) {
                                    return 'Las contraseñas no coinciden';
                                  }
                                }
                                return null;
                              },
                              onChanged: (text) {},
                              onFieldSubmitted: (text) {
                                setState(() {
                                  activo = true;
                                });
                                login();
                              }),
                        ),
                      ),
                    ),

                    // const SizedBox(height: 7),
                    // Container(
                    //   height: 60,
                    //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    //   child: Card(
                    //     elevation: 2,
                    //     child: TextFormField(
                    //       controller: passwordController,
                    //       decoration: InputDecoration(
                    //         labelText: 'Contraseña',
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(5),
                    //         ),
                    //         suffixIcon: IconButton(
                    //           onPressed: () {},
                    //           icon: const Icon(
                    //             Icons.remove_red_eye_outlined,
                    //             color: Colors.black38,
                    //           ),
                    //         ),
                    //       ),
                    //       obscureText: false,
                    //       validator: (text) {
                    //         if (text!.trim().length <= 3) {
                    //           return 'La contraseña debe tener al menos 4 caracteres';
                    //         }
                    //         return null;
                    //       },
                    //     ),
                    //   ),
                    // ),

                    ///!  Button Log In
                    const SizedBox(height: 7),
                    SizedBox(
                      height: 40,
                      width: 238,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 244, 132, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4), // Bordes cuadrados
                          ),
                          elevation: 5, // Añadir sombra
                          shadowColor: Colors.grey, // Color de la sombra
                        ),
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            obscureTextPassword = true;
                            activo = true;
                          });

                          login();
                        },
                      ),
                    ),

                    ///!  Forgot Password
                    const SizedBox(height: 0),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin ? 'Registrarse' : 'Ya tengo cuenta',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.6, 0)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.25, size.width * 0.8, size.height * 0.5)
      ..quadraticBezierTo(size.width, size.height * 0.75, size.width * 0.8, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

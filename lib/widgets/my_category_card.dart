// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

class MyCategoryCard extends StatefulWidget {
  final String label;
  final void Function() onPressed;
  final Widget image;
  final double width;
  final double height;

  const MyCategoryCard({
    required this.onPressed,
    required this.image,
    this.width = 200,
    this.height = 150,
    this.label = '',
    Key? key,
  }) : super(key: key);

  @override
  _MyCategoryCardState createState() => _MyCategoryCardState();
}

class _MyCategoryCardState extends State<MyCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Stack(
            children: [
              // Imagen que cubre toda la tarjeta
              Transform.scale(
                scale: _isHovered ? 1.1 : 1.0,
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/restaurant-breakfast.jpg"), // Reemplazar con tu ruta de imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: _isHovered ? 1.1 : 1.0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: 0.5,
                  child: Container(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Color semi-transparente encima de la imagen

              // Texto en el centro de la tarjeta
              const Center(
                child: Text(
                  'Producto',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

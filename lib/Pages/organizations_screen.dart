import 'package:flutter/material.dart';

class OrganizationsScreen extends StatelessWidget {
  const OrganizationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizaciones'),
      ),
      body: const Center(
        child: Text('¡Mira nuestras organizaciones aquí!'),
      ),
    );
  }
}

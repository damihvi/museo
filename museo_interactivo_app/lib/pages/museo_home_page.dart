import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MuseoHomePage extends StatelessWidget {
  const MuseoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Museo Interactivo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccione una opción:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => context.go('/salas'),
              child: const Text('Salas del museo'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/plan_visita'),
              child: const Text('Plan de visita'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/tienda_recuerdos'),
              child: const Text('Tienda de recuerdos'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/donaciones_sala'),
              child: const Text('Donaciones por sala'),
            ),
          ],
        ),
      ),
    );
  }
}

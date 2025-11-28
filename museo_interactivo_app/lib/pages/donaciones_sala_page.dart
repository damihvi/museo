import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DonacionesSalaPage extends StatefulWidget {
  const DonacionesSalaPage({super.key});

  @override
  State<DonacionesSalaPage> createState() => _DonacionesSalaPageState();
}

class _DonacionesSalaPageState extends State<DonacionesSalaPage> {
  final List<String> salas = [];
  final List<double> montos = [];

  String salaText = '';
  String montoText = '';
  String resultText = '';

  void agregarDonacion() {
    final sala = salaText.trim();
    final monto = double.tryParse(montoText.replaceAll(',', '.')) ?? 0.0;

    if (sala.isEmpty) {
      setState(() {
        resultText = 'Ingrese el nombre de la sala';
      });
      return;
    }

    if (monto <= 0) {
      setState(() {
        resultText = 'la cantidad debe ser mayor que 0';
      });
      return;
    }

    setState(() {
      salas.add(sala);
      montos.add(monto);
      salaText = '';
      montoText = '';
      resultText =
          'Donación agregada a la sala $sala  \cantidad${monto.toStringAsFixed(2)}';
    });
  }

  void calcularResumen() {
    if (salas.isEmpty) {
      setState(() {
        resultText = 'No hay donaciones';
      });
      return;
    }

    double total = 0.0;

    for (int i = 0; i < montos.length; i++) {
      total += montos[i];
    }

    final promedio = total / montos.length;
    final cantidad = montos.length;

    setState(() {
      resultText =
          'Total recaudado: \$${total.toStringAsFixed(2)}\n'
          'Promedio por donación: \$${promedio.toStringAsFixed(2)}\n'
          'Cantidad de donaciones: $cantidad';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donaciones por sala'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Registrar donación',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Nombre de la sala',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                salaText = value;
              },
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(
                labelText: 'cantidad de la donación (\$)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                montoText = value;
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: agregarDonacion,
              child: const Text('Agregar donación'),
            ),

            const SizedBox(height: 24),

            if (salas.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: salas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(salas[index]),
                        subtitle: Text('\$${montos[index].toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              salas.removeAt(index);
                              montos.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calcularResumen,
              child: const Text('Calcular donaciones'),
            ),

            const SizedBox(height: 16),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}

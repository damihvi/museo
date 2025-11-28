import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TiendaRecuerdosPage extends StatefulWidget {
  const TiendaRecuerdosPage({super.key});

  @override
  State<TiendaRecuerdosPage> createState() => _TiendaRecuerdosPage();
}

class _TiendaRecuerdosPage extends State<TiendaRecuerdosPage> {
  String Producto = 'tazas';
  String cantidad = '';
  String amountText = '';
  String resultText = '';

  void calculatePurchase() {
    final amount = double.tryParse(amountText.replaceAll(',', '.')) ?? 0.0;

    if (amount <= 0) {
      setState(() {
        resultText = 'Ingrese una cantidad válida';
      });
      return;
    }

    double rate = 0.0;

    if (Producto == 'tazas') {
      rate = 3;
    } else if (Producto == 'camisetas') {
      rate = 10;
    } else if (Producto == 'llaveros') {
      rate = 5;
    } else if (Producto == 'postales') {
      rate = 2;
    }

    final total = amount * rate;

    setState(() {
      resultText =
        'Producto: $Producto\n'
        'cantidad: ${amount.toStringAsFixed(1)}\n'
        'total: \$${total.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda de recuerdos'),
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
              'Calcular compra',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            DropdownButton<String>(
              value: Producto,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'tazas',
                  child: Text('tazas del museo'),
                ),
                DropdownMenuItem(
                  value: 'camisetas',
                  child: Text('camisetas del museo'),
                ),
                DropdownMenuItem(
                  value: 'llaveros',
                  child: Text('llaveros del museo'),
                ),
                DropdownMenuItem(
                  value: 'postales',
                  child: Text('postales del museo'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  Producto = value;
                });
              },
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Cantidad (\$)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                amountText = value;
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculatePurchase,
              child: const Text('Calcular compra'),
            ),

            const SizedBox(height: 16),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}

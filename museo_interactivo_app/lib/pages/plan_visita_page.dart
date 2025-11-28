import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlanVisitaPage extends StatefulWidget {
  const PlanVisitaPage({super.key});

  @override
  State<PlanVisitaPage> createState() => _PlanVisitaPageState();
}

class _PlanVisitaPageState extends State<PlanVisitaPage> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  String resultText = '';

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void calculateTotalTime() {
    double totalTime = 0.0;
    int roomCount = 0;

    for (var controller in _controllers) {
      final text = controller.text.trim();
      if (text.isNotEmpty) {
        final time = double.tryParse(text) ?? 0.0;
        if (time > 0) {
          totalTime += time;
          roomCount++;
        }
      }
    }

    if (roomCount == 0) {
      setState(() {
        resultText = 'Por favor, ingrese el tiempo de al menos una sala';
      });
      return;
    }

    String visitType = totalTime < 60
        ? 'Visita corta'
        : totalTime <= 120
        ? 'Visita media'
        : 'Visita larga';

    setState(() {
      resultText =
          'Tiempo total: ${totalTime.toInt()} minutos (${(totalTime / 60).toStringAsFixed(1)} horas)\n'
          'Salas visitadas: $roomCount\n'
          'Tipo de visita: $visitType';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planificar Visita'),
        leading: TextButton(
          onPressed: () => context.go('/'),
          child: const Text('Volver'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese el tiempo estimado para cada sala (minutos)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ...List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: _controllers[index],
                  decoration: InputDecoration(
                    labelText: 'Sala ${index + 1}',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              );
            }),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateTotalTime,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Calcular tiempo total',
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 24),
            if (resultText.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(resultText, style: const TextStyle(fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}

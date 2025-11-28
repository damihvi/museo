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
    double Tiempototal = 0.0;
    int roomsWithTime = 0;

    for (int i = 0; i < _controllers.length; i++) {
      final timeText = _controllers[i].text.trim();
      if (timeText.isNotEmpty) {
        final time = double.tryParse(timeText.replaceAll(',', '.')) ?? 0.0;
        if (time > 0) {
          Tiempototal += time;
          roomsWithTime++;
        }
      }
    }

    if (roomsWithTime == 0) {
      setState(() {
        resultText = 'Por favor, ingrese el tiempo de una sala';
      });
      return;
    }

    String visita;
    if (Tiempototal < 60) {
      visita = 'Visita corta';
    } else if (Tiempototal <= 120) {
      visita = 'Visita media';
    } else {
      visita = 'Visita larga';
    }

    setState(() {
      resultText = 
        'Tiempo total: ${Tiempototal.toStringAsFixed(0)} minutos (${(Tiempototal / 60).toStringAsFixed(1)} horas)\n\n'
        'Salas visitadas: $roomsWithTime\n\n'
        'Tipo de visita: $visita';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planificar Visita'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese el tiempo estimado para cada sala',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tiempo en minutos',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            ...List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: _controllers[index],
                  decoration: InputDecoration(
                    labelText: 'Sala ${index + 1} (minutos)',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.museum),
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
                child: Text(
                  resultText,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
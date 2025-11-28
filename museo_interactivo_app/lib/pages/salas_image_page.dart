import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SalasImagePage extends StatefulWidget {
  const SalasImagePage({super.key});

  @override
  State<SalasImagePage> createState() => _SalasImagePageState();
}

class _SalasImagePageState extends State<SalasImagePage> {
  final PageController _pageController = PageController();
  final List<String> _images = [
    'assets/images/museo1.jpg',
    'assets/images/museo2.jpg',
    'assets/images/museo3.jpg',
  ];

  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = _images.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Salas del museo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      _images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text('Foto de la sala numero ${_currentIndex + 1} de $total'),
          Text("exposiciones destacadas por sala"),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

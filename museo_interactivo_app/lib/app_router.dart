import 'package:go_router/go_router.dart';

import 'pages/museo_home_page.dart';
import 'pages/salas_image_page.dart';
import 'pages/plan_visita_page.dart';
import 'pages/tienda_recuerdos_page.dart';
import 'pages/donaciones_sala_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const MuseoHomePage()),
    GoRoute(path: '/salas', builder: (_, __) => const SalasImagePage()),
    GoRoute(path: '/plan_visita', builder: (_, __) => const PlanVisitaPage()),
    GoRoute(
      path: '/tienda_recuerdos',
      builder: (_, __) => const TiendaRecuerdosPage(),
    ),
    GoRoute(
      path: '/donaciones_sala',
      builder: (_, __) => const DonacionesSalaPage(),
    ),
  ],
);

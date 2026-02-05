import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/presentation/home/views/details_page.dart';
import 'package:pubchem/app/presentation/home/views/home_page.dart';
import 'package:pubchem/app/presentation/main/views/main_view.dart';
import 'package:pubchem/app/presentation/more/views/more_page.dart';
import 'package:pubchem/app/presentation/splash/view/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/', // Start at splash screen
    routes: [
      // Splash screen (no shell - full screen)
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Main app with bottom navigation
      ShellRoute(
        builder: (context, state, child) {
          return MainView(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/more',
            builder: (context, state) => const MorePage(),
          ),
        ],
      ),
      
      // Details page (no shell - full screen)
      GoRoute(
        path: '/details',
        builder: (context, state) {
          // You can pass extra data like this:
          final extra = state.extra as Map<String, dynamic>?;
          return const DetailsPage();
        },
      ),
    ],
  );
}
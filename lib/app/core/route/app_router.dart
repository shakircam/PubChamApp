import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/widget/error/error_screen.dart';
import 'package:pubchem/app/domain/models/compound.dart';
import 'package:pubchem/app/presentation/details/views/details_screen.dart';
import 'package:pubchem/app/presentation/home/views/featured_compounds_page.dart';
import 'package:pubchem/app/presentation/home/views/home_page.dart';
import 'package:pubchem/app/presentation/main/views/main_view.dart';
import 'package:pubchem/app/presentation/more/views/more_page.dart';
import 'package:pubchem/app/presentation/search/views/search_screen.dart';
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
      
      // Search page (no shell - full screen)
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),

      // Details page (no shell - full screen)
      GoRoute(
        path: '/details',
        builder: (context, state) {
          // Can pass compound object or just CID
          final extra = state.extra;
          int? cid;

          if (extra is Compound) {
            cid = extra.cid;
          } else if (extra is int) {
            cid = extra;
          }

          if (cid == null) {
            // Show error screen when CID is not provided
            return ErrorScreen(
              title: 'Invalid Compound',
              message: 'The compound information could not be loaded. Please try again.',
              onRetry: () => context.go('/home'),
            );
          }

          return DetailsScreen(cid: cid);
        },
      ),

      // Featured compounds page (no shell - full screen)
      GoRoute(
        path: '/featured-compounds',
        builder: (context, state) => const FeaturedCompoundsPage(),
      ),
    ],
  );
}
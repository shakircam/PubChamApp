import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/presentation/home/views/details_page.dart';
import 'package:pubchem/app/presentation/home/views/home_page.dart';
import 'package:pubchem/app/presentation/main/views/main_view.dart';
import 'package:pubchem/app/presentation/other/views/other_page.dart';
import 'package:pubchem/app/presentation/more/views/more_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
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
            builder: (context, state) => const SettingPage(),
          ),
          GoRoute(
            path: '/more',
            builder: (context, state) => const OtherPage(viewParam: 'More'),
          ),
        ],
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) => const DetailsPage(),
      ),
    ],
  );
}

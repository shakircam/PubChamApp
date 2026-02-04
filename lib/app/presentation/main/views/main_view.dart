import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

/// MainView now acts as a shell for GoRouter's ShellRoute
/// It receives the child page from GoRouter and displays it with persistent bottom navigation
class MainView extends StatelessWidget {
  final Widget child;

  const MainView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

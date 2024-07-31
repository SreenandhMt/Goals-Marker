import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goal_marker/bottom_navigation.dart';
import 'package:goal_marker/pages/home/home_page.dart';
import 'package:goal_marker/pages/profile/profile_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(builder: (context, state, navigationShell) => BottomPageRouting(key: state.pageKey,child: navigationShell,),branches: [
      StatefulShellBranch(routes: [
        GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePage();
      },
    ),
      ])
    ])
    
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Goal Marker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

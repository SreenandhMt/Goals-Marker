import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:goal_marker/bottom_navigation.dart';
import 'package:goal_marker/pages/auth/auth_page.dart';
import 'package:goal_marker/pages/editing_page/editing_page.dart';
import 'package:goal_marker/pages/home/home_page.dart';
import 'package:goal_marker/pages/profile/profile_page.dart';
import 'package:goal_marker/services/auth/auth_services.dart';
import 'package:goal_marker/services/home/home_provider.dart';
import 'package:goal_marker/services/profile/profile_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final GoRouter router = GoRouter(
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(builder: (context, state, navigationShell) => BottomPageRouting(key: state.pageKey,child: navigationShell,),branches: [
      StatefulShellBranch(routes: [
        GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
      path: 'edit',
      builder: (BuildContext context, GoRouterState state) {
        Map<String, dynamic>? mapData = state.extra as Map<String, dynamic>?;
        return EditGoalPage(map: mapData);
      },)
      ]
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
    ]),
    GoRoute(
      path: '/auth',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthRoute();
      },
    ),
  ],
    redirect: (BuildContext context, GoRouterState state) async {
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      final bool loggingIn = state.matchedLocation == "/auth";
      if (!loggedIn) return "/auth";
      if (loggingIn) return "/";
      // no need to redirect at all
      return null;
    },
);
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    router.refresh();
  });

  runApp( MyApp(router: router));
}



class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.router,
  });
  final GoRouter router;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthServices()),
        ChangeNotifierProvider(create: (context) => HomeServices()),
        ChangeNotifierProvider(create: (context) => ProfileServcies())
      ],
      child: MaterialApp.router(
        title: 'Goal Marker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 245, 244, 246)),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}

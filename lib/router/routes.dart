import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subapp/screens/Home.dart';
import 'package:subapp/screens/dashboard/dashboard.dart';
import 'package:subapp/screens/login.dart';
import 'package:subapp/screens/purchase.dart';
import 'package:subapp/screens/settings.dart';
import 'package:subapp/stores/auth_store.dart';
import 'package:subapp/screens/main_layout.dart';

class AppRouter {
  final AuthStore authState;
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  AppRouter(this.authState);

  late final GoRouter router = GoRouter(
    refreshListenable: authState,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/',
        name: 'home',
        builder: (context, state) => const Home(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const Dashboard(),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/purchase',
            name: 'purchase',
            builder: (context, state) => const Purchase(),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/login',
        name: 'login',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const Settings(),
      ),
    ],
    redirect: (context, state) {
      final loggedIn = authState.loggedIn;
      final isGoingToLogin = state.subloc == '/login';
      final isGoingToHome = state.subloc == '/';

      if (loggedIn && isGoingToHome) {
        return '/dashboard';
      }

      if (!loggedIn && !isGoingToLogin) {
        return '/login';
      } else {
        return null;
      }
    },
  );
}

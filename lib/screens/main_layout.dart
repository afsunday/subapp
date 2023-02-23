import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:subapp/stores/auth_store.dart';

class AppState {
  static Map<int, String> mapScreen = {};
  static ValueNotifier<bool> showNavBar = ValueNotifier(false);
  static List<BottomNavigationBarItem> navigationBarItems = [];
}

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: setIndex(), // _calculateSelectedIndex(context),
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.black87,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.house, size: 25.0),
          ),
          BottomNavigationBarItem(
            label: 'Purchase',
            icon: Icon(Icons.store, size: 25.0),
          ),
          BottomNavigationBarItem(
            label: 'Contacts',
            icon: Icon(Icons.contacts, size: 25.0),
          ),
          BottomNavigationBarItem(
            label: 'More',
            icon: Icon(Icons.apps, size: 25.0),
          ),
        ],
      ),
    );
  }

  setIndex() {
    final location = GoRouter.of(context).location;

    switch (location) {
      case '/dashboard':
        return 0;
      case '/purchase':
        return 1;
      case '/friends':
        return 2;
      case '/settings':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        return context.go('/dashboard');
      case 1:
        return context.go('/purchase');
      case 2:
        return context.go('/friends');
      case 3:
        return context.push('/settings');
      default:
        return context.go('/dashboard');
    }
  }
}

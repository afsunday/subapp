import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:subapp/stores/auth_store.dart';

import 'router/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = AuthStore(await SharedPreferences.getInstance());
  state.checkLoggedIn();
  runApp(MyApp(authState: state));
}

class MyApp extends StatelessWidget {
  final AuthStore authState;

  const MyApp({Key? key, required this.authState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthStore>(
          lazy: false,
          create: (BuildContext createContext) => authState,
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final router = AppRouter(authState).router;
          
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: 'Topit',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}

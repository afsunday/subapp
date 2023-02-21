import 'package:flutter/material.dart';
import 'package:subapp/support/styling.dart';
import 'package:go_router/go_router.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            children: [
              Text('Home page', style: Styles.headLineStyle1),
              ElevatedButton(
                onPressed: () => context.push('/login'),
                child: const Text('go to login'),
              )
            ],
          )
        )
      )
    );
  }
}
import 'package:flutter/material.dart';

class Purchase extends StatefulWidget {
  const Purchase({Key? key}) : super(key: key);

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          child: ListView(
            children: const [
              Text('purchase page')
            ],
          ),
        ),
      ),
    );
  }
}

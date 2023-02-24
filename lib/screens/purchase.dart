import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:subapp/stores/auth_store.dart';
import 'package:subapp/support/sizing.dart';

final Map<String, dynamic> colors = {
  "mtn.png": Colors.yellow[100],
  "9mobile.png": Colors.green[100],
  "glo.png": Colors.green[100],
  "airtel.png": Colors.red[100],
};

final List networks = [
  {"name": "MTN", "image": "mtn.png"},
  {"name": "9MOBILE", "image": "9mobile.png"},
  {"name": "GLO", "image": "glo.png"},
  {"name": "AIRTEL", "image": "airtel.png"},
];

class Purchase extends StatefulWidget {
  const Purchase({Key? key}) : super(key: key);

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'MTN 1GB - 500';
  List<String> options = [
    'MTN 1GB - 500',
    'MTN 2GB - 1000',
    'MTN 4GB - 2000',
    'MTN 6GB - 7000'
  ];

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final size = Sizing.getSize(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 35, 126, 65),
                image: DecorationImage(
                  image: AssetImage("assets/images/circle-bg.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, bottom: 50, left: 16, right: 16),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        balanceItem(
                            title: 'Wallet Balance',
                            amount: authStore.user.walletBalance),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                transform: Matrix4.translationValues(0.0, -32.0, 0.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDD100),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Stack(
                  children: [
                    contentLeft(size: size),
                    Positioned.fill(
                      top: 0.0,
                      left: size.width * 0.5,
                      right: 0.0,
                      bottom: 0.0,
                      child: Container(
                        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        child: Image.asset("assets/images/float-wallet.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sectionTitle(title: 'Purchase Plan'),
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 15, right: 0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: networks
                    .map((net) =>
                        NetworkCard(image: net['image'], network: net['name']))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 16.5),
                            child: Icon(Icons.attach_money),
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              items: options.map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: const TextStyle(
                                        fontSize: 14, color: Color(0xFF666666)),
                                  ),
                                );
                              }).toList(),
                              underline: SizedBox(),
                              iconSize: 0.0,
                              isExpanded: true,
                              hint: const Text('Select a Plan'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    const TextField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_in_talk),
                        hintText: 'Phone number',
                        hintStyle: TextStyle(color: Color(0xFF666666)),
                      ),
                    ),
                    const Gap(25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDD100),
                        minimumSize: const Size.fromHeight(50),
                        elevation: 0,
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ), // NEW

                      onPressed: () {},
                      child: const Text('Purchase'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget balanceItem({required double amount, required String title}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 14.0, color: Colors.white54),
      ),
      const Gap(3),
      Text(
        '\$$amount',
        style: const TextStyle(
          fontSize: 30.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

/// Widget left column for yellow container
Widget contentLeft({required size}) {
  return Container(
    width: size.width * 0.4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(5),
              backgroundColor: Colors.white,
              minimumSize: const Size(30.0, 30.0)),
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 20,
          ),
        ),
        const Gap(2),
        const Text(
          'Top up your Wallet',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ],
    ),
  );
}

/// icon network circles

Widget networkCircle({required String image}) {
  return Container(
    height: 45.0,
    width: 45.0,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(shape: BoxShape.circle, color: colors[image]),
    child: Container(
      height: 38.0,
      width: 38.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(
            "https://api1.logicdev.com.ng/image/$image",
          ),
        ),
      ),
    ),
  );
}

/// widget heading

Widget sectionTitle({required title}) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,
      bottom: 15,
      left: 16,
      right: 16,
    ),
    child: Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.grey[600], fontSize: 17),
    ),
  );
}

class NetworkCard extends StatelessWidget {
  final String image;
  final String network;

  const NetworkCard({Key? key, required this.image, required this.network})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Sizing.getSize(context);

    return Container(
      height: 120,
      width: size.width * 0.30,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 18.0),
      margin: const EdgeInsets.only(right: 17, top: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 158, 158, 158)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          networkCircle(image: image),
          const Gap(10),
          Text(
            network,
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

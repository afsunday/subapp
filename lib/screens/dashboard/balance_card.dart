import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subapp/support/styling.dart';
import 'package:subapp/support/sizing.dart';

// wallet balance card
class BalanceCard extends StatelessWidget {
  final double balance;

  const BalanceCard({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Sizing.getSize(context);
    return Container(
      height: 130,
      width: size.width * 0.65,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20.0),
      margin: const EdgeInsets.only(right: 17, top: 5),
      decoration: BoxDecoration(
        color: Colors.purple[400],
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/bg-pattern.png"),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, blurRadius: 18, spreadRadius: 5),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.wallet, size: 35.0, color: Colors.white),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Wallet Balance',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Gap(7.5),
              Text(
                "$balance",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// friends contact card
class FriendsCard extends StatelessWidget {
  final int total;

  const FriendsCard({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Sizing.getSize(context);
    return Container(
      height: 130.0,
      width: size.width * 0.65,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20.0),
      margin: const EdgeInsets.only(right: 17, top: 5),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/bg-pattern.png"),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, blurRadius: 18, spreadRadius: 5),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.people, size: 35.0, color: Colors.white),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Saved Contacts',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Gap(7.5),
              Text(
                "$total",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

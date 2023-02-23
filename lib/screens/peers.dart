import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:subapp/support/sizing.dart';

class PeerFriends extends StatefulWidget {
  const PeerFriends({super.key});

  @override
  State<PeerFriends> createState() => _PeerFriendsState();
}

class _PeerFriendsState extends State<PeerFriends> {
  List<Map> loyals = [
    {"name": "Jaremy Bentham", "image": "assets/images/person-three.jpg"},
    {"name": "Ben Carson", "image": "assets/images/person-one.jpg"},
    {"name": "Thomas Hobbes", "image": "assets/images/person-two.jpg"},
    {"name": "Saint Augustine", "image": "assets/images/person-one.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.0,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 35, 126, 65),
                image: DecorationImage(
                  image: AssetImage("assets/images/circle-bg.png"),
                  fit: BoxFit.fill,
                )),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      balanceItem(title: 'Total', amount: 290.00),
                      itemDivider(),
                      balanceItem(title: 'Deposit', amount: 100.00),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15, left: 16, right: 16),
            child: Text(
              'Philosophers',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey[600], fontSize: 17),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15, right: 0),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...loyals
                    .map((loyal) => PersonCard(
                          image: loyal['image'],
                          name: loyal['name'],
                        ))
                    .toList()
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Contacts Persons'),
                InkWell(
                  onTap: () => {},
                  child: Text('See all', style: TextStyle(
                    color: Colors.blue[800]
                  ),),
                ),
              ]
            ),
          ),
        ],
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
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

Widget itemDivider() {
  return Container(
    height: 45.0,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: const VerticalDivider(thickness: 2.0, color: Colors.white38),
  );
}

/// Recent card people horizontal scroll
class PersonCard extends StatelessWidget {
  final String image;
  final String name;

  const PersonCard({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Sizing.getSize(context);

    return Container(
      height: 150,
      width: size.width * 0.32,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 18.0),
      margin: const EdgeInsets.only(right: 17, top: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 158, 158, 158)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
          ),
          const Gap(10),
          Text(
            name,
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

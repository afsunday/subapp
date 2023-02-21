import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:http/src/response.dart';
import 'package:provider/provider.dart';
import 'package:subapp/models/wallet_history.dart';
import 'package:subapp/screens/dashboard/balance_card.dart';
import 'package:subapp/services/user_service.dart';
import 'package:subapp/stores/auth_store.dart';
import 'package:subapp/support/styling.dart';
import 'package:subapp/support/sizing.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<History>> getWalletHistory(UserService api) async {
    Response response = await api.getWalletHistory();

    List result = jsonDecode(response.body)['data']['data'];
    return result.map((e) => History.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = Sizing.getSize(context);
    final userApi = UserService(Provider.of<AuthStore>(context).token);
    final store = Provider.of<AuthStore>(context);

    return WillPopScope(
      onWillPop: handleClose,
      child: Scaffold(
        body: SafeArea(
          child: Scrollbar(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.user.firstname,
                              style:
                                  Styles.headLineStyle4.copyWith(fontSize: 23),
                            ),
                            const Text(
                              'Hi, Happy day!',
                            )
                          ]),
                      Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(store.user.avatar),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(20),

                // horizontal scroll list items
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 0),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      BalanceCard(balance: store.user.walletBalance),
                      FriendsCard(total: store.user.totalContacts)
                    ],
                  ),
                ),

                const Gap(16),
                Container(
                  color: const Color.fromARGB(15, 145, 145, 145),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Transactions',
                          style: TextStyle(fontSize: 14)),
                      const Gap(20),
                      FutureBuilder(
                        future: getWalletHistory(userApi),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading');
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data?.length ?? 0,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return HistoryTile(
                                  history: snapshot.data![index],
                                );
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // handle closing of aplication
  Future<bool> handleClose() async {
    return true;
  }
}

class HistoryTile extends StatelessWidget {
  final bool borderBottom;
  final History history;

  HistoryTile({
    Key? key,
    required this.history,
    this.borderBottom = true,
  }) : super(key: key);

  Map<String, dynamic> colors = {
    "mtn.png": Colors.yellow[100],
    "9mobile.png": Colors.green[100],
    "glo.png": Colors.green[100],
    "airtel.png": Colors.red[100],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: borderBottom
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 224, 222, 222), width: 1),
              ),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            width: 45.0,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: colors[history.itemImage]),
            child: Container(
              height: 38.0,
              width: 38.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                      "https://api1.logicdev.com.ng/image/${history.itemImage}"),
                ),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.description,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                const Gap(5),
                Text(
                  history.transactionDate.toString(),
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const Gap(20),
          Text(
              (history.entry == 'credit')
                  ? '+ ${history.amount}'
                  : "- ${history.amount}",
              style: TextStyle(
                color: (history.entry == 'credit') ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

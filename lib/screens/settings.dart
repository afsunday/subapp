import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:subapp/stores/auth_store.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<Map<String, dynamic>> menuItems = [
    {
      "title": "Get premium Cookies",
      "subtitle": null,
      "icon": Icons.style,
      "color": Colors.green[400]
    },
    {
      "title": "Security",
      "icon": Icons.security,
      "subtitle": "Avoid loss tighten your Security",
      "color": Colors.pink[400]
    },
    {
      "title": "Refferals",
      "icon": Icons.share,
      "subtitle": "Refer and enjoy more Cookies",
      "color": Colors.yellow[400]
    },
    {
      "title": "Get Help",
      "icon": Icons.support_agent,
      "subtitle": "Everyone needs Help",
      "color": Colors.purple[400]
    },
    {
      "title": "Account Upgrade",
      "icon": Icons.published_with_changes,
      "subtitle": "Upgrade to canadian cookie",
      "color": Colors.green[400]
    }
  ];

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AuthStore>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back, size: 28, color: Colors.grey[700]),
        ),
        elevation: 0.5,
        shadowColor: Colors.grey[200],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Scrollbar(
          child: ListView(
            shrinkWrap: false,
            padding: const EdgeInsets.symmetric(vertical: 15),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/images/person.png"),
                        ),
                      ),
                    ),
                    const Gap(15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${store.user.firstname} ${store.user.lastname}',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          const Gap(3),
                          const Text('Account details',
                              style: TextStyle(fontSize: 12.0))
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 25)
                  ],
                ),
              ),

              // item list sections
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Column(
                  children: [
                    ...menuItems
                        .map((menu) => MenuTiles(
                              title: menu['title'],
                              subtitle: menu['subtitle'],
                              icon: menu['icon'],
                              color: menu['color'],
                            ))
                        .toList(),
                    const Gap(50),
                    InkWell(
                      onTap: () => signout(context),
                      child: const Text(
                        'Sign out',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // sign out
  void signout(BuildContext context) {
    Provider.of<AuthStore>(context, listen: false).logout();
    context.go('/login');
  }
}

class MenuTiles extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color color;

  const MenuTiles(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.icon,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: Container(
        height: 35.0,
        width: 30.0,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(167, 197, 197, 197),
              blurRadius: 5,
              spreadRadius: 1.25,
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: (subtitle != null) ? Text(subtitle ?? '') : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
    );
  }
}

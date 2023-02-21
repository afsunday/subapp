import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subapp/models/user_model.dart';
import 'package:subapp/stores/auth_store.dart';
import 'package:subapp/support/sizing.dart';
import 'package:subapp/support/styling.dart';
import 'package:subapp/support/image_url.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  var processing = false;
  String emailError = '';
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final size = Sizing.getSize(context);

    return Consumer<AuthStore>(
      builder: (context, store, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: Scrollbar(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                children: [
                  Container(
                    height: 250,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(ImageUrl.personImg),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // login text heading
                  const Gap(25),
                  Text(
                    'Login',
                    style: Styles.headLineStyle2.copyWith(
                      fontSize: 40,
                      color: const Color(0xFF0A1A35),
                    ),
                  ),

                  // form input section
                  const Gap(15),
                  TextField(
                    controller: emailController,
                    autofocus: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.alternate_email_outlined),
                      hintText: 'Email ID',
                      hintStyle: TextStyle(color: Color(0xFF666666)),
                    ),
                  ),
                  const Gap(2),
                  Text(
                    emailError,
                    style: const TextStyle(fontSize: 12.0, color: Colors.red),
                  ),

                  const Gap(15),
                  TextField(
                    obscureText: showPassword,
                    controller: passwordController,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Color(0xFF666666)),
                      suffixIcon: InkWell(
                        onTap: setPasswordView,
                        child: showPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                  ),

                  // form submit button
                  const Gap(25),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 16)),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: processing
                        ? null
                        : () {
                            login()
                                .then((res) => _onLogin(context, res, store));
                          },
                    child: const Text('Login'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // password visibilty toggle
  void setPasswordView() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future login() async {
    FocusScope.of(context).unfocus();
    setState(() => processing = true);
    setState(() => emailError = '');
    prefs = await SharedPreferences.getInstance();

    try {
      var url = Uri.parse('https://api1.logicdev.com.ng/api/login');
      var response = await http.post(
        url,
        headers: {'accept': 'application/json'},
        body: {
          'email': emailController.text.toString(),
          'password': passwordController.text.toString()
        },
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() => processing = false);

      return data;
    } catch (e) {
      setState(() => processing = false);
      throw Exception('Failed to fetch data');
    }
  }

  void _onLogin(BuildContext context, Map data, store) {
    if (data.containsKey('errors')) {
      Map errors = data['errors'];

      setState(() => emailError = errors['email'][0]);
      _showSnackbar(data['message']);
    } else {
      final store = Provider.of<AuthStore>(context, listen: false);
      store.setLoggedIn(true, data['data']['token']);
      store.user = User.fromJson(data['data']['user']);

      context.go('/dashboard');
    }
  }

  // snackbar
  void _showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 10),
      ),
    );
  }
}

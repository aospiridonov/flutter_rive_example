import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TeddyLoginScreen extends StatefulWidget {
  const TeddyLoginScreen({Key? key}) : super(key: key);

  @override
  State<TeddyLoginScreen> createState() => _TeddyLoginScreenState();
}

class _TeddyLoginScreenState extends State<TeddyLoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //RiveAnimation.asset('assets/teddy-login-screen.riv'),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 1.3,
                    child: const RiveAnimation.asset(
                        'assets/teddy-login-screen.riv'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      label: const Text('username'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: const Text('password'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    child: const Text('Login'),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

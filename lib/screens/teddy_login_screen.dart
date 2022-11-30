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
  final GlobalKey<FormState> formKey = GlobalKey();
  late FocusNode focusNode;

  //rive
  final assetName = 'assets/teddy-login-screen.riv';
  final stateMachines = const ['State Machine 1'];
  final animations = const ['idle', 'look_idle'];

  SMIBool? _handsUp;
  SMIBool? _check;
  SMITrigger? _success;
  SMITrigger? _fail;
  SMINumber? _look;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    usernameController.clear();
    passwordController.clear();
    focusNode.dispose();
    super.dispose();
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _handsUp = controller.findInput<bool>('hands_up') as SMIBool?;
    _success = controller.findInput<bool>('success') as SMITrigger?;
    _fail = controller.findInput<bool>('fail') as SMITrigger?;
    _check = controller.findInput<bool>('Check') as SMIBool?;
    _look = controller.findInput<double>('Look') as SMINumber?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 1.25,
                      child: RiveAnimation.asset(
                        assetName,
                        stateMachines: stateMachines,
                        animations: animations,
                        onInit: _onRiveInit,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Focus(
                      onFocusChange: (value) {
                        _check?.value = value;
                      },
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: true,
                        controller: usernameController,
                        decoration: InputDecoration(
                          label: const Text('username'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        validator: emptyValidator,
                        onChanged: (value) {
                          _check?.value = true;
                          _look?.value =
                              usernameController.selection.baseOffset * 2;
                        },
                        onFieldSubmitted: (_) {
                          focusNode.requestFocus();
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Focus(
                      onFocusChange: (value) {
                        if (value == false) _handsUp?.value = false;
                      },
                      child: TextFormField(
                        maxLines: 1,
                        focusNode: focusNode,
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text('password'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        validator: emptyValidator,
                        onChanged: (value) {
                          _handsUp?.value = value.isNotEmpty;
                        },
                        onFieldSubmitted: (_) {
                          _handsUp?.value = false;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _handsUp?.value = false;
                        formKey.currentState?.validate() == true
                            ? _success?.fire()
                            : _fail?.fire();
                      },
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
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return 'Field is required';
    } else {
      return null;
    }
  }
}

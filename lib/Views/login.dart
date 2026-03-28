import 'dart:ui';

import 'package:docbook/Services/main_service.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/customWidgets/fields.dart';
import 'package:docbook/l10n/app_localizations.dart';
import 'package:docbook/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final TextEditingController phonector = TextEditingController();
  final TextEditingController passctor = TextEditingController();
  bool isIncorrect = false;

  @override
  void initState() {
    super.initState();
    phonector.text = '07721563250';
    passctor.text = '1234';
    initAsync();
  }

  void initAsync() async {
    await Service.openDb();
  }

  IconData obsecureIcon = Icons.remove_red_eye;
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: !isKeyboardVisible ? 80 : 60,
                      child: Image.asset(
                        'assets/imgs/Icon.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login Into Docbook',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withAlpha(120),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildTextField(
                            locale!.phone,
                            TextInputType.phone,
                            phonector,
                            context,
                            prefixIcon: Icons.phone,
                          ),
                          SizedBox(height: 15),
                          buildTextField(
                            locale.yourSecurePassword,
                            TextInputType.visiblePassword,
                            passctor,
                            context,
                            isObsecure: isObsecure,
                            prefixIcon: Icons.password,
                            suffixIcon: obsecureIcon,
                            onSuffixClick: () => {
                              setState(() {
                                isObsecure = !isObsecure;
                                if (isObsecure) {
                                  obsecureIcon = Icons.remove_red_eye;
                                } else {
                                  obsecureIcon = Icons.visibility_off;
                                }
                              }),
                            },
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              onPressed: login,
                              child: Text(
                                locale.login,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (!isKeyboardVisible)
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: Text(
                    locale.createAnAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    final locale = AppLocalizations.of(context);
    bool didLogin = await Currentuser.login(phonector.text, passctor.text);
    if (didLogin) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      showToast(
       locale!.errorHappened ,
        locale.incorrectPassOrPhone,
        ToastificationType.error,
        context,
      );
    }
  }
}

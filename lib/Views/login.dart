import 'package:docbook/Services/main_service.dart';
import 'package:docbook/customWidgets/textbox.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isIncorrect = false;
  

  @override
  void initState() {
    super.initState();

    emailController.text = 'osman@gmail.com';
    // emailController.text = 'yasin@gmail.com';
    passwordController.text = '1234';
    initAsync();
  }

  void initAsync() async {
    await Service.openDb();
 
  }

  IconData obsecureIcon = Icons.remove_red_eye;
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                        'assets/imgs/Appointment-256.png',
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
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildTextField(
                            'Email',
                            TextInputType.emailAddress,
                            emailController,
                            context,
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(height: 15),
                          buildTextField(
                            'Password',
                            TextInputType.visiblePassword,
                            passwordController,
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
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.primary,
                                ),
                                foregroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              onPressed: (){},
                              child: Text(
                                'Login',
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
                    'Dont have and account?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:docbook/Models/usersmodel.dart';
import 'package:docbook/Services/usershelper.dart';
import 'package:docbook/customWidgets/fields.dart';
import 'package:docbook/themes.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameCtor = TextEditingController();
  final passCtor = TextEditingController();
  final phoneCtor = TextEditingController();
  final professionCtor = TextEditingController();
  final addressCtor = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> genderList = ["male", "female"];
  int gender = 0;
  bool isObsecure = true, isDoctor = false;
  IconData obsecureIcon = Icons.remove_red_eye;
  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //   color: Theme.of(context).colorScheme.primary.withAlpha(120),
                //   borderRadius: BorderRadius.circular(20),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment(-0.7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            'Welcome to',
                            style: TextStyle(
                              fontFamily: 'rudawregular2',
                              fontSize: 32,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          padding: EdgeInsets.all(5),

                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(140),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/imgs/Icon-white.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          textAlign: TextAlign.center,
                          'DocBook',
                          style: TextStyle(
                            fontFamily: 'rudawregular2',
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(20),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildTextField(
                            'Full name',
                            TextInputType.text,
                            nameCtor,
                            context,
                            prefixIcon: Icons.person,
                            validate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'full name is required';
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(80),
                          ),
                          SizedBox(height: 12),
                          buildTextField(
                            'Phone No',
                            TextInputType.phone,
                            phoneCtor,
                            context,
                            prefixIcon: Icons.phone,
                            validate: (value) {
                              if (value == null ||
                                  value.toString().isEmpty ||
                                  value.toString().length != 11) {
                                return 'Invalid phone';
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(80),
                          ),
                          SizedBox(height: 12),
                          buildTextField(
                            'Password',
                            TextInputType.visiblePassword,
                            passCtor,
                            context,
                            isObsecure: isObsecure,
                            prefixIcon: Icons.lock,
                            suffixIcon: obsecureIcon,
                            onSuffixClick: () {
                              isObsecure = !isObsecure;
                              if (isObsecure) {
                                obsecureIcon = Icons.remove_red_eye;
                              } else {
                                obsecureIcon = Icons.visibility_off;
                              }
                              setState(() {});
                            },
                            validate: (value) {
                              if (value == null ||
                                  value.toString().length < 4) {
                                return 'password most be 4 characters at least';
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(80),
                          ),
                          SizedBox(height: 12),
                          buildTextField(
                            'Profession',
                            TextInputType.text,
                            professionCtor,
                            context,
                            prefixIcon: Icons.work,
                            validate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'Profession required';
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(80),
                          ),
                          SizedBox(height: 12),
                          buildTextField(
                            'Address',
                            TextInputType.text,
                            addressCtor,
                            context,
                            prefixIcon: Icons.work,
                            validate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'Address required';
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(80),
                          ),
                          SizedBox(height: 12),
                          dropdown(
                            'Gender',
                            'male',
                            ['male', 'female'],
                            context,
                            (value) {
                              gender = genderList.indexOf(value!);
                            },
                            prefixIcon: Icons.male,
                              fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(80), 
                          ),
                          SizedBox(height: 12),
                          SwitchListTile(
                            title: Text('I\'m a Doctor'),
                            subtitle: Text(
                              'selecting this makes your account to act as a doctor so patients can request meetings',
                            ),
                            value: isDoctor,
                            onChanged: (value) {
                              isDoctor = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (!isKeyboardVisible)
                ElevatedButton(onPressed: signup, child: Text('Signup')),
            ],
          ),
        ),
      ),
    );
  }

  Future signup() async {
    if (formKey.currentState!.validate()) {
      var model = UsersModel(
        0,
        nameCtor.text,
        phoneCtor.text,
        passCtor.text,
        isDoctor,
        professionCtor.text,
        addressCtor.text,
        gender,
      );

      int id = await UsersHelper.insertUser(model);
      if (id > 0) {
        showToast(
          'Sign Up Success',
          'Your account created successfuly',
          ToastificationType.success,
          context,
        );
      } else {
        showToast(
          'Failed',
          'An Error Occured',
          ToastificationType.error,
          context,
        );
      }
    }
  }
}

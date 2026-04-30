import 'package:docbook/Models/usersmodel.dart';
import 'package:docbook/Services/usershelper.dart';
import 'package:docbook/customWidgets/fields.dart';
import 'package:docbook/l10n/app_localizations.dart';
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
  int gender = 0;
  bool isObsecure = true, isDoctor = false;
  IconData obsecureIcon = Icons.remove_red_eye;
  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final locale = AppLocalizations.of(context);
    List<String> genderList = [locale!.male, locale.female];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),

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
                            locale!.welcomeTo,
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
                            locale.nameHolder,
                            TextInputType.text,
                            nameCtor,
                            context,
                            prefixIcon: Icons.person,
                            validate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return locale.plsTypeYourFullName;
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(30),
                          ),
                          SizedBox(height: 12),
                          buildTextField(
                            locale.phone,
                            TextInputType.phone,
                            phoneCtor,
                            context,
                            prefixIcon: Icons.phone,
                            validate: (value) {
                              if (value == null ||
                                  value.toString().isEmpty ||
                                  value.toString().length != 11) {
                                return locale.invalidPhone;
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(30),
                          ),
                          SizedBox(height: 12),
                          buildTextField(
                            locale.yourSecurePassword,
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
                                return locale.invalidPhone;
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(30),
                          ),
                          SizedBox(height: 12),
                          buildTextField(
                            locale.profession,
                            TextInputType.text,
                            professionCtor,
                            context,
                            prefixIcon: Icons.work,
                            validate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return locale.professionReq;
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(30),
                          ),
                          SizedBox(height: 12),
                          buildTextField(
                            locale.address,
                            TextInputType.text,
                            addressCtor,
                            context,
                            prefixIcon: Icons.work,
                            validate: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return locale.addressReq;
                              }
                              return null;
                            },
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(30),
                          ),
                          SizedBox(height: 12),
                          dropdown(
                            locale.gender,
                            locale.male,
                            [locale.male, locale.female],
                            context,
                            (value) {
                              gender = genderList.indexOf(value!);
                              print(
                                'selected $gender as index and value is $value',
                              );
                            },
                            prefixIcon: Icons.male,
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(30),
                          ),
                          SizedBox(height: 12),
                          SwitchListTile(
                            title: Text(
                              locale.imDoctor,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            subtitle: Text(locale.imDocDesc),
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
                ElevatedButton(onPressed: signup, child: Text(locale.signUp)),
            ],
          ),
        ),
      ),
    );
  }

  Future signup() async {
    final locale = AppLocalizations.of(context);

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
      print(model.gender);
      int id = await UsersHelper.insertUser(model);
      if (id > 0) {
        showToast(
          locale!.actionSuccess,
          locale.accountCreated,
          ToastificationType.success,
          context,
        );
      } else {
        showToast(
          locale!.errorHappened,
          locale.errorHappened,
          ToastificationType.error,
          context,
        );
      }
    }
  }
}

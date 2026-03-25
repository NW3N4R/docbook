import 'package:docbook/Models/usersmodel.dart';
import 'package:docbook/Services/usershelper.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/customWidgets/fields.dart';
import 'package:docbook/themes.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final nameCtor = TextEditingController();
  final passCtor = TextEditingController();
  final phoneCtor = TextEditingController();
  final professionCtor = TextEditingController();
  final addressCtor = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isObsecure = true, isDoctor = false;
  IconData obsecureIcon = Icons.remove_red_eye;
  List<String> genderList = ["male", "female"];
  int gender = Currentuser.loggedUser!.gender;
  @override
  void initState() {
    nameCtor.text = Currentuser.loggedUser!.fullName;
    phoneCtor.text = Currentuser.loggedUser!.phone;
    passCtor.text = Currentuser.loggedUser!.password;
    isDoctor = Currentuser.loggedUser!.seeingPatients;
    professionCtor.text = Currentuser.loggedUser!.profession;
    addressCtor.text = Currentuser.loggedUser!.address;
    gender = Currentuser.loggedUser!.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Update Your Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
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
                            if (value == null || value.toString().length < 4) {
                              return 'password most be 4 characters at least';
                            }
                            return null;
                          },
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
                        ),
                        SizedBox(height: 12),
                        buildTextField(
                          'Address',
                          TextInputType.text,
                          addressCtor,
                          context,
                          prefixIcon: Icons.location_on,
                          validate: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Address required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        dropdown(
                          'Gender',
                          genderList[Currentuser.loggedUser!.gender],
                          ['male', 'female'],
                          context,
                          (value) {
                            gender = genderList.indexOf(value!);
                          },
                          prefixIcon: Icons.male,
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
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 1. Trigger the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Delete"),
                              content: const Text(
                                "Are you sure you want to delete this user? This action cannot be undone.",
                              ),
                              actions: [
                                // 2. Cancel Button
                                TextButton(
                                  child: Text(
                                    "Cancel",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  onPressed: () => Navigator.of(
                                    context,
                                  ).pop(), // Closes the dialog
                                ),
                                // 3. Confirm Button
                                TextButton(
                                  onPressed: deleteProfile,
                                  child: Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Delete Account',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: updateUser,
                      child: Text('Update'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteProfile() async {
    int n = await UsersHelper.deleteUser(Currentuser.loggedUser!.id);
    if (n == 1) {
      showToast(
        'success',
        'account deleted',
        ToastificationType.success,
        context,
      );
      Currentuser.loggedUser = null;
      Navigator.pushReplacementNamed(context, '/');
    } else {
      showToast(
        'Failed',
        'couldn\' delete profile',
        ToastificationType.error,
        context,
      );
    }
  }

  void updateUser() async {
    if (!formKey.currentState!.validate()) return;
    var updatedUserModel = UsersModel(
      Currentuser.loggedUser!.id,
      nameCtor.text,
      phoneCtor.text,
      passCtor.text,
      isDoctor,
      professionCtor.text,
      addressCtor.text,
      gender,
    );
    int n = await UsersHelper.updateUser(updatedUserModel);
    if (n == 1) {
      Currentuser.loggedUser = updatedUserModel;
      showToast(
        "success",
        'profile updated',
        ToastificationType.success,
        context,
      );
      setState(() {});
    } else {
      showToast(
        "error",
        'profile coudln\'t be  updated',
        ToastificationType.error,
        context,
      );
    }
    Navigator.pop(context);
  }
}

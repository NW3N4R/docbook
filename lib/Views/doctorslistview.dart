import 'package:docbook/Models/appointmentsmodel.dart';
import 'package:docbook/Models/usersmodel.dart';
import 'package:docbook/Services/appointmenthelper.dart';
import 'package:docbook/Services/usershelper.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/customWidgets/fields.dart';
import 'package:docbook/l10n/app_localizations.dart';
import 'package:docbook/themes.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Doctorslistview extends StatefulWidget {
  const Doctorslistview({super.key});

  @override
  State<Doctorslistview> createState() => _DoctorslistviewState();
}

class _DoctorslistviewState extends State<Doctorslistview> {
  List<UsersModel> doctors = [];
  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    await UsersHelper.getUsers();
    doctors = UsersHelper.users.where((user) => user.seeingPatients).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale!.docList),
        actions: [
          IconButton(
            onPressed: () => showSearchModal(),
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          var currentDoc = doctors[index];
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: ListTile(
              isThreeLine: true,
              title: Text(
                currentDoc.fullName,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              subtitle: Text(
                '${currentDoc.phone} - ${currentDoc.profession} - ${currentDoc.address}',
              ),
              trailing: PopupMenuButton(
                onSelected: (String selectedValue) {
                  if (selectedValue == '0') {
                    setAppointment(currentDoc.id);
                  }
                },
                icon: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).colorScheme.primary,
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: '0',
                    child: ListTile(
                      leading: Icon(Icons.calendar_month),
                      title: Text(locale.reqAppointMent),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void setAppointment(int docId) async {
    var locale = AppLocalizations.of(context);
    final dateCtor = TextEditingController();
    final timeCtor = TextEditingController();
    final notesCtor = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildTextField(
                        locale!.appoDate,
                        TextInputType.datetime,
                        dateCtor,
                        context,
                        prefixIcon: Icons.calendar_month,
                        readOnly: true,
                        onTap: () async {
                          dateCtor.text = await pickDate(context);
                        },
                        validate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return locale.appoDateReq;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      buildTextField(
                        locale.appoTime,
                        TextInputType.datetime,
                        timeCtor,
                        context,
                        prefixIcon: Icons.timelapse,
                        readOnly: true,
                        onTap: () async {
                          timeCtor.text = await pickTime(context) ?? "";
                        },
                        validate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return locale.appoTimeReq;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      buildTextField(
                        locale.note,
                        TextInputType.text,
                        notesCtor,
                        context,
                        prefixIcon: Icons.text_decrease,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var appoint = AppointmentModel(
                              id: 0,
                              doctorId: docId,
                              patientId: Currentuser.loggedUser!.id,
                              appointmentDate: dateCtor.text,
                              appointmentTime: timeCtor.text,
                              status: AppointmentStatusModel.toInt(
                                AppointmentStatus.ongoing,
                              ),
                              notes: notesCtor.text,
                              createdAt: DateTime.now().toString(),
                            );
                            int newId = await AppointmentHelper.addAppointment(
                              appoint,
                            );
                            if (newId > 0) {
                              showToast(
                                locale.actionSuccess,
                                locale.actionSuccess,
                                ToastificationType.success,
                                context,
                              );
                              Navigator.pop(context);
                            } else {
                              showToast(
                                locale!.errorHappened,
                                locale.actionFailure,
                                ToastificationType.success,
                                context,
                              );
                            }
                          }
                        },
                        child: Text(locale.sendRequest,),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showSearchModal() async {
    var locale = AppLocalizations.of(context);
    final TextEditingController nameCtor = TextEditingController();
    final TextEditingController addCtor = TextEditingController();
    final TextEditingController phoneCtor = TextEditingController();
    showBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildTextField(
                      locale!.docName,
                      TextInputType.text,
                      nameCtor,
                      context,
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(height: 12),
                    buildTextField(
                      locale.docAddress,
                      TextInputType.text,
                      addCtor,
                      context,
                      prefixIcon: Icons.near_me,
                    ),
                    SizedBox(height: 12),
                    buildTextField(
                      locale.phone,
                      TextInputType.phone,
                      phoneCtor,
                      context,
                      prefixIcon: Icons.phone,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            nameCtor.clear();
                            addCtor.clear();
                            phoneCtor.clear();
                          },
                          child: Text(locale.clean,),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await UsersHelper.getUsers();
                            doctors = UsersHelper.users
                                .where(
                                  (user) =>
                                      user.seeingPatients &&
                                      user.fullName.contains(nameCtor.text) &&
                                      user.address.contains(addCtor.text) &&
                                      (user.phone == phoneCtor.text || phoneCtor.text.isEmpty),
                                )
                                .toList();
                            // setModalState(() {});
                            setState(() {});
                          },
                          icon: Icon(Icons.search),
                          label: Text(locale.search),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

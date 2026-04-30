import 'package:docbook/currentuser.dart';
import 'package:docbook/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    List<String> genderList = [locale!.male, locale.female];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale!.accountAndSettings,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Currentuser.loggedUser = null;
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(
              Icons.outbond,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(70),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    infoCard(Currentuser.loggedUser!.fullName, Icons.person),
                    infoCard(Currentuser.loggedUser!.phone, Icons.phone),
                    infoCard(Currentuser.loggedUser!.profession, Icons.work),
                    infoCard(
                      Currentuser.loggedUser!.address,
                      Icons.location_on,
                    ),
                    infoCard(
                      Currentuser.loggedUser!.gender >= 0
                          ? genderList[Currentuser.loggedUser!.gender]
                          : "-",
                      Icons.male,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Currentuser.loggedUser!.seeingPatients
                          ? Icons.done
                          : Icons.sick,
                    ),
                    SizedBox(width: 12),
                    Text(
                      Currentuser.loggedUser!.seeingPatients
                          ? locale.docAcc
                          : locale.patAcc,
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/updateProfile').then((value) {
                    setState(() {}); // Refresh UI
                  });
                },
                child: Text(locale.editProfile),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                child: Text(
                  locale.settings,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(String data, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(135),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              data,
              textAlign: TextAlign.start,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

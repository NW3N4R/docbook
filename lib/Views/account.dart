import 'package:docbook/currentuser.dart';
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

  List<String> genderList = ["male", "female"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account & Settings',
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
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
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
                      genderList[Currentuser.loggedUser!.gender],
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
                          ? 'your account is visible as doctor'
                          : 'you are on the platform as a patient',
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
                child: Text('Update Profile'),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Settings',
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
        color: Theme.of(context).colorScheme.primary.withAlpha(100),
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
            child: Icon(icon),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              data,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}

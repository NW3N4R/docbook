import 'package:docbook/Models/appointmentsmodel.dart';
import 'package:docbook/Services/appointmenthelper.dart';
import 'package:docbook/Services/usershelper.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<AppointmentModel> appoints = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    await AppointmentHelper.getAllAppointments();
    await UsersHelper.getUsers();
    var filteredAppoints = AppointmentHelper.appointments.where((ap) {
      final userId = Currentuser.loggedUser!.id;
      return ap.doctorId == userId || ap.patientId == userId;
    }).toList();

    // 2. Sort the list in-place
    filteredAppoints.sort(
      (a, b) => a.appointmentDate.compareTo(b.appointmentDate),
    );
    appoints = filteredAppoints;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Locale = AppLocalizations.of(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          currentUserCard(),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: dataCard(
                  Locale!.remaining,
                  appoints.where((x) => x.status <= 1).length.toString(),
                  Icons.timelapse,
                ),
              ),
              Expanded(
                child: dataCard(
                  Locale.completed,
                  appoints.where((x) => x.status == 3).length.toString(),
                  Icons.done_all,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: dataCard(
                  Locale.accepted,
                  appoints.where((x) => x.status == 1).length.toString(),
                  Icons.done,
                ),
              ),
              Expanded(
                child: dataCard(
                  Locale.rejected,
                  appoints.where((x) => x.status == 2).length.toString(),
                  Icons.close,
                ),
              ),
            ],
          ),
          dataCard(
            Locale.nextAppointments,
            appoints.firstOrNull != null
                ? '${appoints.first.appointmentDate} ${appoints.first.appointmentTime}'
                : "No Data",
            Icons.calendar_month,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/appointments').then((_) {
                    load();
                  });
                },
                child: Text(Locale.myAppointments),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget currentUserCard() {
    var locale = AppLocalizations.of(context);
    String imgPath = locale!.localeName == "en"
        ? "assets/imgs/docRTL.png"
        : "assets/imgs/doc.png";
    return Stack(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          // 2. Short duration for a rapid "twink"
          duration: const Duration(milliseconds: 500),
          // 3. Elastic curve gives it the bouncy "twink" feel
          curve: Curves.linear,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, -100 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset('assets/imgs/Icon.png'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    locale.welcomeBack,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      height: 0.5,
                    ),
                  ),
                  Text(
                    Currentuser.loggedUser!.fullName,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Align(
              alignment: locale!.localeName == "en"
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: TweenAnimationBuilder<double>(
                // 1. Define the range (from 0.0 to 1.0)
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value, // Fades in
                    child: Transform.translate(
                      offset: Offset(
                        50 * (1 - value),
                        0,
                      ), // Slides in 50px from the right
                      child: child,
                    ),
                  );
                },
                // 2. Pass the image as a child to optimize performance (prevents image rebuilds)
                child: Image.asset(imgPath, height: 220, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget dataCard(String label, String data, IconData? icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 15, color: Theme.of(context).disabledColor),
                SizedBox(width: 6),
              ],
              Text(
                label,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

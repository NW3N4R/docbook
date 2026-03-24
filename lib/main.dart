import 'package:docbook/Services/themeprovider.dart';
import 'package:docbook/Views/account.dart';
import 'package:docbook/Views/doctorshome.dart';
import 'package:docbook/Views/login.dart';
import 'package:docbook/Views/patientappointment.dart';
import 'package:docbook/Views/patientshome.dart';
import 'package:docbook/Views/signup.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/customWidgets/navbuttons.dart';
import 'package:docbook/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/register': (context) => Signup(),
        // '/main': (context) => Main(),
        // '/recent': (context) => RecentView(),
        // '/account': (context) => Customizations(),
        // '/post': (context) => PostItemView(),
        // '/updateProfile': (context) => AccountView(),
        // '/about': (context) => About(),
        // '/settings': (context) => Settings(),
      },
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      // locale: localeProvider.locale,
      // supportedLocales: const [Locale('en', 'US'), Locale('ar')],
      // localizationsDelegates: [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
    );
  }
}

int currentIndex = 0;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void onNavTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'DocBook -', // Use the parameter
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber[800],
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.account_circle),
        //     onPressed: () {
        //       Navigator.of(context).push(
        //         PageRouteBuilder(
        //           pageBuilder: (context, animation, secondaryAnimation) =>
        //               const AccountView(),
        //         ),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Center(),

      bottomNavigationBar: SafeArea(
        child: Currentuser.isDoctor
            ? SizedBox()
            : Row(
                mainAxisSize:
                    MainAxisSize.min, // Shrinks the Row to fit its children
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers the buttons
                children: [
                  ButtonWidget(
                    text: 'Home',
                    icon: Icons.home,
                    onPressed: () => onNavTap(0),
                    index: 0,
                    currentIndex: currentIndex,
                  ),
                  ButtonWidget(
                    text: 'List',
                    icon: Icons.schedule,
                    onPressed: () => onNavTap(1),
                    index: 1,
                    currentIndex: currentIndex,
                  ),
                ],
              ),
      ),
    );
  }
}

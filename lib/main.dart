import 'package:docbook/Services/themeprovider.dart';
import 'package:docbook/Views/account.dart';
import 'package:docbook/Views/appointmentsview.dart';
import 'package:docbook/Views/home.dart';
import 'package:docbook/Views/login.dart';
import 'package:docbook/Views/signup.dart';
import 'package:docbook/Views/updateprofile.dart';
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
        '/main': (context) => MainApp(),
        // '/account': (context) => Customizations(),
        // '/post': (context) => PostItemView(),
        '/updateProfile': (context) => UpdateProfile(),
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

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void onNavTap(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> pages = [AppointmentsView(), HomeView(), AccountView()];
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],

      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min, // Shrinks the Row to fit its children
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Centers the buttons
          children: [
            ButtonWidget(
              text: 'Appointments',
              icon: Icons.calendar_month,
              onPressed: () => onNavTap(0),
              index: 0,
              currentIndex: currentPage,
            ),
            ButtonWidget(
              text: 'Home',
              icon: Icons.home,
              onPressed: () => onNavTap(1),
              index: 1,
              currentIndex: currentPage,
            ),
            ButtonWidget(
              text: 'Account',
              icon: Icons.person,
              onPressed: () => onNavTap(2),
              index: 2,
              currentIndex: currentPage,
            ),
          ],
        ),
      ),
    );
  }
}

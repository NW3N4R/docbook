import 'package:docbook/Services/localeprovider.dart';
import 'package:docbook/Services/themeprovider.dart';
import 'package:docbook/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    String? selectedValue = localeProvider.locale.languageCode;
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(locale!.settings)),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                // color: AppThemes.getSecondaryBg(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SwitchListTile(
                title: Text(locale.darkMode),
                subtitle: Text(
                 Theme.brightnessOf(context) == Brightness.dark ? locale.dark : locale.light,
                ),
                value: Theme.brightnessOf(context) == Brightness.dark,
                onChanged: (value) {
                  setState(() {
                    themeProvider.toggleTheme(
                      value,
                    ); // 🔥 triggers AnimatedContainer
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                // color: AppThemes.getSecondaryBg(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    locale.language,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Spacer(),
                  DropdownButton<String>(
                    style: Theme.of(context).textTheme.bodyLarge,
                    underline: Container(),
                    icon: const SizedBox.shrink(),
                    value: selectedValue, // currently selected
                    items: const [
                      DropdownMenuItem(value: 'ar', child: Text('کوردی')),
                      DropdownMenuItem(value: 'en', child: Text('English')),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue == 'en') {
                        localeProvider.setEnglish();
                      } else {
                        localeProvider.setKurdish();
                      }
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

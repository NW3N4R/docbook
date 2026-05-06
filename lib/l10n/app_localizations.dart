import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @overDue.
  ///
  /// In en, this message translates to:
  /// **'Over Due'**
  String get overDue;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @actionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Action Success'**
  String get actionSuccess;

  /// No description provided for @errorHappened.
  ///
  /// In en, this message translates to:
  /// **'An Error Occurred'**
  String get errorHappened;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found'**
  String get noDataFound;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome To'**
  String get welcomeTo;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get createAnAccount;

  /// No description provided for @enterDetailsShort.
  ///
  /// In en, this message translates to:
  /// **'Please enter your details'**
  String get enterDetailsShort;

  /// No description provided for @yourSecurePassword.
  ///
  /// In en, this message translates to:
  /// **'Your Secure Password'**
  String get yourSecurePassword;

  /// No description provided for @nameHolder.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get nameHolder;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressReq.
  ///
  /// In en, this message translates to:
  /// **'Address is Required'**
  String get addressReq;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get editProfile;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @supervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor:'**
  String get supervisor;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed By:'**
  String get developedBy;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid Phone Number'**
  String get invalidPhone;

  /// No description provided for @isRequired.
  ///
  /// In en, this message translates to:
  /// **' is required'**
  String get isRequired;

  /// No description provided for @plsTypeYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Please type your full name'**
  String get plsTypeYourFullName;

  /// No description provided for @passwordisRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is Required'**
  String get passwordisRequired;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account Created'**
  String get accountCreated;

  /// No description provided for @updatesuccess.
  ///
  /// In en, this message translates to:
  /// **'Update Success'**
  String get updatesuccess;

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Delete Success'**
  String get deleteSuccess;

  /// No description provided for @actionFailure.
  ///
  /// In en, this message translates to:
  /// **'Action Failed'**
  String get actionFailure;

  /// No description provided for @yourActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t complete requested task'**
  String get yourActionFailed;

  /// No description provided for @profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profession;

  /// No description provided for @professionReq.
  ///
  /// In en, this message translates to:
  /// **'Profession is Required'**
  String get professionReq;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @imDoctor.
  ///
  /// In en, this message translates to:
  /// **'I\'m a doctor'**
  String get imDoctor;

  /// No description provided for @imDocDesc.
  ///
  /// In en, this message translates to:
  /// **'selectin this makes your account to be visible on available appointments list'**
  String get imDocDesc;

  /// No description provided for @incorrectPassOrPhone.
  ///
  /// In en, this message translates to:
  /// **'either your phone or password is incorrect'**
  String get incorrectPassOrPhone;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// No description provided for @deleteWarn.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove your profile? this action cannot be undone'**
  String get deleteWarn;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAcc.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAcc;

  /// No description provided for @updateAccount.
  ///
  /// In en, this message translates to:
  /// **'Update Account'**
  String get updateAccount;

  /// No description provided for @accountAndSettings.
  ///
  /// In en, this message translates to:
  /// **'Account & Settings'**
  String get accountAndSettings;

  /// No description provided for @docAcc.
  ///
  /// In en, this message translates to:
  /// **'your account is visible as doctor'**
  String get docAcc;

  /// No description provided for @patAcc.
  ///
  /// In en, this message translates to:
  /// **'your account is private to you'**
  String get patAcc;

  /// No description provided for @docList.
  ///
  /// In en, this message translates to:
  /// **'Doctors List'**
  String get docList;

  /// No description provided for @reqAppointMent.
  ///
  /// In en, this message translates to:
  /// **'Request Appointment'**
  String get reqAppointMent;

  /// No description provided for @docName.
  ///
  /// In en, this message translates to:
  /// **'Doctor Name'**
  String get docName;

  /// No description provided for @docAddress.
  ///
  /// In en, this message translates to:
  /// **'Doctor Address'**
  String get docAddress;

  /// No description provided for @clean.
  ///
  /// In en, this message translates to:
  /// **'Clean'**
  String get clean;

  /// No description provided for @appoDate.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date'**
  String get appoDate;

  /// No description provided for @appoDateReq.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date is Required'**
  String get appoDateReq;

  /// No description provided for @appoTime.
  ///
  /// In en, this message translates to:
  /// **'Appointment Time'**
  String get appoTime;

  /// No description provided for @appoTimeReq.
  ///
  /// In en, this message translates to:
  /// **'Appointment Time is Required'**
  String get appoTimeReq;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @nextAppointments.
  ///
  /// In en, this message translates to:
  /// **'Next Appointments'**
  String get nextAppointments;

  /// No description provided for @myAppointments.
  ///
  /// In en, this message translates to:
  /// **'My Appointments'**
  String get myAppointments;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID Number'**
  String get id;

  /// No description provided for @phoneCall.
  ///
  /// In en, this message translates to:
  /// **'Make Phone Call'**
  String get phoneCall;

  /// No description provided for @profileDetails.
  ///
  /// In en, this message translates to:
  /// **'Profile Details'**
  String get profileDetails;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

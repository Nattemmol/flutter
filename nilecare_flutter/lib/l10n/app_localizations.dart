import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_or.dart';

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
    Locale('am'),
    Locale('en'),
    Locale('or')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Nile Care'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacySettings;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get greeting;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to your dashboard'**
  String get dashboardWelcome;

  /// No description provided for @nextAppointment.
  ///
  /// In en, this message translates to:
  /// **'Next Appointment'**
  String get nextAppointment;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @highlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get highlights;

  /// No description provided for @recentHistory.
  ///
  /// In en, this message translates to:
  /// **'Recent History'**
  String get recentHistory;

  /// No description provided for @dailyCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Daily Check-In'**
  String get dailyCheckIn;

  /// No description provided for @howFeelingToday.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get howFeelingToday;

  /// No description provided for @dailyWellnessTip.
  ///
  /// In en, this message translates to:
  /// **'💡 Daily Wellness Tip'**
  String get dailyWellnessTip;

  /// No description provided for @dailyTipTitle.
  ///
  /// In en, this message translates to:
  /// **'💡 Daily Tip'**
  String get dailyTipTitle;

  /// No description provided for @healthTips.
  ///
  /// In en, this message translates to:
  /// **'Health Tips'**
  String get healthTips;

  /// No description provided for @stayHydrated.
  ///
  /// In en, this message translates to:
  /// **'Stay Hydrated'**
  String get stayHydrated;

  /// No description provided for @stayHydratedDesc.
  ///
  /// In en, this message translates to:
  /// **'Drink at least 8 glasses of water per day.'**
  String get stayHydratedDesc;

  /// No description provided for @morningWalk.
  ///
  /// In en, this message translates to:
  /// **'Morning Walk'**
  String get morningWalk;

  /// No description provided for @morningWalkDesc.
  ///
  /// In en, this message translates to:
  /// **'Start your day with a 20-minute walk.'**
  String get morningWalkDesc;

  /// No description provided for @yourWellnessScore.
  ///
  /// In en, this message translates to:
  /// **'Your Wellness Score'**
  String get yourWellnessScore;

  /// No description provided for @todaysScore.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Score'**
  String get todaysScore;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @noShow.
  ///
  /// In en, this message translates to:
  /// **'No Show'**
  String get noShow;

  /// No description provided for @drJaneSmith.
  ///
  /// In en, this message translates to:
  /// **'Dr. Jane Smith – July 25, 2:30 PM'**
  String get drJaneSmith;

  /// No description provided for @july20.
  ///
  /// In en, this message translates to:
  /// **'July 20'**
  String get july20;

  /// No description provided for @drAhmed.
  ///
  /// In en, this message translates to:
  /// **'Dr. Ahmed Ali'**
  String get drAhmed;

  /// No description provided for @july15.
  ///
  /// In en, this message translates to:
  /// **'July 15'**
  String get july15;

  /// No description provided for @drRachel.
  ///
  /// In en, this message translates to:
  /// **'Dr. Rachel Kim'**
  String get drRachel;

  /// No description provided for @july10.
  ///
  /// In en, this message translates to:
  /// **'July 10'**
  String get july10;

  /// No description provided for @drLin.
  ///
  /// In en, this message translates to:
  /// **'Dr. Lin Tao'**
  String get drLin;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @selectSpeciality.
  ///
  /// In en, this message translates to:
  /// **'Select Speciality'**
  String get selectSpeciality;

  /// No description provided for @selectDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Doctor'**
  String get selectDoctor;

  /// No description provided for @additionalNote.
  ///
  /// In en, this message translates to:
  /// **'Additional note (optional)'**
  String get additionalNote;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help?'**
  String get needHelp;

  /// No description provided for @needHelpDesc.
  ///
  /// In en, this message translates to:
  /// **'Contact our support team if you have any questions or need assistance with booking your appointment.'**
  String get needHelpDesc;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @doctorDashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Here is your dashboard overview for today.'**
  String get doctorDashboardWelcome;

  /// No description provided for @announcements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcements;

  /// No description provided for @recentPatients.
  ///
  /// In en, this message translates to:
  /// **'Recent Patients'**
  String get recentPatients;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @availabilityReminder.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to update your availability!'**
  String get availabilityReminder;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @todaysSchedule.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Schedule'**
  String get todaysSchedule;

  /// No description provided for @viewFullSchedule.
  ///
  /// In en, this message translates to:
  /// **'View Full Schedule'**
  String get viewFullSchedule;

  /// No description provided for @proTipForDoctors.
  ///
  /// In en, this message translates to:
  /// **'Pro Tip for Doctors'**
  String get proTipForDoctors;

  /// No description provided for @proTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Pro Tip'**
  String get proTipTitle;

  /// No description provided for @proTipContent.
  ///
  /// In en, this message translates to:
  /// **'Stay updated with the latest research and always document your patient notes right after each consultation.'**
  String get proTipContent;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @appointmentsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointmentsPageTitle;

  /// No description provided for @scheduleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay on top of your consultations'**
  String get scheduleSubtitle;

  /// No description provided for @appointmentsStatTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointmentsStatTitle;

  /// No description provided for @patientsStatTitle.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patientsStatTitle;

  /// No description provided for @pendingStatTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingStatTitle;

  /// No description provided for @upcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointments'**
  String get upcomingAppointments;

  /// No description provided for @helpfulTips.
  ///
  /// In en, this message translates to:
  /// **'Helpful Tips'**
  String get helpfulTips;

  /// No description provided for @tipUpdateAvailability.
  ///
  /// In en, this message translates to:
  /// **'Remember to update your availability daily.'**
  String get tipUpdateAvailability;

  /// No description provided for @tipSetFees.
  ///
  /// In en, this message translates to:
  /// **'Set consultation fees in the settings menu.'**
  String get tipSetFees;

  /// No description provided for @tipReviewRecords.
  ///
  /// In en, this message translates to:
  /// **'Review patient records before each appointment.'**
  String get tipReviewRecords;

  /// No description provided for @appointmentDay.
  ///
  /// In en, this message translates to:
  /// **'{day}'**
  String appointmentDay(Object day);

  /// No description provided for @appointmentTime.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String appointmentTime(Object time);

  /// No description provided for @appointmentPatient.
  ///
  /// In en, this message translates to:
  /// **'{patient}'**
  String appointmentPatient(Object patient);

  /// No description provided for @appointmentReason.
  ///
  /// In en, this message translates to:
  /// **'{reason}'**
  String appointmentReason(Object reason);

  /// No description provided for @appointmentDate.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String appointmentDate(Object date);

  /// No description provided for @patientsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patientsPageTitle;

  /// No description provided for @yourPatients.
  ///
  /// In en, this message translates to:
  /// **'Your Patients'**
  String get yourPatients;

  /// No description provided for @managePatientInfo.
  ///
  /// In en, this message translates to:
  /// **'Manage and view patient info'**
  String get managePatientInfo;

  /// No description provided for @activePatients.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activePatients;

  /// No description provided for @criticalPatients.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get criticalPatients;

  /// No description provided for @upcomingAppts.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appts'**
  String get upcomingAppts;

  /// No description provided for @reviewCriticalPatients.
  ///
  /// In en, this message translates to:
  /// **'Remember to review critical patients\' latest reports daily.'**
  String get reviewCriticalPatients;

  /// No description provided for @patientListTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient List'**
  String get patientListTitle;

  /// No description provided for @healthGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get healthGood;

  /// No description provided for @healthUnderObservation.
  ///
  /// In en, this message translates to:
  /// **'Under Observation'**
  String get healthUnderObservation;

  /// No description provided for @healthCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get healthCritical;

  /// No description provided for @tipsReminders.
  ///
  /// In en, this message translates to:
  /// **'Tips & Reminders'**
  String get tipsReminders;

  /// No description provided for @tipCheckHistory.
  ///
  /// In en, this message translates to:
  /// **'Always check patient history before consultation.'**
  String get tipCheckHistory;

  /// No description provided for @tipHighlightCritical.
  ///
  /// In en, this message translates to:
  /// **'Highlight critical patients in your daily review.'**
  String get tipHighlightCritical;

  /// No description provided for @tipUpdateContact.
  ///
  /// In en, this message translates to:
  /// **'Keep patient contact info updated.'**
  String get tipUpdateContact;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @lastVisit.
  ///
  /// In en, this message translates to:
  /// **'Last Visit'**
  String get lastVisit;

  /// No description provided for @nextAppt.
  ///
  /// In en, this message translates to:
  /// **'Next Appt'**
  String get nextAppt;

  /// No description provided for @availabilityPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availabilityPageTitle;

  /// No description provided for @manageYourAvailability.
  ///
  /// In en, this message translates to:
  /// **'Manage Your Availability'**
  String get manageYourAvailability;

  /// No description provided for @keepSlotsUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Keep your consultation slots up to date'**
  String get keepSlotsUpToDate;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// No description provided for @currentSlotsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Current Slots'**
  String get currentSlotsTitle;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @busy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get busy;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @tipsScheduling.
  ///
  /// In en, this message translates to:
  /// **'Tips for Better Scheduling'**
  String get tipsScheduling;

  /// No description provided for @tipUpdateSlots.
  ///
  /// In en, this message translates to:
  /// **'Update slots regularly to avoid double bookings.'**
  String get tipUpdateSlots;

  /// No description provided for @tipMorningHours.
  ///
  /// In en, this message translates to:
  /// **'Use morning hours for quick check-ups.'**
  String get tipMorningHours;

  /// No description provided for @tipMarkHolidays.
  ///
  /// In en, this message translates to:
  /// **'Mark off holidays or breaks clearly.'**
  String get tipMarkHolidays;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['am', 'en', 'or'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am': return AppLocalizationsAm();
    case 'en': return AppLocalizationsEn();
    case 'or': return AppLocalizationsOr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

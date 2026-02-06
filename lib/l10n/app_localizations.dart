import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en')
  ];

  /// Title for the more settings page
  ///
  /// In en, this message translates to:
  /// **'More Settings'**
  String get moreSettings;

  /// Section title for appearance and preferences
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE & PREFERENCES'**
  String get appearanceAndPreferences;

  /// Title for dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Premium badge text
  ///
  /// In en, this message translates to:
  /// **'PREMIUM'**
  String get premium;

  /// Title for language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English (US)'**
  String get englishUS;

  /// Bengali language option
  ///
  /// In en, this message translates to:
  /// **'বাংলা (Bengali)'**
  String get bengali;

  /// Section title for security and alerts
  ///
  /// In en, this message translates to:
  /// **'SECURITY & ALERTS'**
  String get securityAndAlerts;

  /// Title for notifications setting
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Title for privacy and data setting
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get privacyAndData;

  /// About section title
  ///
  /// In en, this message translates to:
  /// **'About PubChem Explorer'**
  String get aboutPubChemExplorer;

  /// App tagline
  ///
  /// In en, this message translates to:
  /// **'Empowering Chemical Intelligence'**
  String get empoweringChemicalIntelligence;

  /// App version text
  ///
  /// In en, this message translates to:
  /// **'VERSION 1.0.1'**
  String get version;

  /// Language dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// App name in home screen
  ///
  /// In en, this message translates to:
  /// **'PubChem Intelligence'**
  String get pubChemIntelligence;

  /// Search bar placeholder
  ///
  /// In en, this message translates to:
  /// **'Search for compounds...'**
  String get searchForCompounds;

  /// Placeholder text shown on the search screen
  ///
  /// In en, this message translates to:
  /// **'Search results will appear here'**
  String get searchScreenComingSoon;

  /// Title for recent searches section
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get searchRecentTitle;

  /// Clear search history button label
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get searchClearHistory;

  /// Placeholder when there are no recent searches
  ///
  /// In en, this message translates to:
  /// **'No recent searches yet'**
  String get searchNoRecent;

  /// Search loading label
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searchingLabel;

  /// Empty state title for search results
  ///
  /// In en, this message translates to:
  /// **'No compounds found'**
  String get searchEmptyTitle;

  /// Empty state subtitle for search results
  ///
  /// In en, this message translates to:
  /// **'Try a different name.'**
  String get searchEmptySubtitle;

  /// Error state title for search results
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get searchErrorTitle;

  /// Error state subtitle for search results
  ///
  /// In en, this message translates to:
  /// **'Please check your connection and try again.'**
  String get searchErrorSubtitle;

  /// Retry button label for search errors
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get searchRetry;

  /// Title for the compound details screen
  ///
  /// In en, this message translates to:
  /// **'Compound Details'**
  String get compoundDetailsTitle;

  /// Placeholder text shown on the compound details screen
  ///
  /// In en, this message translates to:
  /// **'Details will appear here soon'**
  String get detailsScreenComingSoon;

  /// Label for compound ID
  ///
  /// In en, this message translates to:
  /// **'CID'**
  String get compoundIdLabel;

  /// Label for molecular weight
  ///
  /// In en, this message translates to:
  /// **'MW'**
  String get molecularWeightLabel;

  /// Trending filter chip
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// Favorites filter chip
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Recent filter chip
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// Featured molecules section title
  ///
  /// In en, this message translates to:
  /// **'Featured Molecules'**
  String get featuredMolecules;

  /// Featured molecules subtitle
  ///
  /// In en, this message translates to:
  /// **'Curated chemical structures for study'**
  String get curatedChemicalStructures;

  /// See all button text
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// End of list message
  ///
  /// In en, this message translates to:
  /// **'No more items'**
  String get noMoreItems;

  /// Latest insights section title
  ///
  /// In en, this message translates to:
  /// **'Latest Insights'**
  String get latestInsights;

  /// Insight item title
  ///
  /// In en, this message translates to:
  /// **'Molecular Analysis'**
  String get molecularAnalysis;

  /// Molecular analysis subtitle
  ///
  /// In en, this message translates to:
  /// **'Real-time binding affinity predictions'**
  String get realtimeBindingAffinity;

  /// Insight item title
  ///
  /// In en, this message translates to:
  /// **'Lab Integration'**
  String get labIntegration;

  /// Lab integration subtitle
  ///
  /// In en, this message translates to:
  /// **'Sync with ELN laboratory data'**
  String get syncWithELN;

  /// 2D structure section title
  ///
  /// In en, this message translates to:
  /// **'2D Structure'**
  String get details2DStructure;

  /// Scientific representation subtitle
  ///
  /// In en, this message translates to:
  /// **'Scientific Representation'**
  String get detailsScientificRepresentation;

  /// Verified badge text
  ///
  /// In en, this message translates to:
  /// **'VERIFIED'**
  String get detailsVerified;

  /// Interactive button text
  ///
  /// In en, this message translates to:
  /// **'Interactive'**
  String get detailsInteractive;

  /// Chemical properties section title
  ///
  /// In en, this message translates to:
  /// **'Chemical Properties'**
  String get detailsChemicalProperties;

  /// Molecular formula label
  ///
  /// In en, this message translates to:
  /// **'MOLECULAR FORMULA'**
  String get detailsMolecularFormula;

  /// Molecular weight label
  ///
  /// In en, this message translates to:
  /// **'MOLECULAR WEIGHT'**
  String get detailsMolecularWeight;

  /// IUPAC name label
  ///
  /// In en, this message translates to:
  /// **'IUPAC NAME'**
  String get detailsIupacName;

  /// Solubility label (XLogP)
  ///
  /// In en, this message translates to:
  /// **'SOLUBILITY AA'**
  String get detailsSolubility;

  /// TPSA label
  ///
  /// In en, this message translates to:
  /// **'TPSA'**
  String get detailsTpsa;

  /// Description section title
  ///
  /// In en, this message translates to:
  /// **'DESCRIPTION'**
  String get detailsDescription;

  /// Physical properties section title
  ///
  /// In en, this message translates to:
  /// **'PHYSICAL PROPERTIES'**
  String get detailsPhysicalProperties;

  /// Add to collection button text
  ///
  /// In en, this message translates to:
  /// **'Add to Collection'**
  String get detailsAddToCollection;

  /// Error loading details message
  ///
  /// In en, this message translates to:
  /// **'Error loading compound details'**
  String get detailsLoadingError;

  /// No data available message
  ///
  /// In en, this message translates to:
  /// **'No compound data available'**
  String get detailsNoData;

  /// Not available placeholder
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get detailsNotAvailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

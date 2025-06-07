import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generate/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ja, this message translates to:
  /// **'学生管理'**
  String get appTitle;

  /// No description provided for @lblTheme.
  ///
  /// In ja, this message translates to:
  /// **'テーマの変更'**
  String get lblTheme;

  /// The name of the application
  ///
  /// In ja, this message translates to:
  /// **'学生管理'**
  String get appName;

  /// Welcome back message on login screen
  ///
  /// In ja, this message translates to:
  /// **'おかえりなさい！'**
  String get welcomeBack;

  /// Sign in message on login screen
  ///
  /// In ja, this message translates to:
  /// **'サインインして続行してください'**
  String get pleaseSignIn;

  /// Email label
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス'**
  String get email;

  /// Email hint text
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスを入力してください'**
  String get enterEmail;

  /// Password label
  ///
  /// In ja, this message translates to:
  /// **'パスワード'**
  String get password;

  /// Password hint text
  ///
  /// In ja, this message translates to:
  /// **'パスワードを入力してください'**
  String get enterPassword;

  /// Sign in button text
  ///
  /// In ja, this message translates to:
  /// **'サインイン'**
  String get signIn;

  /// Forgot password link text
  ///
  /// In ja, this message translates to:
  /// **'パスワードをお忘れですか？'**
  String get forgotPassword;

  /// Login success message
  ///
  /// In ja, this message translates to:
  /// **'ログインに成功しました'**
  String get loginSuccess;

  /// Email validation message
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスを入力してください'**
  String get pleaseEnterEmail;

  /// Email format validation message
  ///
  /// In ja, this message translates to:
  /// **'有効なメールアドレスを入力してください'**
  String get pleaseEnterValidEmail;

  /// Password validation message
  ///
  /// In ja, this message translates to:
  /// **'パスワードを入力してください'**
  String get pleaseEnterPassword;

  /// Password length validation message
  ///
  /// In ja, this message translates to:
  /// **'パスワードは6文字以上である必要があります'**
  String get passwordMinLength;

  /// No description provided for @studentList.
  ///
  /// In ja, this message translates to:
  /// **'生徒一覧'**
  String get studentList;

  /// No description provided for @noStudentsFound.
  ///
  /// In ja, this message translates to:
  /// **'生徒が見つかりません'**
  String get noStudentsFound;

  /// No description provided for @addNewStudent.
  ///
  /// In ja, this message translates to:
  /// **'新しい生徒を追加'**
  String get addNewStudent;

  /// No description provided for @studentId.
  ///
  /// In ja, this message translates to:
  /// **'学籍番号'**
  String get studentId;

  /// No description provided for @className.
  ///
  /// In ja, this message translates to:
  /// **'クラス'**
  String get className;

  /// No description provided for @deleteStudent.
  ///
  /// In ja, this message translates to:
  /// **'生徒を削除'**
  String get deleteStudent;

  /// No description provided for @deleteStudentConfirm.
  ///
  /// In ja, this message translates to:
  /// **'この生徒を削除してもよろしいですか？'**
  String get deleteStudentConfirm;

  /// No description provided for @cancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In ja, this message translates to:
  /// **'削除'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ja, this message translates to:
  /// **'編集'**
  String get edit;

  /// No description provided for @name.
  ///
  /// In ja, this message translates to:
  /// **'名前'**
  String get name;

  /// No description provided for @enterName.
  ///
  /// In ja, this message translates to:
  /// **'生徒の名前を入力してください'**
  String get enterName;

  /// No description provided for @pleaseEnterName.
  ///
  /// In ja, this message translates to:
  /// **'生徒の名前を入力してください'**
  String get pleaseEnterName;

  /// No description provided for @enterStudentId.
  ///
  /// In ja, this message translates to:
  /// **'学籍番号を入力してください'**
  String get enterStudentId;

  /// No description provided for @pleaseEnterStudentId.
  ///
  /// In ja, this message translates to:
  /// **'学籍番号を入力してください'**
  String get pleaseEnterStudentId;

  /// No description provided for @enterClassName.
  ///
  /// In ja, this message translates to:
  /// **'クラス名を入力してください'**
  String get enterClassName;

  /// No description provided for @pleaseEnterClassName.
  ///
  /// In ja, this message translates to:
  /// **'クラス名を入力してください'**
  String get pleaseEnterClassName;

  /// No description provided for @phone.
  ///
  /// In ja, this message translates to:
  /// **'電話番号'**
  String get phone;

  /// No description provided for @enterPhone.
  ///
  /// In ja, this message translates to:
  /// **'電話番号を入力してください'**
  String get enterPhone;

  /// No description provided for @pleaseEnterValidPhone.
  ///
  /// In ja, this message translates to:
  /// **'有効な電話番号を入力してください'**
  String get pleaseEnterValidPhone;

  /// No description provided for @address.
  ///
  /// In ja, this message translates to:
  /// **'住所'**
  String get address;

  /// No description provided for @enterAddress.
  ///
  /// In ja, this message translates to:
  /// **'住所を入力してください'**
  String get enterAddress;

  /// No description provided for @selectDateOfBirth.
  ///
  /// In ja, this message translates to:
  /// **'生年月日を選択してください'**
  String get selectDateOfBirth;

  /// No description provided for @save.
  ///
  /// In ja, this message translates to:
  /// **'保存'**
  String get save;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

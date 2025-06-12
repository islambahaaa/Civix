// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Connection Timeout`
  String get connection_timeout {
    return Intl.message(
      'Connection Timeout',
      name: 'connection_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Send Timeout`
  String get send_timeout {
    return Intl.message(
      'Send Timeout',
      name: 'send_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Receive Timeout`
  String get receive_timeout {
    return Intl.message(
      'Receive Timeout',
      name: 'receive_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Connection Cancelled`
  String get connection_cancelled {
    return Intl.message(
      'Connection Cancelled',
      name: 'connection_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `NO INTERNET CONNECTION`
  String get no_internet {
    return Intl.message(
      'NO INTERNET CONNECTION',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error, Please try again!`
  String get unexpected_error {
    return Intl.message(
      'Unexpected Error, Please try again!',
      name: 'unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again!`
  String get something_wrong {
    return Intl.message(
      'Something went wrong. Please try again!',
      name: 'something_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Your request not found. Please try again!`
  String get not_found {
    return Intl.message(
      'Your request not found. Please try again!',
      name: 'not_found',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server Error. Please try again!`
  String get server_error {
    return Intl.message(
      'Internal Server Error. Please try again!',
      name: 'server_error',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get success {
    return Intl.message(
      'Success!',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congrats {
    return Intl.message(
      'Congratulations!',
      name: 'congrats',
      desc: '',
      args: [],
    );
  }

  /// `Password Reset Successful\nYou’ll be redirected to the login screen now`
  String get password_reset {
    return Intl.message(
      'Password Reset Successful\nYou’ll be redirected to the login screen now',
      name: 'password_reset',
      desc: '',
      args: [],
    );
  }

  /// `Are You Sure!`
  String get are_you_sure {
    return Intl.message(
      'Are You Sure!',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logout_confirm {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password ?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `This Field is required`
  String get required_field {
    return Intl.message(
      'This Field is required',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get valid_email {
    return Intl.message(
      'Enter a valid email',
      name: 'valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 character`
  String get min_chars {
    return Intl.message(
      'At least 8 character',
      name: 'min_chars',
      desc: '',
      args: [],
    );
  }

  /// `1 Uppercase letter`
  String get uppercase {
    return Intl.message(
      '1 Uppercase letter',
      name: 'uppercase',
      desc: '',
      args: [],
    );
  }

  /// `1 Numeric character`
  String get numeric {
    return Intl.message(
      '1 Numeric character',
      name: 'numeric',
      desc: '',
      args: [],
    );
  }

  /// `1 Special character`
  String get special_char {
    return Intl.message(
      '1 Special character',
      name: 'special_char',
      desc: '',
      args: [],
    );
  }

  /// `Lower Case`
  String get lowercase {
    return Intl.message(
      'Lower Case',
      name: 'lowercase',
      desc: '',
      args: [],
    );
  }

  /// `Normal Letters`
  String get normal_letters {
    return Intl.message(
      'Normal Letters',
      name: 'normal_letters',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Where would you like to receive a Verification Code ?`
  String get verification_code {
    return Intl.message(
      'Where would you like to receive a Verification Code ?',
      name: 'verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get send_code {
    return Intl.message(
      'Send Code',
      name: 'send_code',
      desc: '',
      args: [],
    );
  }

  /// `Already Have an Account?`
  String get have_account {
    return Intl.message(
      'Already Have an Account?',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Create a New Password`
  String get new_password {
    return Intl.message(
      'Create a New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get password_mismatch {
    return Intl.message(
      'Password does not match',
      name: 'password_mismatch',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to your email`
  String get enter_code {
    return Intl.message(
      'Enter the code sent to your email',
      name: 'enter_code',
      desc: '',
      args: [],
    );
  }

  /// `Did not receive the code?`
  String get no_code {
    return Intl.message(
      'Did not receive the code?',
      name: 'no_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend code in `
  String get resend_code {
    return Intl.message(
      'Resend code in ',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds_left {
    return Intl.message(
      'seconds',
      name: 'seconds_left',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resend {
    return Intl.message(
      'Resend Code',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Otp must be 6 digits`
  String get otp_digits {
    return Intl.message(
      'Otp must be 6 digits',
      name: 'otp_digits',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgot_pass {
    return Intl.message(
      'Forgot your password?',
      name: 'forgot_pass',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Password is not strong enough`
  String get weak_password {
    return Intl.message(
      'Password is not strong enough',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `Please accept terms and conditions`
  String get accept_terms {
    return Intl.message(
      'Please accept terms and conditions',
      name: 'accept_terms',
      desc: '',
      args: [],
    );
  }

  /// `By clicking Sign up, you Agree to our `
  String get agree_terms {
    return Intl.message(
      'By clicking Sign up, you Agree to our ',
      name: 'agree_terms',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get terms {
    return Intl.message(
      'Terms',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Conditions`
  String get conditions {
    return Intl.message(
      'Conditions',
      name: 'conditions',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Solved Issues`
  String get solved_issues {
    return Intl.message(
      'Solved Issues',
      name: 'solved_issues',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Hello,`
  String get hello {
    return Intl.message(
      'Hello,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `No user data.`
  String get no_user_data {
    return Intl.message(
      'No user data.',
      name: 'no_user_data',
      desc: '',
      args: [],
    );
  }

  /// `Previous Submissions`
  String get prev_submissions {
    return Intl.message(
      'Previous Submissions',
      name: 'prev_submissions',
      desc: '',
      args: [],
    );
  }

  /// `a pothole in the main street`
  String get pothole_example {
    return Intl.message(
      'a pothole in the main street',
      name: 'pothole_example',
      desc: '',
      args: [],
    );
  }

  /// `Jan 4,2022`
  String get date_example {
    return Intl.message(
      'Jan 4,2022',
      name: 'date_example',
      desc: '',
      args: [],
    );
  }

  /// `Giza`
  String get giza {
    return Intl.message(
      'Giza',
      name: 'giza',
      desc: '',
      args: [],
    );
  }

  /// `Solved`
  String get solved {
    return Intl.message(
      'Solved',
      name: 'solved',
      desc: '',
      args: [],
    );
  }

  /// `street light problem`
  String get street_light {
    return Intl.message(
      'street light problem',
      name: 'street_light',
      desc: '',
      args: [],
    );
  }

  /// `Feb 6,2023`
  String get date_example_2 {
    return Intl.message(
      'Feb 6,2023',
      name: 'date_example_2',
      desc: '',
      args: [],
    );
  }

  /// `New Cairo`
  String get new_cairo {
    return Intl.message(
      'New Cairo',
      name: 'new_cairo',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get in_progress {
    return Intl.message(
      'In Progress',
      name: 'in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Jan 12,2024`
  String get date_example_3 {
    return Intl.message(
      'Jan 12,2024',
      name: 'date_example_3',
      desc: '',
      args: [],
    );
  }

  /// `Alexandria`
  String get alexandria {
    return Intl.message(
      'Alexandria',
      name: 'alexandria',
      desc: '',
      args: [],
    );
  }

  /// `Denied`
  String get denied {
    return Intl.message(
      'Denied',
      name: 'denied',
      desc: '',
      args: [],
    );
  }

  /// `Water leak`
  String get water_leak {
    return Intl.message(
      'Water leak',
      name: 'water_leak',
      desc: '',
      args: [],
    );
  }

  /// `Maadi`
  String get maadi {
    return Intl.message(
      'Maadi',
      name: 'maadi',
      desc: '',
      args: [],
    );
  }

  /// `A broken Street`
  String get broken_street {
    return Intl.message(
      'A broken Street',
      name: 'broken_street',
      desc: '',
      args: [],
    );
  }

  /// `Al Shorouk`
  String get al_shorouk {
    return Intl.message(
      'Al Shorouk',
      name: 'al_shorouk',
      desc: '',
      args: [],
    );
  }

  /// `Solved\nIn My Area`
  String get solved_area {
    return Intl.message(
      'Solved\nIn My Area',
      name: 'solved_area',
      desc: '',
      args: [],
    );
  }

  /// `Solved In My Area`
  String get solved_area_ab {
    return Intl.message(
      'Solved In My Area',
      name: 'solved_area_ab',
      desc: '',
      args: [],
    );
  }

  /// `Report your issues from the comfort of your own house`
  String get report_from_home {
    return Intl.message(
      'Report your issues from the comfort of your own house',
      name: 'report_from_home',
      desc: '',
      args: [],
    );
  }

  /// `COMFORT`
  String get comfort {
    return Intl.message(
      'COMFORT',
      name: 'comfort',
      desc: '',
      args: [],
    );
  }

  /// `Providing you with the trusted authorities to fix your issues `
  String get trusted_fix {
    return Intl.message(
      'Providing you with the trusted authorities to fix your issues ',
      name: 'trusted_fix',
      desc: '',
      args: [],
    );
  }

  /// `TRUST`
  String get trust {
    return Intl.message(
      'TRUST',
      name: 'trust',
      desc: '',
      args: [],
    );
  }

  /// `Create a safe and peaceful neighborhood`
  String get safe_neighborhood {
    return Intl.message(
      'Create a safe and peaceful neighborhood',
      name: 'safe_neighborhood',
      desc: '',
      args: [],
    );
  }

  /// `SAFETY`
  String get safety {
    return Intl.message(
      'SAFETY',
      name: 'safety',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Notification `
  String get notification_settings {
    return Intl.message(
      'Notification ',
      name: 'notification_settings',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobile_number {
    return Intl.message(
      'Mobile Number',
      name: 'mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Select Theme`
  String get select_theme {
    return Intl.message(
      'Select Theme',
      name: 'select_theme',
      desc: '',
      args: [],
    );
  }

  /// `System Default`
  String get system_default {
    return Intl.message(
      'System Default',
      name: 'system_default',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Location permission is required to access your location.`
  String get location_permission {
    return Intl.message(
      'Location permission is required to access your location.',
      name: 'location_permission',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch location: `
  String get location_error {
    return Intl.message(
      'Failed to fetch location: ',
      name: 'location_error',
      desc: '',
      args: [],
    );
  }

  /// `GPS is disabled. Please enable it to fetch your location.`
  String get gps_disabled {
    return Intl.message(
      'GPS is disabled. Please enable it to fetch your location.',
      name: 'gps_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Please provide images`
  String get provide_images {
    return Intl.message(
      'Please provide images',
      name: 'provide_images',
      desc: '',
      args: [],
    );
  }

  /// `Gallery permission denied`
  String get gallery_denied {
    return Intl.message(
      'Gallery permission denied',
      name: 'gallery_denied',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get location. Please try again.`
  String get location_fail {
    return Intl.message(
      'Failed to get location. Please try again.',
      name: 'location_fail',
      desc: '',
      args: [],
    );
  }

  /// `Please Login First`
  String get login_first {
    return Intl.message(
      'Please Login First',
      name: 'login_first',
      desc: '',
      args: [],
    );
  }

  /// `Image size must be less than 5 MB`
  String get image_size_limit {
    return Intl.message(
      'Image size must be less than 5 MB',
      name: 'image_size_limit',
      desc: '',
      args: [],
    );
  }

  /// `You have already selected this image.`
  String get image_selected {
    return Intl.message(
      'You have already selected this image.',
      name: 'image_selected',
      desc: '',
      args: [],
    );
  }

  /// `exceeds 5 MB`
  String get image_exceeds {
    return Intl.message(
      'exceeds 5 MB',
      name: 'image_exceeds',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of images reached`
  String get max_images {
    return Intl.message(
      'Maximum number of images reached',
      name: 'max_images',
      desc: '',
      args: [],
    );
  }

  /// `Failed to pick images: `
  String get image_pick_fail {
    return Intl.message(
      'Failed to pick images: ',
      name: 'image_pick_fail',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission denied`
  String get camera_denied {
    return Intl.message(
      'Camera permission denied',
      name: 'camera_denied',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get take_photo {
    return Intl.message(
      'Take Photo',
      name: 'take_photo',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get choose_gallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'choose_gallery',
      desc: '',
      args: [],
    );
  }

  /// `images selected`
  String get images_selected {
    return Intl.message(
      'images selected',
      name: 'images_selected',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Pothole`
  String get pothole {
    return Intl.message(
      'Pothole',
      name: 'pothole',
      desc: '',
      args: [],
    );
  }

  /// `Garbage`
  String get garbage {
    return Intl.message(
      'Garbage',
      name: 'garbage',
      desc: '',
      args: [],
    );
  }

  /// `Broken Streetlight`
  String get broken_streetlight {
    return Intl.message(
      'Broken Streetlight',
      name: 'broken_streetlight',
      desc: '',
      args: [],
    );
  }

  /// `Manhole`
  String get manhole {
    return Intl.message(
      'Manhole',
      name: 'manhole',
      desc: '',
      args: [],
    );
  }

  /// `Flooding`
  String get flooding {
    return Intl.message(
      'Flooding',
      name: 'flooding',
      desc: '',
      args: [],
    );
  }

  /// `Grafitti`
  String get graffiti {
    return Intl.message(
      'Grafitti',
      name: 'graffiti',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Report submitted successfully.`
  String get report_submitted {
    return Intl.message(
      'Report submitted successfully.',
      name: 'report_submitted',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get fill_fields {
    return Intl.message(
      'Please fill all fields',
      name: 'fill_fields',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Report Details`
  String get report_details {
    return Intl.message(
      'Report Details',
      name: 'report_details',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `You are not authorized , please login again`
  String get not_authorized {
    return Intl.message(
      'You are not authorized , please login again',
      name: 'not_authorized',
      desc: '',
      args: [],
    );
  }

  /// `Select Issue Type`
  String get issue_type {
    return Intl.message(
      'Select Issue Type',
      name: 'issue_type',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get mark_all_as_read {
    return Intl.message(
      'Mark all as read',
      name: 'mark_all_as_read',
      desc: '',
      args: [],
    );
  }

  /// `Notification dismissed`
  String get notification_dismissed {
    return Intl.message(
      'Notification dismissed',
      name: 'notification_dismissed',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get just_now {
    return Intl.message(
      'Just now',
      name: 'just_now',
      desc: '',
      args: [],
    );
  }

  /// `min ago`
  String get minutes_ago {
    return Intl.message(
      'min ago',
      name: 'minutes_ago',
      desc: '',
      args: [],
    );
  }

  /// `hr ago`
  String get hours_ago {
    return Intl.message(
      'hr ago',
      name: 'hours_ago',
      desc: '',
      args: [],
    );
  }

  /// `d ago`
  String get days_ago {
    return Intl.message(
      'd ago',
      name: 'days_ago',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `See Location`
  String get see_location {
    return Intl.message(
      'See Location',
      name: 'see_location',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get re_enter_your_password {
    return Intl.message(
      'Re-enter your password',
      name: 're_enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid Egyptian phone number`
  String get egyptian_phone_number {
    return Intl.message(
      'Enter a valid Egyptian phone number',
      name: 'egyptian_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verifyEmailTitle {
    return Intl.message(
      'Verify Email',
      name: 'verifyEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `We've sent a confirmation link to your email address.\nPlease check your inbox and click the link to verify your account.`
  String get verifyEmailMessage {
    return Intl.message(
      'We\'ve sent a confirmation link to your email address.\nPlease check your inbox and click the link to verify your account.',
      name: 'verifyEmailMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get select_location {
    return Intl.message(
      'Select Location',
      name: 'select_location',
      desc: '',
      args: [],
    );
  }

  /// `Pick Location`
  String get pick_location {
    return Intl.message(
      'Pick Location',
      name: 'pick_location',
      desc: '',
      args: [],
    );
  }

  /// `Zoom In to Select Location`
  String get zoom_in_to_select {
    return Intl.message(
      'Zoom In to Select Location',
      name: 'zoom_in_to_select',
      desc: '',
      args: [],
    );
  }

  /// `Use Current Location`
  String get use_current_location {
    return Intl.message(
      'Use Current Location',
      name: 'use_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Search city or area`
  String get search_city {
    return Intl.message(
      'Search city or area',
      name: 'search_city',
      desc: '',
      args: [],
    );
  }

  /// `Choose a category`
  String get choose_a_category {
    return Intl.message(
      'Choose a category',
      name: 'choose_a_category',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message(
      'Contact Us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
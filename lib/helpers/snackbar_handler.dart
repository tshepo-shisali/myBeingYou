import 'package:flutter/material.dart';

class SnackBars {
  static SnackBar snackBar(String content) {
    return SnackBar(content: Text(content));
  }

  // --------------------------- Common Utils ---------------------------
  static copiedToClipboard() {
    return snackBar('Copied to clipboard');
  }

  // --------------------------- Confirm Location ---------------------------
  static addressEmpty() {
    return snackBar('Address cannot be empty');
  }

  // --------------------------- Professional Info ---------------------------
  static recentJobTitleEmpty() {
    return snackBar('Recent job title cannot be empty');
  }

  static recentCompanyEmpty() {
    return snackBar('Recent company cannot be empty');
  }

  static degreeTypeEmpty() {
    return snackBar('Degree type cannot be empty');
  }

  static schoolNameEmpty() {
    return snackBar('School name cannot be empty');
  }

  static hasNoTherapist() {
    return snackBar('You dont have a therapist , please request a therapist in profile');
  }

  static hasTherapist() {
    return snackBar('You already have a therapist');
  }

  static youAreATherapist() {
    return snackBar('Therapists cant request');
  }
  static requestDone() {
    return snackBar('You can now chat with your new therapist');
  }

    // --------------------------- Scheduled Meetings ---------------------------
  static joinMeetingTooEarly() {
    return snackBar(
        'The video meeting has not started yet. Please join at the scheduled time.');
  }

  //--------------------------- Email Validations---------------------------

}
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}




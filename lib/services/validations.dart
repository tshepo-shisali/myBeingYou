// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_project/helpers/snackbar_handler.dart';
import 'package:school_project/requests/firebase_data.dart';
import 'package:school_project/stores/user_store.dart';

// --------------------------- Confirm Location ---------------------------
bool checkAddressEmpty(String address, BuildContext context) {
  if (address.isEmpty) {
    // Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.addressEmpty());
    return false;
  }
  return true;
}

// --------------------------- Professional Info ---------------------------
bool checkValidStudentDetails(
    TextEditingController degreeTypeController,
    TextEditingController graduationYearController,
    TextEditingController schoolNameController,
    BuildContext context) {
  if (degreeTypeController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.degreeTypeEmpty());
    return false;
  } else if (schoolNameController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.schoolNameEmpty());
    return false;
  }
  return true;
}

bool checkValidJobDetails(
    TextEditingController jobTitleController,
    TextEditingController employmentTypeController,
    TextEditingController recentCompanyController,
    BuildContext context) {
  if (jobTitleController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.recentJobTitleEmpty());
    return false;
  } else if (recentCompanyController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.recentCompanyEmpty());
    return false;
  }
  return true;
}

bool checkValidTherapist(bool hasTherapist, BuildContext context){
  if(hasTherapist == false){
     ScaffoldMessenger.of(context).showSnackBar(SnackBars.hasNoTherapist());
    return false;
  }
  return true;
}

bool requestingTherapist(bool hasTherapist, BuildContext context){
   UserStore userStore = Provider.of<UserStore>(context, listen: false);
  if(hasTherapist == false){
     ScaffoldMessenger.of(context).showSnackBar(SnackBars.requestDone());
    userStore.setUserLookingForJob(true);
    setStudentFirestore(userStore.user);
    return false;
  }else if(hasTherapist == true){
     ScaffoldMessenger.of(context).showSnackBar(SnackBars.hasTherapist());
    return false;
  }
  return true;
}

bool isTherapist(bool isTherapist, BuildContext context){
  if(isTherapist == false){
     ScaffoldMessenger.of(context).showSnackBar(SnackBars.hasNoTherapist());
    return false;
  }
  return true;
}



// --------------------------- Schedule meeting ---------------------------
bool checkIfTimeInPast(TimeOfDay timeOfDay) {
  double toDouble(TimeOfDay timeOfDay) =>
      timeOfDay.hour + timeOfDay.minute / 60.0;
  if (toDouble(timeOfDay) < toDouble(TimeOfDay.now())) {
    return true;
  } else {
    return false;
  }
}

bool checkIfJoinMeetingTooEarly(
    String date, String time, BuildContext context) {
  DateTime meetingDate = DateFormat('yMMMd').parse(date);
  DateTime meetingTime = DateFormat('jm').parse(time);

  DateTime meetingDateTime = DateTime(meetingDate.year, meetingDate.month,
      meetingDate.day, meetingTime.hour, meetingTime.minute);

  DateTime currentTime = DateTime.now();
  final diffMinutes = currentTime.difference(meetingDateTime).inMinutes;

  if (diffMinutes > -5) {
    return false;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBars.joinMeetingTooEarly());
    return true;
  }
}


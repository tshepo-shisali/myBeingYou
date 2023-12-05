// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unnecessary_import


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_project/bottom.dart';
import 'package:school_project/requests/firebase_data.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/screens/looking_for_therapist.dart';

import 'package:school_project/services/validations.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:school_project/widgets/professional_info/dropform.dart';
import 'package:school_project/widgets/professional_info/job_form.dart';
import 'package:provider/provider.dart';

class ProfessionalInfo extends StatefulWidget {
  const ProfessionalInfo({Key? key}) : super(key: key);
  static String id = 'professional-info-dropdown';

  @override
  State<ProfessionalInfo> createState() => _ProfessionalInfoState();
}

class _ProfessionalInfoState extends State<ProfessionalInfo> {




  // Employment type
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController employmentTypeController = TextEditingController();
  TextEditingController recentCompanyController = TextEditingController();

  // Student type
  TextEditingController degreeTypeController = TextEditingController();
  TextEditingController graduationYearController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();

   late String id;
  late bool isStudent;
    

  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
    id = userStore.user.uid?? 'testing';
    isStudent = userStore.user.isStudent?? true;
    setUserDataInFirestore(userStore.user);
    
    //  student = userStore.user.isStudent?? true;
     
     if(id == 'testing'){
       Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushNamed(context, Login.id);
    });
        
     }
     
    super.initState();
  }

  void onPressedHandler() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
    
    if (isStudent) {
      bool next = checkValidStudentDetails(degreeTypeController,
          graduationYearController, schoolNameController, context);
      userStore.setUserStudentDetails(degreeTypeController.text,
          graduationYearController.text, schoolNameController.text);
      if (next) {
        setStudentFirestore(userStore.user);
        Navigator.pushNamed(context, LookingForTherapist.id);
      }
    } else {
      bool next = checkValidJobDetails(jobTitleController,
          employmentTypeController, recentCompanyController, context);
      userStore.setUserJobDetails(jobTitleController.text,
          employmentTypeController.text, recentCompanyController.text);
      if (next) {
        
        setTherapistFirestore(userStore.user);
        userStore.setUserLookingForJob(true);
        setUserDataInFirestore(userStore.user);
        Navigator.pushNamed(context, BottomNavigationPage.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    Widget professionalInfoForm = isStudent
        ? StudentDropDown(
            degreeTypeController: degreeTypeController,
            graduationYearController: graduationYearController,
            schoolNameController: schoolNameController)
        : JobForm(
            jobTitleController: jobTitleController,
            employmentTypeController: employmentTypeController,
            recentCompanyController: recentCompanyController);

            

    return Scaffold(
      body: Container(
         width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8 , 1),
            colors: <Color> [
              Color(0xff050729),
              Color(0xff0b1060),
              Color(0xff0e157c),
              Color(0xff111a97),
              Color(0xff434eea),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
               height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical -
                    40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const SizedBox(height: 50),
                  Text(
                      'Your profile helps us discover people right for you',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white,)),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        isStudent ? "Student" : "Therapist",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(

                    child: SizedBox(
                      height: 900,
                      child: SingleChildScrollView(
                        child: professionalInfoForm,
                        ),
                    ),
                      ),
          
                  
                  ElevatedButton(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: () => onPressedHandler(),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



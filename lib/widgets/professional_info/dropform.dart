// ignore: import_of_legacy_library_into_null_safe
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';

class JobDropDown extends StatefulWidget {
  final TextEditingController jobTitleController,
      employmentTypeController,
      recentCompanyController;
  const JobDropDown({Key? key, required this.jobTitleController, required this.employmentTypeController, required this.recentCompanyController}) : super(key: key);

  @override
  State<JobDropDown> createState() => _JobDropDownState();
}

class _JobDropDownState extends State<JobDropDown> {
  List<String> items = ['mine', 'two'];
  String selectedjobTitleController = '';
  String selectedEmploymentTypeController = '';
  String selectedRecentCompanyController = '';

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          thedropdown('Most recent job title*', items,
           (value) { 
            setState(() {
              selectedjobTitleController = value;
            });
           },
            widget.jobTitleController,
             context
            ),
          thedropdown('Employment type', items,
           (value) { 
            setState(() {
              selectedEmploymentTypeController = value;
            });
           },
            widget.employmentTypeController,
             context),
          thedropdown('Most recent company*', items,
           (value) { 
            setState(() {
              selectedRecentCompanyController = value;
            });
           },
            widget.recentCompanyController,
             context)
            
        ],
    );
  }
}


class StudentDropDown extends StatefulWidget {
  final TextEditingController degreeTypeController,
      graduationYearController,
      schoolNameController;
  const StudentDropDown({Key? key, required this.degreeTypeController, required this.graduationYearController, required this.schoolNameController}) : super(key: key);

  @override
  State<StudentDropDown> createState() => _StudentDropDownState();
}

class _StudentDropDownState extends State<StudentDropDown> {
  List<String> degreeItems = [
  'BCom in Human Resource', 'BA IN CRIMINOLOGY',
  'BCom in Business Magagement','Bachelor of medicine and Surgery',
  'BCom in Administation','BPharm',
  'Bachelor of law','BOptom',
  'BSc in life science','BSc in dietetics',
  'BSc in Mathematical science','BSc inwater and sanitation',
  'BSc in Agricultural Science(plant.','BSc in geology',
  'BSc in Soil Science', 'BCom in Human Resource',
  'BA in media','BEd in senior and FET teaching',
  'BEd in foundation Phase',
  'BCom in animal production','BSc in Physical science',
  'BNurs','Bechelor of psychology',
  'BSW','BInfo',
  
  ];

   List<String> graduationItems = [
    '2022', '2023','2024','2025','2026','2027','2028',
   ];
   List<String> schoolItems = [
    'University of Limpopo',
   ];

  String selectedDegreeTypeController = '';
  String selectedGraduationYearController = '';
  String selectedSchoolNameController = '';

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          thedropdown('Degree type*', degreeItems,
           (value) { 
            setState(() {
              selectedDegreeTypeController = value;
            });
           },
            widget.degreeTypeController,
             context
            ),
          thedropdown('Graduation year', graduationItems,
           (value) { 
            setState(() {
              selectedGraduationYearController = value;
            });
           },
            widget.graduationYearController,
             context),
          thedropdown('School name*', schoolItems,
           (value) { 
            setState(() {
              selectedSchoolNameController = value;
            });
           },
            widget.schoolNameController,
             context),
             
            
        ],
      
    );
  }
}


Widget thedropdown(
    String title,List<String> items,void Function(dynamic) onValueChanged, TextEditingController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        DropDownField(
          labelText: title,
          controller: controller,
          items: items,
          enabled: true,
          onValueChanged: onValueChanged,
          
        ),
      ],
    ),
  );
}

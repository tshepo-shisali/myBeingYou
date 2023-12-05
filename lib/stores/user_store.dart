import 'package:school_project/models/user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  // Note that the below user is from our model and not Firebase
  @observable
  User user = User();

  @action
  setUserPersonalDetails(String name, String email, String uid) {
    user.name = name;
    user.email = email;
    user.uid = uid;
  }

  @action
  setUserAddressAndLocation(String address) {
    user.address = address;
    
  }
   @action
  setPeerId(String peerId) {
    user.peerId = peerId;
    
  }
  @action
  setPeerName(String peerName) {
    user.peerName = peerName;
    
  }

  setStudentOrTherapist(bool isStudentOrTherapist) {
    user.isStudent = isStudentOrTherapist;
    
  }

  @action
  setUserStudentDetails(String degreeType, String gradYear, String schoolName) {
    user.isStudent = true;
    user.degreeType = degreeType;
    user.gradYear = gradYear;
    user.schoolName = schoolName;
  }

  @action
  setUserJobDetails(
      String jobTitle, String employmentType, String recentCompany) {
    user.isStudent = user.isStudent ?? false;
    user.jobTitle = jobTitle;
    user.employmentType = employmentType;
    user.recentCompany = recentCompany;
  }

  @action
  setUserLookingForJob(bool isLookingForJob) {
    user.isLookingForJob = isLookingForJob;
  }
}

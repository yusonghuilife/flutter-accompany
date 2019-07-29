import 'package:scoped_model/scoped_model.dart';

class ProjectModel extends Model{
  String _loginMobile = '';
  String _loginPass = '';

  String _patientRegisterName = '';
  String _patientRegisterId = '';
  String _patientRegisterMobile = '';
  String _patientRegisterConfirmCode = '';
  String _patientRegisterPass = '';
  String _patientRegisterRePass = '';

  String _doctorRegisterName = '';
  String _doctorRegisterId = '';
  String _doctorRegisterMobile = '';
  String _doctorRegisterConfirmCode = '';
  String _doctorRegisterCompany = '';
  String _doctorRegisterCompanyId = '';
  String _doctorRegisterCompanyLevel = '';
  String _doctorRegisterIntro = '';
  String _doctorRegisterPass = '';
  String _doctorRegisterRePass = '';


  String addPatientName = '';
  String addPatientGender = '';
  String addPatientAge = '';
  String addPatientMobile = '';
  String addPatientNowIll = '';
  String addPatientMarried = '';
  String addPatientOccupation = '';
  String addPatientNation = '';
  String addPatientProvince = '';
  String addPatientAddress = '';
  String addPatientId = '';
  String addPatientContactId = '';
  String addPatientIllness = '';
  String addPatientPassIllness = '';
  String addPatientReTreatmentTime = '';
  String addPatientTreatmentMethod = '';
  String addPatientProcedure = '';

  String patientAppName = '';
  String patientAppGender = '';
  String patientAppAge = '';
  String patientAppReserveTime = '';
  String patientAppTel = '';

  String loginDoctorId = '';



  get loginMobile => _loginMobile;
  get loginPass => _loginPass;



  get patientRegisterName => _patientRegisterName;
  get patientRegisterId => _patientRegisterId;
  get patientRegisterMobile => _patientRegisterMobile;
  get patientRegisterConfirmCode => _patientRegisterConfirmCode;
  get patientRegisterPass => _patientRegisterPass;
  get patientRegisterRePass => _patientRegisterRePass;


  get doctorRegisterName => _doctorRegisterName;
  get doctorRegisterId => _doctorRegisterId;
  get doctorRegisterMobile => _doctorRegisterMobile;
  get doctorRegisterConfirmCode => _doctorRegisterConfirmCode;
  get doctorRegisterCompany => _doctorRegisterCompany;
  get doctorRegisterCompanyId => _doctorRegisterCompanyId ;
  get doctorRegisterCompanyLevel => _doctorRegisterCompanyLevel;
  get doctorRegisterIntro => _doctorRegisterIntro;
  get doctorRegisterPass => _doctorRegisterPass;
  get doctorRegisterRePass => _doctorRegisterRePass;



  void setLoginMobile(String str){
    _loginMobile = str;
    notifyListeners();
  }
  void setLoginPass(String str){
    _loginPass = str;
    notifyListeners();
  }

  void setDoctorRegisterName(String str){
    _doctorRegisterName = str;
    notifyListeners();
  }
  void setDoctorRegisterId(String str){
    _doctorRegisterId = str;
    notifyListeners();
  }
  void setDoctorRegisterMobile(String str){
    _doctorRegisterMobile = str;
    notifyListeners();
  }
  void setDoctorRegisterConfirmCode(String str){
    _doctorRegisterConfirmCode = str;
    notifyListeners();
  }
  void setDoctorRegisterCompany(String str){
    _doctorRegisterCompany = str;
    notifyListeners();
  }
  void setDoctorRegisterCompanyLevel(String str){
    _doctorRegisterCompanyLevel = str;
    notifyListeners();
  }
  void setDoctorRegisterCompanyId(String str){
    _doctorRegisterCompanyId= str;
    notifyListeners();
  }
  void setDoctorRegisterIntro(String str){
    _doctorRegisterIntro = str;
    notifyListeners();
  }
  void setDoctorRegisterPass(String str){
    _doctorRegisterPass = str;
    notifyListeners();
  }
  void setDoctorRegisterRePass(String str){
    _doctorRegisterRePass = str;
    notifyListeners();
  }

  void setPatientRegisterName(String str){
    _patientRegisterName = str;
    notifyListeners();
  }
  void setPatientRegisterId(String str){
    _patientRegisterId = str;
    notifyListeners();
  }
  void setPatientRegisterMobile(String str){
    _patientRegisterMobile = str;
    notifyListeners();
  }
  void setPatientRegisterConfirmCode(String str){
    _patientRegisterConfirmCode = str;
    notifyListeners();
  }
  void setPatientRegisterPass(String str){
    _patientRegisterPass = str;
    notifyListeners();
  }
  void setPatientRegisterRePass(String str){
    _patientRegisterRePass = str;
    notifyListeners();
  }



}

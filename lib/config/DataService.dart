import 'dart:convert';

import 'package:bts_app/models/SchoolLeaveOfAbsence/student_leave_of_absence.dart';
import 'package:bts_app/models/convesationMessage/conversationmessage.dart';
import 'package:bts_app/models/data_response.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/BusToSchool/movement.dart';
import '../models/BusToSchool/result_movement.dart';
import '../models/SchoolLeaveOfAbsence/reason.dart';
import '../models/SchoolLeaveOfAbsence/reason_result.dart';
import '../models/TimeTable/time_table.dart';
import '../models/changePassword/change_password_model.dart';
import '../models/changePassword/change_password_result.dart';
import '../models/classRoom/class_info_result.dart';
import '../models/classRoom/class_lesson_detail.dart';
import '../models/configuration_result.dart';
import '../models/face_attendance_result.dart';
import '../models/foodmenu/foodmenu.dart';
import '../models/foodmenu/foodmenu_result.dart';
import '../models/invoice/invoice_result.dart';
import '../models/loginModel/loginModel.dart';
import '../models/loginModel/loginmodelresult.dart';
import '../models/profile.dart';
import '../models/register.dart';
import '../models/result.dart';
import '../models/schoolYear/school_year.dart';
import '../models/schoolYear/school_year_result.dart';
import '../models/student.dart';

class NetworkService {
  static String devChannel = 'prod';
  static String baseAddress = 'https://apidev-edupay.rveapp.com';
  static String baseSocket = 'http://apidev-edupay.rveapp.com';
  static String apiKey =
      'Qyu3lS+WYmhFrPtysA9Qwam+CQAjjDTIZpYT2EtMO7DvVZ7W/pk767nW7LuNP5BXBHAHN29oo1qyAJO8ms7YJA==';
  static String username = "edupay";
  static String password =
      "FyHWYbi2P6lPuP1FOtqPxMKqmgS1OkIE7Ra6UF8okAuQT+a4izndkdFtbc+DvVshAboy9NFSkavQrW7xT";
  static String basicAuth =
      "Basic " + utf8.fuse(base64).encode('$username:$password');

///////////////////////// LOGIN //////////////////////////////////
  Future<LoginModelResult> login(LoginModel loginModel) async {
    var loginModelInfo = json.encode(loginModel);
    http.Response response =
        await http.post(Uri.parse(baseAddress + 'Parent/login'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": basicAuth,
              "api_key": apiKey
            },
            body: loginModelInfo);
    var loginModelResult = LoginModelResult();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      loginModelResult = LoginModelResult.fromJson(jsonData);
      Profile.listStudent = {};

      if (loginModelResult.loginStatus == true) {
        if (loginModelResult.employeeCode!.isNotEmpty) ///// neu co ma nhan vien
        {
          loginModelResult.loginStatus = true;
          Profile.employeeCode = loginModelResult.employeeInfo!.iD ?? "";
          return loginModelResult;
        }

        if (loginModelResult.listStudent!.isNotEmpty) {
          Profile.phoneNumber = loginModelResult.phoneNumber;
          if (Profile.selectedStudent < loginModelResult.listStudent!.length) {
            Profile.currentStudent =
                loginModelResult.listStudent![Profile.selectedStudent];
          } else {
            Profile.currentStudent = loginModelResult.listStudent![0];
            Profile.selectedStudent = 0;
          }
          if (Profile.currentStudent.classRoom.isNotEmpty) {
            if (Profile.currentStudent.classRoom[0].listTimeTable!.isNotEmpty) {
              Profile.listTimeTable = Profile
                  .currentStudent.classRoom[0].listTimeTable as List<TimeTable>;
            }
          }

          int length = loginModelResult.listStudent!.length;
          for (int i = 0; i < length; i++) {
            Profile.listStudent[i] = loginModelResult.listStudent![i];
          }
        } else {
          loginModelResult.loginStatus = false;
          loginModelResult.message =
              "Tài khoản phụ huynh chưa liên kết với học viên. Vui lòng liên hệ với quản trị viên để được hỗ trợ sớm nhất !!!";
        }
        // return loginModelResult;/
      }
    }
    return loginModelResult;
  }

  Future<RegisterResult> register(String phoneNumber, String companyCode,
      String partnerName, String address, String password) async {
    final msg = jsonEncode({
      "PhoneNumber": phoneNumber,
      "CompanyCode": companyCode,
      "PartnerName": partnerName,
      "Address": address,
      "Password": password
    });

    http.Response response =
        await http.post(Uri.parse(baseAddress + 'User/Register'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": basicAuth,
              "api_key": apiKey
            },
            body: msg);
    var registerResult = RegisterResult();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      registerResult = RegisterResult.fromJson(jsonData);
    }
    return registerResult;
  }

  Future<bool> deleteAccount(String phoneNumber, String companyCode) async {
    final msg = jsonEncode({
      "PhoneNumber": phoneNumber,
      "CompanyCode": companyCode,
    });

    http.Response response =
        await http.post(Uri.parse(baseAddress + 'User/disableAccount'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": basicAuth,
              "api_key": apiKey
            },
            body: msg);
    var registerResult = Result();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      registerResult = Result.fromJson(jsonData);
      if (registerResult.status == 2) {
        return true;
      }
    }
    return false;
  }

///////////////////////// Change Password //////////////////////////////////
  Future<ChangePasswordResult> changePassword(
      ChangePasswordModel changePassModel) async {
    var changePassInfo = json.encode(changePassModel);
    http.Response response =
        await http.post(Uri.parse(baseAddress + 'User/Changepassword'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": basicAuth,
              "api_key": apiKey
            },
            body: changePassInfo);
    var changePasswordResult = ChangePasswordResult();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      changePasswordResult = ChangePasswordResult.fromJson(jsonData);
    }
    return changePasswordResult;
  }

/////////////////////////////////////////////////////////////////////////////////////
//////////////////// FACE ATDENTDANCE //////////////////////////////////
  Future<FaceAttendanceResult> faceAttendance(
      String mappingCode, String companyCode, DateTime date) async {
    DateFormat datefm = DateFormat("yyyy/MM/dd");
    final body = jsonEncode({
      "PersonCode": mappingCode,
      "CompanyCode": companyCode,
      "CaptureDate": datefm.format(date)
    });

    String _baseAddress = "http://apiserver.rveapp.com/api/frm/";
    String _apiKey =
        'FjMvRSIm9q05WGF5I88+rvlZd9HcQuvq8y/KmSjIKljiR0JmvyhQE00u0xaWywfjdJT2pukcmw+OGJm1Mrco4tlQ57sLRRHiuwoXr+VRaV4lyMYV5f9h0yLtmE/0bsHN==';
    String _username = "FRMCenter";
    String _password = "KmSjIKljiR0JmvyhQ";
    String _basicAuth =
        "Basic " + utf8.fuse(base64).encode('$_username:$_password');

    http.Response response =
        await http.post(Uri.parse(_baseAddress + 'FaceLogs/getAllByDay'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": _basicAuth,
              "api_key": _apiKey,
            },
            body: body);
    late FaceAttendanceResult faceAttendanceResult = FaceAttendanceResult();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      faceAttendanceResult = FaceAttendanceResult.fromJson(jsonData);
    }
    return faceAttendanceResult;
  }

  Future<FaceAttendanceResult> faceAttendanceDateRange(String mappingCode,
      String companyCode, DateTime fromDate, DateTime toDate) async {
    DateFormat datefm = DateFormat("yyyy/MM/dd");
    final body = jsonEncode({
      "PersonCode": mappingCode,
      "CompanyCode": companyCode,
      "FromDate": datefm.format(fromDate),
      "ToDate": datefm.format(toDate)
    });

    String _baseAddress = "http://apiserver.rveapp.com/api/frm/";
    String _apiKey =
        'FjMvRSIm9q05WGF5I88+rvlZd9HcQuvq8y/KmSjIKljiR0JmvyhQE00u0xaWywfjdJT2pukcmw+OGJm1Mrco4tlQ57sLRRHiuwoXr+VRaV4lyMYV5f9h0yLtmE/0bsHN==';
    String _username = "FRMCenter";
    String _password = "KmSjIKljiR0JmvyhQ";
    String _basicAuth =
        "Basic " + utf8.fuse(base64).encode('$_username:$_password');

    http.Response response =
        await http.post(Uri.parse(_baseAddress + 'FaceLogs/getAllByRangeDay'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": _basicAuth,
              "api_key": _apiKey,
            },
            body: body);
    late FaceAttendanceResult faceAttendanceResult = FaceAttendanceResult();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      faceAttendanceResult = FaceAttendanceResult.fromJson(jsonData);
    }
    return faceAttendanceResult;
  }

  /////////////////////////////////////////////////////////////////////////////////////
//////////////////////// STUDENT //////////////
  Future<Student> getStudentByID(String id) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress + 'Student/getStudentByID?$id'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );
    Student student = Student(dateOfBirth: DateTime.now(), classRoom: []);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      student = Student.fromJson(jsonData);
      return student;
    }
    return student;
  }

  //////////////////////////////////////////////////////////////////////////////////////
//////////////////////// CLASSROOM /////////////////
  Future<List<ClassLessonDetail>> getLessonByStudentID(String studentID) async {
    http.Response response = await http.get(
      Uri.parse(
          baseAddress + 'Class/getLessonByStudentID?studentID=$studentID'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );
    List<ClassLessonDetail> listLesson = [];
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      for (var lesson in jsonData) {
        listLesson.add(ClassLessonDetail.fromJson(lesson));
      }
    }
    return listLesson;
  }

  Future<ClassInfoResult> getClassInfo(
      String companyCode, String studentCode, String schoolYearID) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress +
          // ignore: unnecessary_brace_in_string_interps
          'Class/getClassRoomInfo?StudentCode=${studentCode}&SchoolYearID=${schoolYearID}&CompanyCode=${companyCode}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );

    ClassInfoResult result = ClassInfoResult();
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      result = ClassInfoResult.fromJson(jsonData);
    }
    return result;
  }

///////////////////////////////////////////////////
  ///
  Future<FoodMenuResult> getAllMenu() async {
    http.Response response = await http.get(
      Uri.parse(baseAddress + 'FoodMenu/getAllByCompanyCode?companyCode=MDC'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );
    FoodMenuResult foodmenu = FoodMenuResult();
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      foodmenu = FoodMenuResult.fromJson(jsonData);
    }
    return foodmenu;
  }

  Future<List<FoodMenu>> getAllFoodMenu() async {
    http.Response response = await http.get(
      Uri.parse(baseAddress + 'FoodMenu/getAll'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );
    List<FoodMenu> listMenu = [];
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      for (var menu in jsonData) {
        listMenu.add(FoodMenu.fromJson(menu));
      }
    }
    return listMenu;
  }

///////////////////// SchoolYear ////////////////
  ///
  ///
  ///

  Future<List<SchoolYear>> getAllSchoolYear(String companyCode) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress + 'SchoolYear/getAll?companyCode=${companyCode}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );

    SchoolYearResult result = SchoolYearResult();
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      result = SchoolYearResult.fromJson(jsonData);
    }
    return result.schoolYear ?? [];
  }

  Future<SchoolYearResult> getAllSchoolYearV1(
      String companyCode, String studentID) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress +
          'SchoolYear/getAll?companyCode=${companyCode}&studentID=${studentID}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );

    SchoolYearResult result = SchoolYearResult();
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      result = SchoolYearResult.fromJson(jsonData);
    }
    return result;
  }

  Future<SchoolYearResult> getAllSchoolYearByCompanyCode(
      String companyCode) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress + 'SchoolYear/getAll?companyCode=${companyCode}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );

    SchoolYearResult result = SchoolYearResult();
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      result = SchoolYearResult.fromJson(jsonData);
    }
    return result;
  }

  Future<DataResponse> getClassInfoByTeacher(
      String companyCode, String employeeID) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress +
          // ignore: unnecessary_brace_in_string_interps
          'Class/getClassRoomInfoByTeacher?CompanyCode=${companyCode}&EmployeeID=${employeeID}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );
    DataResponse result = DataResponse();
    try {
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        result = DataResponse.fromJson(jsonData);
      }
    } catch (ex) {
      return DataResponse(
          status: 4,
          message: "Failed connect to server !!!",
          total: 0,
          data: []);
    }
    return result;
  }

  Future<ConfigurationResult> getVersion(
      String platform, String companyCode) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress +
          'user/getVersion?platform=${platform}&companyCode=${companyCode}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );

    ConfigurationResult result = ConfigurationResult();
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      result = ConfigurationResult.fromJson(jsonData);
    } else {
      result.message = "Lỗi kết nối !!!";
      result.status = 4;
    }

    return result;
  }

  ///
  ///
  ///
  Future<InvoiceResult> getAllInvoice(String studentID) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress + 'Invoice/getAllInvoice?StudentID=$studentID'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );
    InvoiceResult temp = InvoiceResult();
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      temp = InvoiceResult.fromJson(jsonData);
    }
    return temp;
  }

  Future<List<Movement>> getAllMovementByParentPhone(
      String phoneNumber, String companyCode, DateTime date) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress +
          'Movement/getAllMovementByParentPhone?CompanyCode=${Profile.companyCode}&UserLogin=$phoneNumber&date=${DateFormat('yyyy-MM-dd').format(date)}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );
    ResultMovement temp = ResultMovement();
    List<Movement> lstMovement = [];
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      temp = ResultMovement.fromJson(jsonData);
      if (temp.status == 2) {
        lstMovement = temp.data!;
      }
    }
    return lstMovement;
  }

  Future<List<Reason>> getAllReason(
      String phoneNumber, String companyCode) async {
    http.Response response = await http.get(
      Uri.parse(baseAddress +
          'StudentLeaveOfAbsence/getAllReason?CompanyCode=${Profile.companyCode}&UserLogin=${Profile.phoneNumber}'),
      headers: <String, String>{
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": basicAuth,
        "api_key": apiKey
      },
    );
    ReasonResult temp = ReasonResult();
    List<Reason> lstReson = [];
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      temp = ReasonResult.fromJson(jsonData);
      if (temp.status == 2) {
        lstReson = temp.data!;
      }
    }
    return lstReson;
  }

  Future<Result> createLeaveOfAbsence(StudentLeaveOfAbsenceModel model) async {
    final msg = jsonEncode({
      "CompanyCode": model.companyCode,
      "FromDate": model.fromDate,
      "ToDate": model.toDate,
      "ReasonDescription": model.reasonDescription,
      "Reason": model.reason,
      "Student": model.student,
      "Parent": model.parent
    });
    http.Response response =
        await http.post(Uri.parse(baseAddress + 'StudentLeaveOfAbsence/create'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": basicAuth,
              "api_key": apiKey
            },
            body: msg);
    Result result = Result();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      result = Result.fromJson(jsonData);
      // changePasswordResult = ChangePasswordResult.fromJson(jsonData);
    }
    return result;
    // return jsonData;
  }

  Future<DataResponse> getAllStudentByClassRoom(String classRoom) async {
    http.Response response = await http.get(
        Uri.parse(baseAddress +
            'Student/GetAllStudentInClass?ClassRoom=${classRoom}'),
        headers: <String, String>{
          "content-type": "application/json",
          "accept": "application/json",
          "authorization": basicAuth,
          "api_key": apiKey
        });
    DataResponse dataResponse = DataResponse();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      dataResponse = DataResponse.fromJson(jsonData);
      // changePasswordResult = ChangePasswordResult.fromJson(jsonData);
    }
    return dataResponse;
    // return jsonData;
  }

  Future<DataResponse> getConvertion(String schoolYear, String receiver,
      String companyCode, String sender) async {
    final body = jsonEncode({
      "SchoolYear": schoolYear,
      "Receiver": receiver,
      "CompanyCode": companyCode,
      "Sender": sender,
    });
    http.Response response =
        await http.post(Uri.parse(baseAddress + 'chat/getConversation'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": basicAuth,
              "api_key": apiKey
            },
            body: body);
    print(body);
    DataResponse dataResponse = DataResponse();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      dataResponse = DataResponse.fromJson(jsonData);
      // changePasswordResult = ChangePasswordResult.fromJson(jsonData);
    }
    return dataResponse;
    // return jsonData;
  }

  Future<DataResponse> newMessage(ConversationMessage message) async {
    final body = jsonEncode({
      "ID": message.id,
      "Conversation": message.conversation,
      "Content": message.content,
      "Sender": message.sender
    });
    http.Response response =
        await http.post(Uri.parse(baseAddress + 'chat/newMessage'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": basicAuth,
              "api_key": apiKey
            },
            body: body);
    print(body);
    DataResponse dataResponse = DataResponse();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      dataResponse = DataResponse.fromJson(jsonData);
      // changePasswordResult = ChangePasswordResult.fromJson(jsonData);
    }
    return dataResponse;
    // return jsonData;
  }

  Future<DataResponse> getAllMessage(String conversation, String sender) async {
    final body = jsonEncode({
      "Conversation": conversation,
      // "Sender": sender,
    });
    http.Response response =
        await http.post(Uri.parse(baseAddress + 'chat/getAllMessage'),
            headers: <String, String>{
              "content-type": "application/json",
              "accept": "application/json",
              "authorization": basicAuth,
              "api_key": apiKey
            },
            body: body);
    print(body);
    DataResponse dataResponse = DataResponse();
    // loginModelResult.authentication = false;
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      dataResponse = DataResponse.fromJson(jsonData);
      // changePasswordResult = ChangePasswordResult.fromJson(jsonData);
    }
    return dataResponse;
    // return jsonData;
  }

  getAllConversationMessages(id) {}

  getVerifyCode({required String phoneNumber}) {}
}

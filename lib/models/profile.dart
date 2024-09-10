import '../utils.dart';
import 'TimeTable/time_table.dart';
import 'classRoom/class_info.dart';
import 'student.dart';

class Profile {
  static String? phoneNumber;
  static String currentYear = "";
  static String companyCode = "TEST01";
  static String parentID = "";
  static String employeeCode = "";
  static Student currentStudent =
      Student(dateOfBirth: DateTime.now(), classRoom: []);
  static ClassInfo currentClassRoom = ClassInfo();
  static int selectedStudent = 0;
  static DateTime currentDateAtten = DateTime.now();
  static DateTime firstDayOfWeek = findFirstDateOfTheWeek(currentDateAtten);
  static DateTime lastDayOfWeek = findLastDateOfTheWeek(currentDateAtten);
  static List<TimeTable> listTimeTable = [];
  static Map<int, Student> listStudent = {};
  static int duration = 300;
}
// data; List<Student>?
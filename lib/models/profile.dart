import '../utils.dart';
import 'TimeTable/time_table.dart';
import 'student.dart';

class Profile {
  static String? phoneNumber;
  static String currentYear = "";
  static String companyCode = "NTP";
  static String parentID = "";
  static String employeeCode = "";
  static Student currentStudent =
      Student(dateOfBirth: DateTime.now(), classRoom: []);
  static int selectedStudent = 0;
  static DateTime currentDateAtten = DateTime.now();
  static DateTime firstDayOfWeek = findFirstDateOfTheWeek(currentDateAtten);
  static DateTime lastDayOfWeek = findLastDateOfTheWeek(currentDateAtten);
  static List<TimeTable> listTimeTable = [];
  static Map<int, Student> listStudent = {};
  static int duration = 300;
}
// data; List<Student>?
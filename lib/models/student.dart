import 'classRoom/class_info.dart';

class Student {
  final String id;
  final String companyCode;
  final String studentCode;
  final String studentName;
  final String parentPhoneNumber;
  final String address;
  final String personCode;
  final String mappingCode;
  final String faceImageURL;
  final DateTime dateOfBirth;
  final bool used;
  final int gender;
  List<ClassInfo> classRoom;

  Student(
      {this.id = "",
      this.faceImageURL = "",
      this.studentCode = "",
      this.studentName = "",
      this.parentPhoneNumber = "",
      this.personCode = "",
      this.companyCode = "",
      this.address = "",
      this.used = false,
      this.mappingCode = "",
      this.gender = 0,
      required this.classRoom,
      required this.dateOfBirth});

  factory Student.fromJson(Map<String, dynamic> json) {
    Student student = Student(
        id: json['ID'],
        studentCode: json['StudentCode'] ?? "",
        studentName: json['StudentName'] ?? "",
        parentPhoneNumber: json['ParentPhoneNumber'] ?? "",
        companyCode: json['CompanyCode'] ?? "",
        personCode: json['PersonCode'] ?? "",
        address: json['Address'] ?? "",
        used: json['Used'] ?? "",
        mappingCode: json['MappingCode'] ?? "",
        gender: json['Gender'] ?? 0,
        dateOfBirth: DateTime.parse(json['DateOfBirth']),
        faceImageURL: json['FaceImageURL'] ?? "",
        classRoom: []);

    if (json['GTS_ClassRoom'] != null) {
      student.classRoom = <ClassInfo>[];
      json['GTS_ClassRoom'].forEach((v) {
        student.classRoom.add(ClassInfo.fromJson(v));
      });
    }
    // try {
    //   String jsonImage = json['StudentAvatar'];
    //   if (jsonImage == null || jsonImage == '') {
    //     student.studentAvatar = Image.asset('images/img_avatar.png');
    //   } else {
    //     Uint8List _bytesImage = base64.decode(jsonImage);
    //     student.studentAvatar = Image.memory(_bytesImage);
    //   }
    // } catch (ex) {
    //   student.studentAvatar = Image.asset('images/img_avatar.png');
    // }

    return student;
  }
}
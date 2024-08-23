class StudentClassInfo {
  String? classRoom;
  String? studentCode;
  String? parent;
  bool? activated;
  String? studentName;
  String? dateOfBirth;
  String? faceImageURL;
  String? partnerName;
  String? phone;
  String? parentID;
  String? firebaseToken;
  String? receiverImage;
  StudentClassInfo(
      {this.classRoom,
      this.studentCode,
      this.parent,
      this.activated,
      this.studentName,
      this.dateOfBirth,
      this.faceImageURL,
      this.partnerName,
      this.parentID,
      this.phone,
      this.firebaseToken,
      this.receiverImage});

  StudentClassInfo.fromJson(Map<String, dynamic> json) {
    classRoom = json['ClassRoom'];
    studentCode = json['StudentCode'];
    parent = json['Parent'] ?? "";
    activated = json['Activated'];
    studentName = json['StudentName'];
    dateOfBirth = json['DateOfBirth'];
    faceImageURL = json['FaceImageURL'];
    partnerName = json['PartnerName'] ?? "";
    phone = json['Phone'] ?? "";
    parentID = json['ID'] ?? '';
    firebaseToken = json['FirebaseToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassRoom'] = this.classRoom;
    data['StudentCode'] = this.studentCode;
    data['Parent'] = this.parent;
    data['Activated'] = this.activated;
    data['StudentName'] = this.studentName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['FaceImageURL'] = this.faceImageURL;
    data['PartnerName'] = this.partnerName;
    data['Phone'] = this.phone;
    return data;
  }
}

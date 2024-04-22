class Student {
  final String userID;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  final String dateOfBirth;
  final String date;

  Student({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.date,
    required this.dateOfBirth,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      userID: json['UserID'].toString(),
      firstName: json['FirstName'].toString(),
      lastName: json['LastName'].toString(),
      email: json['Email'].toString(),
      phoneNum: json['PhoneNumber'].toString(),
      dateOfBirth: json['DateOfBirth'].toString(),
      date: json['Registed_Date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'PhoneNumber': phoneNum,
      'DateOfBirth': dateOfBirth,
      'Registed_Date': DateTime.now().toString(),
    };
  }
}

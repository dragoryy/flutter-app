class Student {
  String firstName = '';
  String lastName = '';
  String middleName = '';
  String birthDate = '';
  String favSubject = '';
  String? id;

  Student(this.firstName, this.lastName, this.middleName, this.birthDate,
      this.id, this.favSubject);

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'birthDate': birthDate,
      'favSubject': favSubject,
      'id': id
    };
  }

  @override
  String toString() {
    return "$firstName, $lastName, $middleName, $birthDate, $favSubject, $id";
  }
}

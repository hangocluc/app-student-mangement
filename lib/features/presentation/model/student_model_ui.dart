class StudentModelUI {
  final String id;
  final String name;
  final String studentId;
  final String className;
  final String? email;
  final String? phone;
  final String? address;
  final DateTime? dateOfBirth;
  final String? avatar;

  StudentModelUI({
    required this.id,
    required this.name,
    required this.studentId,
    required this.className,
    this.email,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.avatar,
  });
}

class UserEntity {
  final String fname, lname;
  final String phoneNumber;
  final String email;
  final String token;
  final String? area;

  UserEntity({
    required this.fname,
    required this.lname,
    required this.phoneNumber,
    required this.email,
    required this.token,
    this.area,
  });
}

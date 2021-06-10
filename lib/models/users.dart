part of 'models.dart';

class Users extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String imagePath;
  final String description;
  final String createdAt;
  final String updatedAt;

  Users(
    this.uid,
    this.name,
    this.email,
    this.password,
    this.imagePath,
    this.description,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props => [
        uid,
        name,
        email,
        password,
        imagePath,
        description,
        createdAt,
        updatedAt
      ];
}

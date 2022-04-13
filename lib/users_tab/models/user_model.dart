const String usersTable = 'users';

class UserFields {
  static final List<String> values = [
    id,
    email,
    firstName,
    lastName,
    avatar,
  ];
  static const String id = '_id';
  static const String email = 'email';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String avatar = 'avatar';
}

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  static User fromJson(json) => User(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatar: json['avatar'],
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.email: email,
        UserFields.firstName: firstName,
        UserFields.lastName: lastName,
        UserFields.avatar: avatar,
      };

  User copy({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  static User fromJsonDB(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int,
        email: json[UserFields.email] as String,
        firstName: json[UserFields.firstName] as String,
        lastName: json[UserFields.lastName] as String,
        avatar: json[UserFields.avatar] as String,
      );
}

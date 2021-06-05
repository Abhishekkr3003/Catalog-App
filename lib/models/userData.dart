import 'dart:convert';

class UserDetails {
  String? name;
  String? email;
  String? about;
  String? password;
  String? dpURL;
  UserDetails({
    this.name,
    this.email,
    this.about,
    this.password,
    this.dpURL,
  });

  UserDetails copyWith({
    String? name,
    String? email,
    String? about,
    String? password,
    String? dpURL,
  }) {
    return UserDetails(
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
      password: password ?? this.password,
      dpURL: dpURL ?? this.dpURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'about': about,
      'password': password,
      'dpURL': dpURL,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      name: map['name'],
      email: map['email'],
      about: map['about'],
      password: map['password'],
      dpURL: map['dp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, email: $email, about: $about, password: $password, dpURL: $dpURL)';
  }

}

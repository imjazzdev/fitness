class Profile {
  final int id;
  final String username;
  final int height;
  final int weight;
  final int age;
  final String? profileImagePath;

  Profile({
    required this.id,
    required this.username,
    required this.height,
    required this.weight,
    required this.age,
    this.profileImagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'height': height,
      'weight': weight,
      'age': age,
      'profileImagePath': profileImagePath,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      username: map['username'],
      height: map['height'],
      weight: map['weight'],
      age: map['age'],
      profileImagePath: map['profileImagePath'],
    );
  }
}

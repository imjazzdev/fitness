class Photo {
  final int? id;
  final String path;
  final String date;

  Photo({this.id, required this.path, required this.date});

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
      'date': date,
    };
  }

  // Convert Map to object
  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      path: map['path'],
      date: map['date'],
    );
  }
}

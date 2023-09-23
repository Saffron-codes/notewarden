class Media {
  final int id;
  final String location;
  final int collectionId;
  final DateTime createdAt;

  const Media({
    required this.id,
    required this.location,
    required this.collectionId,
    required this.createdAt,
  });

  factory Media.fromJson(Map<String, dynamic> map) {
    return Media(
      id: map['id'],
      location: map['location'],
      collectionId: map['collectionId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'collectionId': collectionId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

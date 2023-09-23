// Model for [Collection] schema in DB
class Collection {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Collection({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

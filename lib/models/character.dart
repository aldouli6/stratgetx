import 'dart:convert';

List<Character> characterFromJson(String str) =>
    List<Character>.from(json.decode(str).map((x) => Character.fromJson(x)));

String characterToJson(List<Character> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Character {
  final int id;
  final String name;
  final String description;
  final Map<String, dynamic> thumbnail;
  final String modified;

  Character(
      {required this.id,
      required this.modified,
      required this.name,
      required this.description,
      required this.thumbnail});

  Character copyWith({
    required int id,
    String? name,
    String? description,
    Map<String, String>? thumbnail,
    String? modified,
  }) =>
      Character(
          id: this.id,
          name: name ?? this.name,
          description: description ?? this.description,
          thumbnail: thumbnail ?? this.thumbnail,
          modified: modified ?? this.modified);

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        thumbnail: json['thumbnail'],
        modified: json['modified'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "modified": modified
      };
}

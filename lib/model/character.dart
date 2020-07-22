class Character {
  final int id;
  final String name;
  final String status;
  final String specie;
  final String type;
  final String gender;
  final String image;

  Character(
      {this.id,
      this.name,
      this.status,
      this.specie,
      this.type,
      this.gender,
      this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      specie: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
    );
  }
}

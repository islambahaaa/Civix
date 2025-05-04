class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(id: json['id'], name: json['name']);
  }
}

class Area {
  final int id;
  final String name;

  Area({required this.id, required this.name});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(id: json['id'], name: json['name']);
  }
}

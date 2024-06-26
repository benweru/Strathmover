class RoutePoint {
  String name;
  String description;
  bool isBusStop;

  RoutePoint({
    required this.name,
    required this.description,
    required this.isBusStop,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'isBusStop': isBusStop,
    };
  }

  static RoutePoint fromMap(Map<String, dynamic> map) {
    return RoutePoint(
      name: map['name'],
      description: map['description'],
      isBusStop: map['isBusStop'],
    );
  }
}

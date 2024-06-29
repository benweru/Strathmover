class RoutePoint {
  final String name;
  final String? description;
  final bool isBusStop;

  RoutePoint({required this.name, this.description, required this.isBusStop});

  factory RoutePoint.fromMap(Map<String, dynamic> map) {
    return RoutePoint(
      name: map['name'],
      description: map['description'],
      isBusStop: map['isBusStop'] ?? false, // default to false if not provided
    );
  }
}

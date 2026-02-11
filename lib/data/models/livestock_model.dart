class LivestockModel {
  final String id;
  final String name;
  final String type;
  final int count;
  final String health;
  final DateTime lastCheckup;

  LivestockModel({
    required this.id,
    required this.name,
    required this.type,
    required this.count,
    required this.health,
    required this.lastCheckup,
  });

  factory LivestockModel.fromJson(Map<String, dynamic> json) {
    return LivestockModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      count: json['count'] ?? 0,
      health: json['health'] ?? 'Good',
      lastCheckup: json['lastCheckup'] != null
          ? DateTime.parse(json['lastCheckup'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'count': count,
      'health': health,
      'lastCheckup': lastCheckup.toIso8601String(),
    };
  }
}

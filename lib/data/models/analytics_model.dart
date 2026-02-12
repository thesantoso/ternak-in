class AnalyticsDataModel {
  final String title;
  final String value;
  final String trend;
  final double percentage;

  AnalyticsDataModel({
    required this.title,
    required this.value,
    required this.trend,
    required this.percentage,
  });

  factory AnalyticsDataModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsDataModel(
      title: json['title'] ?? '',
      value: json['value'] ?? '',
      trend: json['trend'] ?? 'up',
      percentage: (json['percentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'trend': trend,
      'percentage': percentage,
    };
  }
}

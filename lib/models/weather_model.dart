class Weather {
  final String cityName;
  final String mainCondition; //clouds
  final double temperature;
  final String description;

  Weather({
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}

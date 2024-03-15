class Weather {
  final String cityName; //cairo
  final String countryName; //egypt
  final String mainCondition; //clouds or clear
  final double temperature;

  Weather({
    required this.cityName,
    required this.countryName,
    required this.mainCondition,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      countryName: json['location']['country'],
      mainCondition: json['current']['condition']['text'],
      temperature: json['current']['temp_c'].toDouble(),
    );
  }
}

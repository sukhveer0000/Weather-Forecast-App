class MainData {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int groundLevel;
  final int humidity;
  final double tempKf;

  MainData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.groundLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainData.fromJson(Map<String, dynamic> json) {
    return MainData(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      groundLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: (json['temp_kf'] as num).toDouble(),
    );
  }
}

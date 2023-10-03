class WeatherModel {
  String? time;
  String? code;
  String? weather;
  String? humidity;
  String? tempC;
  String? tempF;

  WeatherModel({
    this.time,
    this.code,
    this.weather,
    this.humidity,
    this.tempC,
    this.tempF,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      time: json['jamCuaca'],
      code: json['kodeCuaca'],
      weather: json['cuaca'],
      humidity: json['humidity'],
      tempC: json['tempC'],
      tempF: json['tempF']);
}

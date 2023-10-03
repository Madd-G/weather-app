part of 'weather_cubit.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();


  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {
  late final LocationModel locationModel;
}

class WeatherLoadingState extends WeatherState {
  late final LocationModel locationModel;
}

class WeatherLoadedState extends WeatherState {
  final Position? position;
  final LocationModel locationModel;
  final List<String> listLocation;
  final List<WeatherModel> listWeatherModel;

  const WeatherLoadedState(
      {this.position,
      required this.locationModel,
      required this.listLocation,
      required this.listWeatherModel});

  @override
  List<Object> get props => [position!, locationModel];
}

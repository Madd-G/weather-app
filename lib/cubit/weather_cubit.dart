import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../models/location_model.dart';
import '../models/weather_model.dart';
import '../services/api_service.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';


class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  final ApiService apiService = ApiService();

  List<LocationModel> listLocationModel = [];
  late LocationModel locationModel;
  List<String> listId = [];
  List<String> listLocation = [];

  get listWeatherModel => [];

  void getLocation() async {
    emit(WeatherLoadingState());
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      var response = await apiService.dio.get('cuaca/wilayah.json');
      listLocationModel = List<LocationModel>.from(
        response.data.map(
          (e) => LocationModel.fromJson(e),
        ),
      );
      double minDistance = 10000;

      for (var i = 0; i < listLocationModel.length; i++) {
        final haversine = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          double.parse(listLocationModel[i].lat!),
          double.parse(listLocationModel[i].lon!),
        );
        listLocation.add(listLocationModel[i].regency!);
        listId.add(listLocationModel[i].id!);
        if (haversine < minDistance) {
          locationModel = listLocationModel[i];
          try {
            var listWeather =
                await apiService.dio.get('cuaca/${locationModel.id}.json');
            List<WeatherModel> listWeatherModel = List<WeatherModel>.from(
              listWeather.data.map(
                (e) => WeatherModel.fromJson(e),
              ),
            );

            // listWeatherModel = listWeatherModel;
            emit(
              WeatherLoadedState(
                position: position,
                locationModel: listLocationModel[1],
                listLocation: listLocation,
                listWeatherModel: listWeatherModel,
              ),
            );
          } catch (e) {
            e.toString();
          }
        }
      }
    } catch (e) {

      e.toString();
    }
  }

  void changeLocation(int id) async {
    emit(WeatherLoadingState());
    try {
      var response = await apiService.dio.get('cuaca/${listId[id]}.json');
      List<WeatherModel> listWeatherModel = List<WeatherModel>.from(
        response.data.map(
          (e) => WeatherModel.fromJson(e),
        ),
      );
      emit(
        WeatherLoadedState(
          locationModel: listLocationModel[id],
          listLocation: listLocation,
          listWeatherModel: listWeatherModel,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

}

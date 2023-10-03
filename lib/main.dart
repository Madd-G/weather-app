import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/screens/home_screen/home_screen.dart';
import 'package:weather_app/utils/theme.dart';
import 'cubit/weather_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getLocation(),
      // create: (context) => WeatherCubit().._determinePosition(),
      child: MaterialApp(
          theme: themeData,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen()),
    );
  }
}

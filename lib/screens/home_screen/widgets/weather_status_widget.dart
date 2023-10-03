import 'package:flutter/material.dart';

import '../../../cubit/weather_cubit.dart';

class WeatherStatus extends StatelessWidget {
  const WeatherStatus({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadingState) {
          return const SizedBox();
        }
        if (state is WeatherLoadedState) {
          var now = DateTime.now();
          int i = now.isAfter(
                    DateTime(now.year, now.month, now.day, 0, 0),
                  ) &&
                  now.isBefore(
                    DateTime(now.year, now.month, now.day, 6, 0),
                  )
              ? 0
              : now.isAfter(
                        DateTime(now.year, now.month, now.day, 6, 0),
                      ) &&
                      now.isBefore(
                        DateTime(now.year, now.month, now.day, 12, 0),
                      )
                  ? 1
                  : now.isAfter(
                            DateTime(now.year, now.month, now.day, 12, 0),
                          ) &&
                          now.isBefore(
                            DateTime(now.year, now.month, now.day, 18, 0),
                          )
                      ? 2
                      : 3;
          if (state.listWeatherModel.isNotEmpty) {
            return Column(
              children: [
                Text(
                  "${state.listWeatherModel[i].weather}",
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20.0,),
                Image.network(
                  'https://ibnux.github.io/BMKG-importer/icon/${state.listWeatherModel[i].code}.png',
                  scale: 1,
                ),

              ],
            );

          }
        }
        return const Text('Tidak ada data');
      },
    );
  }
}

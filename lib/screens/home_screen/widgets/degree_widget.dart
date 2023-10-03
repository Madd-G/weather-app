import 'package:flutter/material.dart';

import '../../../cubit/weather_cubit.dart';

class DegreeWidget extends StatelessWidget {
  const DegreeWidget({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    print('degree rebuild');

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
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
        if (state is WeatherLoadingState) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is WeatherLoadedState) {
          if (state.listWeatherModel.isNotEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.listWeatherModel[i].tempC!,
                  style: textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "\u00B0",
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            );

          }
        }
        return const SizedBox(height: 100.0,);
      },
    );
  }
}

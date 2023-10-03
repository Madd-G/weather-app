import 'package:flutter/material.dart';

import '../../../cubit/weather_cubit.dart';
import '../../../utils/date_formatting.dart';
import '../../../utils/weather_icon.dart';

class WeatherCarousel extends StatelessWidget {
  const WeatherCarousel({
    super.key,
    required this.tab,
    required this.textTheme,
  });

  final List<Tab> tab;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tab.length,
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: MediaQuery.of(context).size.width / 1.7,
                  child: TabBar(
                    dividerColor: Colors.black,
                    indicatorWeight: 3,
                    tabs: tab,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black45,
                    labelStyle: textTheme.titleMedium!.copyWith(
                      fontSize: 13,
                    ),
                    unselectedLabelStyle: textTheme.titleMedium!.copyWith(
                      fontSize: 13,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 2.7,
            child: TabBarView(
              children: [
                WeatherCarouselView(
                  textTheme: textTheme,
                  addIndex: 0,
                ),
                WeatherCarouselView(
                  textTheme: textTheme,
                  addIndex: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherCarouselView extends StatelessWidget {
  const WeatherCarouselView({
    super.key,
    required this.textTheme,
    this.addIndex,
  });

  final TextTheme textTheme;
  final int? addIndex;

  @override
  Widget build(BuildContext context) {
    print('weather_carousel rebuild');

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is WeatherLoadedState) {
          if (state.listWeatherModel.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var size = MediaQuery.of(context).size.width;
                return SizedBox(
                  width: size / 4,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        formatDate(
                            state.listWeatherModel[index + addIndex!].time!,
                            'HH:mm'),
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        getWeatherIcon(
                            '${state.listWeatherModel[index + addIndex!].weather}'),
                        style: const TextStyle(fontSize: 30.0),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${state.listWeatherModel[index + addIndex!].tempC} \u00B0",
                        style: textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: 4,
            );
          }
        }

        return const Center(
          child: Text(
          'Tidak ada data',
          style: TextStyle( fontSize: 20.0, color: Colors.black),
          ),
        );
      },
    );
  }
}

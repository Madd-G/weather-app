import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../../cubit/weather_cubit.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadingState) {
          return const SizedBox(
            height: 160.0,
          );
        } else if (state is WeatherLoadedState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150.0,
                  child: DropdownButton<String>(
                    menuMaxHeight: 300.0,
                    isDense: true,
                    underline: const SizedBox.shrink(),
                    elevation: 0,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                    ),
                    selectedItemBuilder: (context) {
                      return state.listLocation.map((String value) {
                        return Text(value, style: textTheme.titleMedium);
                      }).toList();
                    },
                    value: state.locationModel.regency,
                    items: state.listLocation.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      int index = state.listLocation.indexOf(value!);
                      context.read<WeatherCubit>().changeLocation(index);
                    },
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${state.locationModel.regency}",
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }
        return const SizedBox(
          width: 150.0,
        );
      },
    );
  }
}

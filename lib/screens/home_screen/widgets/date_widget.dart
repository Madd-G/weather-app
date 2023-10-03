import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  final StreamController<String> _timeStreamController = StreamController<
      String>();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (_) {
      final currentTime = DateTime.now();
      final formattedTime = DateFormat("EEEE, dd MMMM HH:mm").format(
          currentTime);
      _timeStreamController.add(formattedTime);
    });
  }

  @override
  void dispose() {
    _timeStreamController.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _timeStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: widget.textTheme.bodySmall,
          );
        } else {
          return const Text(
              "Loading...");
        }
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final List<Tab> tab = [
      const Tab(
        text: "Hari Ini",
      ),
      const Tab(
        text: "Besok",
      ),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 480,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 50),
                  // color: Colors.black,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.6, 1],
                      colors: [
                        Color(0xFF6757F4),
                        Color(0xFF677DEE),
                        Color(0xFF6995EB),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      CityWidget(textTheme: textTheme),
                      DegreeWidget(textTheme: textTheme),
                      DateWidget(textTheme: textTheme),
                      WeatherStatus(textTheme: textTheme),
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 100,
                  color: const Color(0xFF6995EB),
                ),
                Positioned(
                  bottom: 0,
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 150),
                    painter: WavePainterRight(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 150),
                    painter: WavePainterLeft(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 80),
                    painter: WavePainter(),
                  ),
                ),
              ],
            ),
            WeatherCarousel(tab: tab, textTheme: textTheme),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    final path = Path();
    path.moveTo(0, size.height);

    path.quadraticBezierTo(
        size.width / 2, size.height / 2.5, size.width / 2, size.height / 2.5);
    path.quadraticBezierTo(
        size.width * 1, size.height * 1.2, size.width, size.height / 1.5);

    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class WavePainterRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF95B8F1);

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height * 3 / 4, size.width / 1.6, size.height / 1.3);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height / 5, size.width, size.height / 2);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class WavePainterLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF95B8F1);

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 8, size.height / 10, size.width / 2, size.height * 1);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height * 3 / 4, size.width, size.height / 1.5);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

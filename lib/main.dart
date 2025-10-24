import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Light Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Traffic Light Animation'),
    );
  }
}

enum TrafficLight { red, yellow, green }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TrafficLight _current = TrafficLight.red;

  void _nextLight() {
    setState(() {
      if (_current == TrafficLight.red) {
        _current = TrafficLight.yellow;
      } else if (_current == TrafficLight.yellow) {
        _current = TrafficLight.green;
      } else {
        _current = TrafficLight.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const double lightSize = 84;
    const Duration fade = Duration(milliseconds: 400);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // กล่องสัญญาณไฟ
            Container(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
                border: Border.all(color: Colors.black.withOpacity(0.06)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LightCircle(
                    color: Colors.red,
                    size: lightSize,
                    duration: fade,
                    isOn: _current == TrafficLight.red,
                  ),
                  const SizedBox(height: 18),
                  _LightCircle(
                    color: Colors.yellow.shade700,
                    size: lightSize,
                    duration: fade,
                    isOn: _current == TrafficLight.yellow,
                  ),
                  const SizedBox(height: 18),
                  _LightCircle(
                    color: Colors.green,
                    size: lightSize,
                    duration: fade,
                    isOn: _current == TrafficLight.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: _nextLight,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('เปลี่ยนไฟ'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LightCircle extends StatelessWidget {
  final Color color;
  final double size;
  final bool isOn;
  final Duration duration;

  const _LightCircle({
    required this.color,
    required this.size,
    required this.isOn,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final glow = isOn
        ? [
            BoxShadow(
              color: color.withOpacity(0.6),
              blurRadius: 28,
              spreadRadius: 2,
            ),
          ]
        : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)];

    return AnimatedOpacity(
      duration: duration,
      curve: Curves.easeInOut,
      opacity: isOn ? 1.0 : 0.3, // ตามเงื่อนไขโจทย์
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: glow,
        ),
      ),
    );
  }
}

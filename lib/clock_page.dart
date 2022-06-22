import 'dart:async';
import 'package:flutter/material.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Clock(),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late String _formattedTime;
  late Timer _timer;

  @override
  void initState() {
    _formattedTime = _formatDate();

    _timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) {
        _setTime();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _formattedTime,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }

  void _setTime() {
    setState(() {
      _formattedTime = _formatDate();
    });
  }

  String _formatDate() {
    final DateTime now = DateTime.now();

    final year = now.year.toString().padLeft(2, "0");
    final month = now.month.toString().padLeft(2, "0");
    final day = now.day.toString().padLeft(2, "0");
    final hour = now.hour.toString().padLeft(2, "0");
    final minute = now.minute.toString().padLeft(2, "0");
    final second = now.second.toString().padLeft(2, "0");

    final formattedTime = '$year-$month-$day $hour:$minute:$second';

    return formattedTime;
  }
}

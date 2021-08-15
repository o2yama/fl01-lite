import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final timeStreamProvider = StreamProvider((ref) => Clock.instance.watchTime());

class Clock {
  Clock._();
  static final instance = Clock._();

  Stream<DateTime> watchTime() {
    Stream<DateTime> timer = Stream.periodic(
      Duration(seconds: 1),
      (_) => DateTime.now(),
    );

    return timer;
  }
}

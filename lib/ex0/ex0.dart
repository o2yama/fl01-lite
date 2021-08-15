import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;

class Ex0 extends HookWidget {
  const Ex0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final luck = useState('大吉');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.red,
              child: Text(
                luck.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                var rand = math.Random();
                final num = rand.nextInt(10);
                print(num);
                if (num == 0) {
                  luck.value = '大凶';
                } else if (num == 1) {
                  luck.value = '凶';
                } else if (num <= 2) {
                  luck.value = '末吉';
                } else if (num <= 4) {
                  luck.value = '小吉';
                } else if (num <= 6) {
                  luck.value = '中吉';
                } else if (num <= 8) {
                  luck.value = '吉';
                } else {
                  luck.value = '大吉';
                }
              },
              child: Text(
                'あなたの運勢は？',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

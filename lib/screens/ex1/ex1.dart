import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'clock.dart';

class Ex1 extends HookWidget {
  const Ex1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeStream = useProvider(timeStreamProvider.stream);

    return Scaffold(
      appBar: AppBar(title: Text('カウントダウンタイマー')),
      body: StreamBuilder<DateTime>(
          stream: timeStream,
          builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : Text(
                    DateFormat('hh:mm:ss').format(snapshot.data!),
                    style: TextStyle(fontSize: 50),
                  );
          }),
    );
  }
}

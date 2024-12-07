import 'package:allium/vm/machine.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var program = [
      0x01, 0x05, 0x01, 0x04, 0x03
    ];

    final vm = VirtualMachine(program: program);
    final result = vm.execute();

    print(result.error?.message ?? "no error");

    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

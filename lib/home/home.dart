import 'package:allium/vm/machine.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // counts down from 10, then halts at 0
  static const program = [
    0x02, 0xb,  // push 11
    0x02, 0x1,  // push 1
    0x05,       // sub
    0x09,       // out
    0x0b, 0x02, // jnz 2
    0x01        // halt
  ];

  static const loopTest = "push 11 push 1 sub out jnz 2 halt";
  static const divideByZeroStr = "push 1 push 0 div";

  final vm = VirtualMachine(
    programStr: loopTest
  );

  @override
  void initState() {
    exec();
    super.initState();
  }

  Future exec() async {
    var result = await vm.execute();
    print(result.error?.message ?? "no error");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
import 'package:allium/home/allium_button.dart';
import 'package:allium/vm/machine.dart';
import 'package:allium/vm/stack.dart';
import 'package:allium/vm/value.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final codeController = TextEditingController();
  final byteCodeController = TextEditingController();

  final List<String> stackValues = [];
  final List<String> consoleOutputs = [];

  late VirtualMachine vm;

  static const String CounterPreset = "push 11\npush 1\nsub\nout\njnz 2\nhalt";

  @override
  void initState() {
    super.initState();
    _initializeVM();
  }

  void _initializeVM() {
    vm = VirtualMachine(
      emitData: _onDataEmit,
    );
    stackValues.clear();
  }

  void _onDataEmit(VMStack stack, List<int> bytes) {
    setState(() {
      stackValues.clear();
      stackValues.addAll(stack.toList()
        .map((item) => (item as Number).value.toString())
      );
      
      byteCodeController.text = bytes.join(" ");
    });
  }

  void _resetVM() {
    setState(() {
      _initializeVM();
      consoleOutputs.clear();
    });
  }

  Future onExec() async {
    var result = await vm.execute(codeController.text);

    if (!result.isSuccess) {
      setState(() {
        consoleOutputs.add(result.error!.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 600,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: lightGrey,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildTextBox(codeController, hint: "Enter your code here..."),
                          _buildTextBox(byteCodeController),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _execButton(),
                          _resetButton(),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),
                  _buildStack(),
                ],
              ),
            ),
            _outputConsole()
          ],
        ),
      ),
    );
  }

  Widget _buildStack() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Stack",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black
              ),
            ),
          ),
          Container(
            width: 140, height: 238,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var val in stackValues)
                    _stackItem(val)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stackItem(String val) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              val,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextBox(TextEditingController controller, {String? hint}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 120, height: 212,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            maxLines: null,
            controller: controller,
            style: const TextStyle(
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _execButton() {
    return AlliumButton(
      onTap: onExec,
      text: "Execute",
      color: Colors.white,
    );
  }

  Widget _resetButton() {
    return AlliumButton(
      onTap: _resetVM,
      text: "Reset",
      color: const Color.fromARGB(255, 253, 175, 169),
      textColor: Colors.white,
    );
  }

  Widget _outputConsole() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 600,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: lightGrey,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            consoleOutputs.join("\n"),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
import 'dart:async';

import 'package:allium/home/allium_field.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:allium/home/allium_button.dart';
import 'package:allium/vm/machine.dart';
import 'package:allium/vm/stack.dart';
import 'package:allium/vm/value.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final codeController = TextEditingController();
  final byteCodeController = TextEditingController();
  final userInputController = TextEditingController();

  final List<String> stackValues = [];
  final List<String> consoleOutputs = [];
  
  void Function()? _resolveInput;

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
      getInput: () async {
        consoleOutputs.add("Awaiting user input...");
        setState(() {});

        final completer = Completer<String>();
        void resolveInput() {
          completer.complete(userInputController.text.trim());
        }

        _resolveInput = resolveInput;

        return await completer.future;
      },
    );

    stackValues.clear();
    consoleOutputs.clear();
  }


  void _onDataEmit(VMStack stack, List<String> bytes) {
    setState(() {
      stackValues.clear();
      stackValues.addAll(stack.toList().map((item) => (item as Number).value.toString()));

      byteCodeController.text = bytes.join(" ");
    });
  }

  void _resetVM() {
    setState(() {
      _initializeVM();
      consoleOutputs.clear();
    });
  }

  Future _onExec() async {
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
                          AlliumField(controller: codeController, hintText: "Enter your code here..."),
                          AlliumField(controller: byteCodeController),
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
            _outputConsole(),
            const SizedBox(height: 16),
            _userInputBox(),
            _userInputButton(),
          ],
        ),
      ),
    );
  }

  Widget _userInputButton() {
    return AlliumButton(
      onTap: () {
        if (_resolveInput != null) {
          _resolveInput!();
          _resolveInput = null;
        }
      },
      text: "Ok",
    );
  }

  Widget _userInputBox() {
    return AlliumField(
      controller: userInputController,
      hintText: "Enter user input here...",
      width: 600,
      height: 50,
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
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Container(
            width: 140,
            height: 238,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var val in stackValues) _stackItem(val),
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
            child: Text(val),
          ),
        ),
      ),
    );
  }

  Widget _execButton() {
    return AlliumButton(
      onTap: _onExec,
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
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:allium/home/widgets/allium_field.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:allium/home/widgets/allium_button.dart';
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
  final List<String> stdout = [];
  
  void Function()? _resolveInput;

  late VirtualMachine vm;

  static const double vmHeight = 280;
  static const double consoleHeight = 140;

  @override
  void initState() {
    super.initState();
    _initializeVM();
  }

  void _initializeVM() {
    vm = VirtualMachine(
      emitData: _onDataEmit,
      getInput: () async {
        consoleOutputs.add("awaiting user input...");
        setState(() {});

        final completer = Completer<String>();
        void resolveInput() {
          completer.complete(userInputController.text.trim());
        }

        _resolveInput = resolveInput;

        return await completer.future;
      },
    );
  }


  void _onDataEmit(VMStack stack, List<String> bytes, List<String> out) {
    setState(() {
      stackValues.clear();
      stackValues.addAll(stack.toList().map((item) => (item as Number).value.toString()));

      byteCodeController.text = bytes.join(" ");

      stdout.clear();
      stdout.addAll(out);

      print(stdout.length);
    });
  }

  void _resetVM() {
    setState(() {
      _initializeVM();
      consoleOutputs.clear();
      stdout.clear();
      stackValues.clear();
    });
  }

  Future _onExec() async {
    var result = await vm.execute(codeController.text);

    if (!result.isSuccess) {
      setState(() {
        consoleOutputs.add(result.error!.message);
        consoleOutputs.add("program finished exit code 1");
      });
    } 
    else {
      consoleOutputs.add("program finished exit code 0");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 600,
                  height: vmHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: lightGrey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _components(),
                      const Spacer(),
                      _buildStack(),
                    ],
                  ),
                ),
                _outputConsole(),
              ],
            ),
            _buildOutput()
          ],
        ),
      ),
    );
  }

  Widget _components() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AlliumField(
              maxLines: null,
              controller: codeController,
              hintText: "Enter code here..."
            ),
            AlliumField(
              width: 292,
              maxLines: null,
              readonly: true,
              controller: byteCodeController
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _execButton(),
            _resetButton(),
            _userInputBox(),
            _userInputButton(),
          ],
        ),
      ],
    );
  }

  Widget _userInputButton() {
    return AlliumButton(
      width: 40,
      color: Colors.white,
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
      readonly: false,
      controller: userInputController,
      width: 100,
      height: buttonHeight,
    );
  }

  Widget _buildOutput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: 120,
        height: vmHeight + consoleHeight + 8,
        decoration: BoxDecoration(
          border: Border.all(color: lightGrey, width: 4),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "stdout",
                style: font(
                  fontSize: 12
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                stdout.join("\n"),
                style: font(
                  fontSize: 14, 
                  color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStack() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 140,
        height: vmHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var val in stackValues) 
                _stackItem(val),
            ],
          ),
        ),
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
        height: consoleHeight,
        decoration: BoxDecoration(
          border: Border.all(color: lightGrey, width: 4),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            consoleOutputs.join("\n"),
            style: font(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

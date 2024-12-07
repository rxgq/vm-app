import 'dart:async';

import 'package:allium/home/widgets/common/allium_field.dart';
import 'package:allium/home/widgets/vm/console.dart';
import 'package:allium/home/widgets/vm/stack.dart';
import 'package:allium/home/widgets/vm/stdout.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:allium/home/widgets/common/allium_button.dart';
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

  bool _resetPressed = false;
  bool _isExecuting = false;

  @override
  void initState() {
    super.initState();
    _initializeVM();
  }

  void _initializeVM() {
    vm = VirtualMachine(
      emitData: _onDataEmit,
      getInput: () async {
        out("awaiting user input...");

        final completer = Completer<String>();
        void resolveInput() {
          completer.complete(userInputController.text.trim());
        }

        _resolveInput = resolveInput;

        return await completer.future;
      },
    );
  }


  bool _onDataEmit(VMStack stack, List<String> bytes, List<String> out) {
    if (_resetPressed) {
      return true;
    }

    setState(() {
      stackValues.clear();
      stackValues.addAll(stack.toList().map((item) => (item as Number).value.toString()));

      byteCodeController.text = bytes.join(" ");

      stdout.clear();
      stdout.addAll(out);
    });

    return false;
  }

  void out(String message) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 19);
    setState(() {
      consoleOutputs.add("[$timestamp] $message");
    });
  }

  void _resetVM() {
    if (_isExecuting) _resetPressed = true;
    _isExecuting = false;

    setState(() {
      _initializeVM();
      stdout.clear();
      stackValues.clear();
    });
  }

  Future _onExec() async {
    if (_isExecuting) return;

    _initializeVM();
    stdout.clear();
    stackValues.clear();

    _isExecuting = true;
    var result = await vm.execute(codeController.text);
    _isExecuting = false;

    _resetPressed = false;
    if (!result.isSuccess || _resetPressed) {
      out(result.error!.message);
      out("program finished exit code 1");
    } 
    else {
      out("program finished exit code 0");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
                          _vmComponents(),
                          const Spacer(),
                          VMStackBox(stackValues: stackValues),
                        ],
                      ),
                    ),
                    VMConsole(values: consoleOutputs)
                  ],
                ),
                VMStdout(stdout: stdout),
              ],
            ),
            _vmStats()
          ],
        ),
      ),
    );
  }

  Widget _vmComponents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AlliumField(
              header: "code",
              maxLines: null,
              controller: codeController,
              hintText: "Enter code here..."
            ),
            AlliumField(
              header: "bytecode",
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

  Widget _vmStats() {
    return Center(
      child: SizedBox(
        width: 720,
        child: Row(
          children: [
            _displayStat("Executing", _isExecuting),
          ],
        ),
      ),
    );
  }

  Widget _displayStat(String name, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        width: 180,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: lightGrey, width: 4),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "$name: ",
                style: font(
                  fontSize: 12
                ),
              ),
              Text(
                value.toString(),
                style: font(
                  fontSize: 12
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

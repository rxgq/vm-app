import 'package:allium/constants.dart';
import 'package:allium/vm/models/vm_operation.dart';
import 'package:flutter/material.dart';

class VmOperations extends StatefulWidget {
  const VmOperations({super.key});

  @override
  State<VmOperations> createState() => _VmOperationsState();
}

class _VmOperationsState extends State<VmOperations> {
  List<VmOperation> sortedOpCodes = [];

  @override
  void initState() {
    super.initState();
    operations.sort((a, b) => a.name.compareTo(b.name));
    sortedOpCodes = operations;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: vmWidth + stDoutWidth,
        decoration: BoxDecoration(
          border: Border.all(color: lightGrey, width: 4),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var op in sortedOpCodes)
              _opCodeInfo(op)
          ],
        ),
      ),
    );
  }

  Widget _opCodeInfo(VmOperation op) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _opHeader(op.name),
            _opCode(op.opCode),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _opHeader(String op) {
    return Text(
      op,
      style: font(
        fontSize: 18,
      ),
    );
  }

  Widget _opCode(int code) {
    return Text(
      getHexString(code),
      style: font(
        fontSize: 12,
      ),
    );
  }

  String getHexString(int num) {
    return "0x${num.toRadixString(16)} ($num)";
  }
}

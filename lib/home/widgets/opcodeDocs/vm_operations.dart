import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../vm/models/vm_operation.dart';

class VmOperations extends StatefulWidget {
  const VmOperations({super.key});

  @override
  State<VmOperations> createState() => _VmOperationsState();
}

class _VmOperationsState extends State<VmOperations> {
  List<VMOperation> sortedOpCodes = [];

  @override
  void initState() {
    super.initState();
    operations.sort((a, b) => a.name.compareTo(b.name));
    sortedOpCodes = operations;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        width: vmWidth + stDoutWidth + 8,
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

  Widget _opCodeInfo(VMOperation op) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _opHeader(op.name),
            _opCode(op.opCode),
            _opDesc(op.description),
            _opThrows(op.errorsThrown),

            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: lightGrey, width: 1)
              )
            ),

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

  Widget _opDesc(String desc) {
    return Text(
      desc,
      style: font(
        fontSize: 12,
      ),
    );
  }

  Widget _opThrows(List<String> throws) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "Throws:",
          style: font(
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (throws.isEmpty)
              Text(
                "  None",
                style: font(
                  fontSize: 12,
                ),
              ),
            for (var item in throws)
              Text(
                "  $item",
                style: font(
                  fontSize: 12,
                ),
              ),
          ],
        )
      ],
    );
  }

  String getHexString(int num) {
    return "0x${num.toRadixString(16)} ($num)";
  }
}
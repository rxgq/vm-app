import '../models/vm_operation.dart';

final class VMMacro {
  final String commandName;
  final List<VMOperation> operations;

  VMMacro({
    required this.commandName,
    required this.operations
  });
}


final class VmOperation {
  final String name;
  final int opCode;
  final String description;
  final List<String> errorsThrown;

  VmOperation({
    required this.name,
    required this.opCode,
    required this.description,
    required this.errorsThrown,
  });
}
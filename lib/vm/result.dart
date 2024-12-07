final class VMError {
  final String message;
  final int line;

  VMError({
    required this.message,
    this.line = 0,
  });
}

final class VMResult<T> {
  final bool isSuccess;
  final VMError? error;

  final T? value;

  static const _errorPrefix = "VM_ERROR:";

  VMResult._({
    required this.isSuccess,
    required this.error,
    required this.value
  });

  static VMResult ok<T>({T? value}) {
    return VMResult._(isSuccess: true, error: null, value: value);
  }

  static VMResult _err(VMError error) {
    return VMResult._(isSuccess: false, error: error, value: null);
  }

  static VMResult stackOverflow(int max) {
    return _err(VMError(
      message: "$_errorPrefix stack overflow, reached max items on stack: $max"
    ));
  }

  static VMResult stackUnderflow() {
    return _err(VMError(
      message: "$_errorPrefix stack underflow, attempted to pop or peek item on empty stack"
    ));
  }

  static VMResult expectedArgument(int op) {
    return _err(VMError(
      message: "$_errorPrefix expected argument after op: $op"
    ));
  }

  static VMResult expectedStackArgs(int argCount, int op) {
    return _err(VMError(
      message: "$_errorPrefix expected $argCount values on the stack to execute op: $op"
    ));
  }

  static VMResult divideByZero() {
    return _err(VMError(
      message: "$_errorPrefix attempted to divide by zero"
    ));
  }

  static VMResult undefinedOperation(String op) {
    return _err(VMError(
      message: "$_errorPrefix undefined operation: '$op'"
    ));
  }

  static VMResult undefinedOpCode(int op) {
    return _err(VMError(
      message: "$_errorPrefix undefined opcode: '$op'"
    ));
  }

  static VMResult expectedNumberType(String type) {
    return _err(VMError(
      message: "$_errorPrefix expected number, got: '$type'"
    ));
  }
}
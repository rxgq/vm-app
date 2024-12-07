final class VMError {
  final String message;
  final int line;

  VMError({
    required this.message,
    this.line = 0,
  });
}

final class VMResult {
  final bool isSuccess;
  final VMError? error;

  static const errorPrefix = "VM_ERROR:";

  VMResult._({
    required this.isSuccess,
    required this.error
  });

  static VMResult ok() {
    return VMResult._(isSuccess: true, error: null);
  }

  static VMResult _err(VMError error) {
    return VMResult._(isSuccess: false, error: error);
  }

  static VMResult undefinedOpCode(int opCode) {
    return _err(VMError(
      message: "$errorPrefix undefined opcode: '$opCode'"
    ));
  }

  static VMResult stackOverflow(int max) {
    return _err(VMError(
      message: "$errorPrefix stack overflow, reached max items on stack: $max"
    ));
  }

  static VMResult stackUnderflow() {
    return _err(VMError(
      message: "$errorPrefix stack underflow, attempted to pop item on empty stack"
    ));
  }

  static VMResult expectedArgument(int op) {
    return _err(VMError(
      message: "$errorPrefix expected argument after op: $op"
    ));
  }

  static VMResult expectedStackArgs(int argCount, int op) {
    return _err(VMError(
      message: "$errorPrefix expected $argCount values on the stack to execute op: $op"
    ));
  }

  static VMResult divideByZero() {
    return _err(VMError(
      message: "$errorPrefix attempted to divide by zero"
    ));
  } 
}
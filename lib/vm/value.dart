abstract class VMValue {
  const VMValue();

  @override
  String toString();
}

final class Number implements VMValue {
  final int value;

  const Number(this.value);

  @override
  String toString() => 'Number($value)';
}

final class Str implements VMValue {
  final String value;

  const Str(this.value);

  @override
  String toString() => 'Str("$value")';
}
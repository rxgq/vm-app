final class VMStack<T> {
  final _list = <T> [];

  void push(final T val) {
    _list.add(val);
  }

  T pop() {
    return _list.removeLast();
  }

  void dump() {
    print("\nStack:");
    for (final value in _list) {
      print("  ${value.toString()}");
    }
    print("\n");
  }

  T get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  int get length => _list.length;
}
import 'result.dart';

final class VirtualMachineParser {
  int _current = 0;

  final String _source;
  final _tokens = <int>[];

  final _labels = <String, int>{};

  static const Map<String, int> _opcodeMap = {
    'nop':  0x00,
    'hlt': 0x01,
    'push': 0x02,
    'pop':  0x03,
    'add':  0x04,
    'sub':  0x05,
    'mul':  0x06,
    'div':  0x07,
    'jmp':  0x08,
    'out':  0x09,
    'jz':   0x0a,
    'jnz':  0x0b,
    'in':   0x0c,
  };

  VirtualMachineParser({
    required String source
  }) : _source = source;

  VMResult parse() {
    int currentToken = 0;
    while (_current < _source.length) {
      if (_source[_current].trim().isEmpty) {
        _current++;
        continue;
      }

      final result = switch (_isAlpha(_source[_current])) {
        true  => _parseLabel(currentToken),
        _     => VMResult.ok()
      };
      currentToken++;

      if (!result.isSuccess) return result;

      if (_current < _source.length) {
        _current++;
      }
    } 

    _current = 0;
    while (_current < _source.length) {
      if (_source[_current].trim().isEmpty) {
        _current++;
        continue;
      }

      final result = switch (_isAlpha(_source[_current])) {
        true  => _parseOperation(),
        false => _parseNumber(),
      };

      if (!result.isSuccess) return result;

      if (_current < _source.length) {
        _current++;
      }
    }


    return VMResult.ok(value: _tokens);
  }

  VMResult _parseLabel(int _currentToken) {
    int start = _current;
    while (_current < _source.length && (_isAlpha(_source[_current]) || _source[_current] == ':')) {
      _current++;
    }

    final stmt = _source.substring(start, _current);
    if (stmt[stmt.length - 1] == ':') {
      return parseLabel(stmt.substring(0, stmt.length - 1), _currentToken);
    }

    return VMResult.ok();
  }

  VMResult _parseOperation() {
    int start = _current;
    while (_current < _source.length && (_isAlpha(_source[_current]) || _source[_current] == ':')) {
      _current++;
    }

    final stmt = _source.substring(start, _current);
    
    if (stmt[stmt.length - 1] == ':') {
      _tokens.add(0x00);
      return VMResult.ok();
    }

    if (_labels.keys.contains(stmt)) {
      _tokens.add(_labels[stmt]!);
      return VMResult.ok();
    }

    if (!_opcodeMap.containsKey(stmt)) {
      return VMResult.undefinedOperation(stmt);
    }

    _tokens.add(_opcodeMap[stmt]!);
    return VMResult.ok();
  }

  VMResult parseLabel(String label, int position) {
    _labels.addAll({label: position});

    return VMResult.ok();
  }

  bool _isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;

  bool _isAlpha(String str) => RegExp(r'^[a-zA-Z]$').hasMatch(str);

  VMResult _parseNumber() {
    final numStr = StringBuffer();

    while (_current < _source.length && (_isDigit(_source, _current) || _source[_current] == '-')) {
      numStr.write(_source[_current]);
      _current++;
    }
    _current--;

    final number = int.tryParse(numStr.toString());
    if (number == null) return VMResult.expectedNumberType(numStr.toString());

    _tokens.add(number);
    return VMResult.ok();
  }
}
import 'dart:async';
import 'dart:math' as math;

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart' as flutter show compute;
import 'package:flutter/foundation.dart' show ComputeCallback;

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

// for more information on this hack, see https://github.com/flutter/flutter/issues/24703#issuecomment-473335593
Future<R> compute<Q, R>(ComputeCallback<Q, R> callback, Q message) async {
  if (isInDebugMode) {
    return callback(message);
  }

  return await flutter.compute(callback, message);
}

dynamic apply(Function fn, [List<dynamic> args, Map<String, dynamic> namedArgs]) {
  return Function.apply(
    fn,
    args ?? <dynamic>[],
    symbolizeKeys(namedArgs ?? <String, dynamic>{})
  );
}

Map<Symbol, dynamic> symbolizeKeys(Map<String, dynamic> map) {
  final Map<Symbol, dynamic> result = <Symbol, dynamic>{};
  map.forEach((String k, dynamic v) { result[Symbol(k)] = v; });
  return result;
}

T find<T>(List<T> list, Function test) {
  if(!(list is List)) {
    return null;
  }

  final int index = list.indexWhere(test);
  return index >= 0
    ? list[index]
    : null
    ;
}


double clamp(double a, double val, double b) {
  return math.max(a, math.min(val, b));
}

bool isEmpty(String value) {
  return value == null || value.isEmpty;
}

bool isNotEmpty(String value) {
  return value != null && value.isNotEmpty;
}

// TODO: no return values
Function debounce(Function fn, Duration delay, { String debounceId }) {
  debounceId = debounceId ?? StackTrace.current.toString().split("\n")[1];

  return ([List<dynamic> args]) {
    EasyDebounce.debounce(debounceId, delay, () => apply(fn, args));
  };
}

Function throttle(Function fn, Duration delay) {
  Timer timer;
  DateTime lastExec = DateTime.now();

  void exec(List<dynamic> args) {
    lastExec = DateTime.now();
    apply(fn, args);
  }

  return ([List<dynamic> args]) {
    final Duration elapsed = DateTime.now().difference(lastExec);
    if(elapsed.compareTo(delay) >= 0) {
      exec(args);
    }

    if(timer != null) {
      timer.cancel();
    }
    timer = Timer(delay, () => exec(args));
  };
}

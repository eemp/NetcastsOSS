dynamic apply(Function fn, [List<dynamic> args, Map<String, dynamic> namedArgs]) {
  return Function.apply(
    fn,
    args ?? <dynamic>[],
    symbolizeKeys(namedArgs ?? <String, dynamic>{})
  );
}

Map<Symbol, dynamic> symbolizeKeys(Map<String, dynamic> map){
  final Map<Symbol, dynamic> result = <Symbol, dynamic>{};
  map.forEach((String k, dynamic v) { result[Symbol(k)] = v; });
  return result;
}

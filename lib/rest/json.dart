import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Json {
  const Json._(this._parsed);
  factory Json.fromString(String? jsonString) =>
      Json._(jsonString == null || jsonString.isEmpty
          ? null
          : json.decode(jsonString));

  final dynamic _parsed;

  bool? asBoolean() {
    if (_parsed is! bool) {
      if (_parsed is List && _parsed.length == 1) {
        return Json._(_parsed[0]).asBoolean();
      }
      return null;
    }
    return _parsed;
  }

  int? asInteger() {
    if (_parsed is! int) {
      if (_parsed is String) {
        return int.tryParse(_parsed);
      }
      if (_parsed is List && _parsed.length == 1) {
        return Json._(_parsed[0]).asInteger();
      }
      return null;
    }
    return _parsed;
  }

  double? asNumber() {
    if (_parsed is! num) {
      if (_parsed is List && _parsed.length == 1) {
        return Json._(_parsed[0]).asNumber();
      }
      return null;
    }
    return _parsed.toDouble();
  }

  String? asString() {
    if (_parsed is! String) {
      if (_parsed is! int) {
        if (_parsed is List && _parsed.length == 1) {
          return Json._(_parsed[0]).asString();
        }
        return null;
      }
      return _parsed.toString();
    }
    return _parsed;
  }

  DateTime? asDateTime() {
    if (_parsed is! String) {
      if (_parsed is List && _parsed.length == 1) {
        return Json._(_parsed[0]).asDateTime();
      }
      return null;
    }
    try {
      return DateTime.parse(_parsed);
    } on FormatException catch (_) {
      return null;
    }
  }

  List<int> asBase64Bytes() {
    if (_parsed is! String) {
      return [];
    }
    try {
      return base64.decode(_parsed).toList();
    } on FormatException catch (_) {
      return [];
    }
  }

  Iterable<Json> asIterable() {
    if (_parsed is! List) {
      if (_parsed != null) {
        return [this];
      }
      return [];
    }
    final List<dynamic> parsed = _parsed;
    // ignore: unnecessary_lambdas
    return parsed.map((dynamic d) => Json._(d));
  }

  List<T> asList<T>(T? Function(Json object) projection) => asIterable()
      .map((json) => _safeProjection(projection, json))
      .where((x) => x != null)
      .cast<T>()
      .toList(growable: false);

  List<T> asObjectList<T>(T? Function(JsonObject object) projection) {
    if (_parsed is! List) {
      if (_parsed is Map<String, dynamic>) {
        final obj = _safeObjectProjection(projection, asObject());
        if (obj == null) {
          return [];
        }
        return [obj];
      }
      return [];
    }
    final List<dynamic> parsed = _parsed;
    return parsed
        .map((dynamic d) =>
            _safeObjectProjection(projection, Json._(d).asObject()))
        .where((x) => x != null)
        .cast<T>()
        .toList(growable: false);
  }

  JsonObject asObject() {
    if (_parsed is! Map<String, dynamic>) {
      if (_parsed is List && _parsed.length == 1) {
        return Json._(_parsed[0]).asObject();
      }
      return const JsonObject(<String, dynamic>{});
    }
    return JsonObject(_parsed);
  }

  Map<String, T> asMap<T>(T? Function(Json json) projection) {
    if (_parsed is! Map<String, dynamic>) {
      if (_parsed is List && _parsed.length == 1) {
        return Json._(_parsed[0]).asMap(projection);
      }
      return {};
    }
    final map = <String, T>{};
    final Map<String, dynamic> parsed = _parsed;
    for (final entry in parsed.entries) {
      final p = _safeProjection(projection, Json._(entry.value));
      if (p != null) {
        map[entry.key] = p;
      }
    }
    return map;
  }
}

class JsonObject {
  const JsonObject(this._map);

  final Map<String, dynamic> _map;

  Map<String, dynamic> asMap() => Map.unmodifiable(_map);

  Json operator [](String key) => Json._(_map[key]);
  bool? boolean(String property) => this[property].asBoolean();
  bool mandatoryBoolean(String property) =>
      _mandatory(this[property].asBoolean(), property);
  int? integer(String property) => this[property].asInteger();
  int mandatoryInteger(String property) =>
      _mandatory(this[property].asInteger(), property);
  double? number(String property) => this[property].asNumber();
  double mandatoryNumber(String property) =>
      _mandatory(this[property].asNumber(), property);
  String? string(String property) => this[property].asString();
  String mandatoryString(String property) =>
      _mandatory(this[property].asString(), property);
  DateTime? dateTime(String property) => this[property].asDateTime();
  DateTime mandatoryDateTime(String property) =>
      _mandatory(this[property].asDateTime(), property);
  List<int> base64Bytes(String property) => this[property].asBase64Bytes();

  List<T> list<T>(String property, T? Function(Json json) projection) =>
      this[property].asList(_safeMapProjection(projection));

  T? object<T>(String property, T? Function(JsonObject json) projection) =>
      _map.containsKey(property)
          ? _safeObjectProjection(projection, this[property].asObject())
          : null;
  T mandatoryObject<T>(
          String property, T Function(JsonObject json) projection) =>
      _mandatory(_safeObjectProjection(projection, this[property].asObject()),
          property);
  List<T> objectList<T>(
          String property, T Function(JsonObject json) projection) =>
      this[property]
          .asList(_safeMapProjection((json) => projection(json.asObject())));
  Map<String, T> map<T>(String property, T? Function(Json json) projection) =>
      this[property].asMap(projection);
}

T _mandatory<T>(T? value, String path) {
  if (value == null) {
    throw ErrorDescription('Expected mandatory property $path');
  }
  return value;
}

T? _safeProjection<T>(T Function(Json json) projection, Json json) {
  try {
    return projection(json);
  } catch (_) {
    return null;
  }
}

T? _safeObjectProjection<T>(
    T? Function(JsonObject json) projection, JsonObject json) {
  try {
    return projection(json);
  } catch (_) {
    return null;
  }
}

typedef _Projection<T, TJson> = T Function(TJson json);

_Projection<T?, Json> _safeMapProjection<T>(
        T? Function(Json json) projection) =>
    (Json json) {
      try {
        return projection(json);
      } catch (e) {
        return null;
      }
    };

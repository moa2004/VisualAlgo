import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';

class AlgorithmSeedData {
  AlgorithmSeedData._();

  static const String dataAssetPath = 'assets/data/algorithms.json';

  static List<AlgorithmModel>? _cachedAlgorithms;
  static List<Map<String, dynamic>>? _cachedRaw;

  static String _fixEncoding(String input) {
    if (input.isEmpty) return input;
    return input
        .replaceAll(r'\u00e2\u20ac\u201c', '–') 
        .replaceAll('â€“', '–')
        .replaceAll('â€”', '—')
        .replaceAll('â€˜', "'")
        .replaceAll('â€™', "'")
        .replaceAll('â€œ', '"')
        .replaceAll('â€', '"');
  }

  static Future<List<Map<String, dynamic>>> loadRaw() async {
    if (_cachedRaw != null) return _cachedRaw!;

    final raw = await rootBundle.loadString(dataAssetPath);

    final fixedRaw = raw
        .replaceAll(r'\u00e2\u20ac\u201c', '–')
        .replaceAll(r'\u00e2\u20ac\u201d', '—')
        .replaceAll(r'\u00e2\u20ac\u2122', "'");

    final decoded = jsonDecode(fixedRaw) as List<dynamic>;
    _cachedRaw = decoded.whereType<Map<String, dynamic>>().toList();

    _cachedRaw = _cachedRaw!.map((e) {
      return e.map((key, value) {
        if (value is String) {
          return MapEntry(key, _fixEncoding(value));
        }
        return MapEntry(key, value);
      });
    }).toList();

    return _cachedRaw!;
  }

  static Future<List<AlgorithmModel>> loadCatalog() async {
    if (_cachedAlgorithms != null) return _cachedAlgorithms!;
    final raw = await loadRaw();
    _cachedAlgorithms = raw.map(AlgorithmModel.fromJson).toList();
    return _cachedAlgorithms!;
  }
}

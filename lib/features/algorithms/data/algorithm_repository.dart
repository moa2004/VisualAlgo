import 'package:visual_algo/features/algorithms/data/algorithm_seed_data.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';

class AlgorithmRepository {
  AlgorithmRepository();

  List<AlgorithmModel>? _cachedCatalog;

  Future<List<AlgorithmModel>> loadCatalog() async {
    if (_cachedCatalog != null) return _cachedCatalog!;
    _cachedCatalog = await AlgorithmSeedData.loadCatalog();
    return _cachedCatalog!;
  }

  Future<AlgorithmModel?> findById(String id) async {
    final catalog = await loadCatalog();
    for (final algorithm in catalog) {
      if (algorithm.id == id) {
        return algorithm;
      }
    }
    return null;
  }
}

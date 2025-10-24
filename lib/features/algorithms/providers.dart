import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visual_algo/features/algorithms/data/algorithm_repository.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';

final algorithmRepositoryProvider = Provider<AlgorithmRepository>((ref) {
  return AlgorithmRepository();
});

final algorithmCatalogProvider = FutureProvider<List<AlgorithmModel>>((
  ref,
) async {
  final repository = ref.watch(algorithmRepositoryProvider);
  return repository.loadCatalog();
});

final algorithmDetailProvider = FutureProvider.family<AlgorithmModel?, String>((
  ref,
  id,
) async {
  final repository = ref.watch(algorithmRepositoryProvider);
  return repository.findById(id);
});

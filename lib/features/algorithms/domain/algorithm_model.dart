import 'package:visual_algo/features/algorithms/domain/algorithm_complexity.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_step.dart';

class AlgorithmModel {
  const AlgorithmModel({
    required this.id,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.description,
    required this.complexity,
    required this.codeSnippets,
    required this.steps,
    this.tags = const [],
  });

  final String id;
  final String name;
  final String category;
  final String difficulty;
  final String description;
  final AlgorithmComplexity complexity;
  final Map<String, String> codeSnippets;
  final List<AlgorithmStep> steps;
  final List<String> tags;

  factory AlgorithmModel.fromJson(Map<String, dynamic> json) {
    return AlgorithmModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String? ?? 'Intermediate',
      description: json['description'] as String? ?? '',
      complexity: AlgorithmComplexity.fromJson(
        json['complexity'] as Map<String, dynamic>? ?? const {},
      ),
      codeSnippets: (json['codeSnippets'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, value as String),
      ),
      steps: (json['steps'] as List<dynamic>? ?? [])
          .map((step) => AlgorithmStep.fromJson(step as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((tag) => tag as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'difficulty': difficulty,
      'description': description,
      'complexity': complexity.toJson(),
      'codeSnippets': codeSnippets,
      'steps': steps.map((step) => step.toJson()).toList(),
      'tags': tags,
    };
  }
}

import 'package:visual_algo/features/algorithms/domain/whiteboard_models.dart';

class AlgorithmStep {
  const AlgorithmStep({
    required this.title,
    required this.description,
    this.frame = const WhiteboardFrame(),
  });

  final String title;
  final String description;
  final WhiteboardFrame frame;

  factory AlgorithmStep.fromJson(Map<String, dynamic> json) {
    return AlgorithmStep(
      title: json['title'] as String? ?? 'Step',
      description: json['description'] as String? ?? '',
      frame: json['frame'] != null
          ? WhiteboardFrame.fromJson(json['frame'] as Map<String, dynamic>)
          : const WhiteboardFrame(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'frame': frame.toJson(),
    };
  }
}

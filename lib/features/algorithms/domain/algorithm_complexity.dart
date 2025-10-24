class AlgorithmComplexity {
  const AlgorithmComplexity({
    required this.best,
    required this.average,
    required this.worst,
    required this.space,
  });

  final String best;
  final String average;
  final String worst;
  final String space;

  factory AlgorithmComplexity.fromJson(Map<String, dynamic> json) {
    return AlgorithmComplexity(
      best: json['best'] as String? ?? '-',
      average: json['average'] as String? ?? '-',
      worst: json['worst'] as String? ?? '-',
      space: json['space'] as String? ?? '-',
    );
  }

  Map<String, String> toJson() {
    return {'best': best, 'average': average, 'worst': worst, 'space': space};
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_step.dart';
import 'package:visual_algo/features/algorithms/presentation/widgets/whiteboard_canvas.dart';
import 'package:visual_algo/features/algorithms/presentation/widgets/algorithm_storyboard_builder.dart';

class AlgorithmVisualPlayer extends StatefulWidget {
  const AlgorithmVisualPlayer({super.key, required this.algorithm});

  final AlgorithmModel algorithm;

  @override
  State<AlgorithmVisualPlayer> createState() => _AlgorithmVisualPlayerState();
}

class _AlgorithmVisualPlayerState extends State<AlgorithmVisualPlayer> {
  int _currentStep = 0;
  Timer? _timer;

  late List<AlgorithmStep> _storyboard;

  @override
  void initState() {
    super.initState();
    _storyboard = AlgorithmStoryboardBuilder.build(widget.algorithm);
  }

  @override
  void didUpdateWidget(covariant AlgorithmVisualPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.algorithm.id != widget.algorithm.id) {
      _timer?.cancel();
      _currentStep = 0;
      _storyboard = AlgorithmStoryboardBuilder.build(widget.algorithm);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleAutoPlay() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
      setState(() {});
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      _nextStep();
    });
    setState(() {});
  }

  void _nextStep() {
    if (_currentStep >= _storyboard.length - 1) {
      _timer?.cancel();
      setState(() {
        _currentStep = 0;
      });
      return;
    }
    setState(() {
      _currentStep += 1;
    });
  }

  void _previousStep() {
    setState(() {
      _currentStep = (_currentStep - 1).clamp(0, _storyboard.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_storyboard.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white.withValues(alpha: 0.04),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.movie_filter_outlined,
              size: 48,
              color: AppColors.neonTeal,
            ),
            const SizedBox(height: 12),
            Text(
              'Visual sequence coming soon',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    final step = _storyboard[_currentStep];
    final isAutoPlaying = _timer?.isActive == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: WhiteboardCanvas(
              key: ValueKey(_currentStep),
              frame: step.frame,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            IconButton(
              onPressed: _previousStep,
              icon: const Icon(Icons.skip_previous_rounded),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _toggleAutoPlay,
              icon: Icon(
                isAutoPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
              ),
              iconSize: 42,
              color: AppColors.neonTeal,
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _nextStep,
              icon: const Icon(Icons.skip_next_rounded),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: (_currentStep + 1) / _storyboard.length,
                  minHeight: 6,
                  color: AppColors.neonTeal,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${_currentStep + 1}/${_storyboard.length}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          step.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(step.description, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

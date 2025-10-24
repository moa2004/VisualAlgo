import 'dart:math';
import 'dart:ui' as ui show lerpDouble;

import 'package:flutter/material.dart';
import 'package:visual_algo/core/constants/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key, this.child, this.animate = true});

  final Widget? child;
  final bool animate;

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  static const _particleCount = 36;

  AnimationController? _controller;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _particles = _generateParticles();
    if (widget.animate) {
      _controller = _createController()..repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && _controller == null) {
      _controller = _createController()..repeat(reverse: true);
    } else if (!widget.animate && _controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  AnimationController _createController() {
    return AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    );
  }

  List<_Particle> _generateParticles() {
    final random = Random(42);
    return List.generate(_particleCount, (_) {
      return _Particle(
        alignment: Offset(random.nextDouble(), random.nextDouble()),
        baseRadius: 1.2 + random.nextDouble() * 3.2,
        phase: random.nextDouble() * pi * 2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return _buildFrame(progress: 0.5);
    }
    return AnimatedBuilder(
      animation: _controller!,
      builder: (_, __) => _buildFrame(progress: _controller!.value),
    );
  }

  Widget _buildFrame({required double progress}) {
    final child = widget.child;
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1.15 + sin(progress * pi) * 0.15,
          colors: const [AppColors.midnightBlue, AppColors.deepNight],
          center: Alignment(
            ui.lerpDouble(-0.35, 0.35, progress)!,
            ui.lerpDouble(-0.25, 0.25, 1 - progress)!,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _ParticlePainter(
                  progress: progress,
                  particles: _particles,
                  animate: widget.animate,
                ),
              ),
            ),
          ),
          if (child != null) child,
        ],
      ),
    );
  }
}

class _Particle {
  const _Particle({
    required this.alignment,
    required this.baseRadius,
    required this.phase,
  });

  final Offset alignment;
  final double baseRadius;
  final double phase;
}

class _ParticlePainter extends CustomPainter {
  const _ParticlePainter({
    required this.progress,
    required this.particles,
    required this.animate,
  });

  final double progress;
  final List<_Particle> particles;
  final bool animate;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonTeal.withValues(alpha: 0.045)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final offset = Offset(
        particle.alignment.dx * size.width,
        particle.alignment.dy * size.height,
      );
      final radius =
          particle.baseRadius *
          (0.65 + sin(progress * pi * 2 + particle.phase) * 0.18);
      canvas.drawCircle(offset, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    if (!animate && !oldDelegate.animate) return false;
    return oldDelegate.progress != progress;
  }
}

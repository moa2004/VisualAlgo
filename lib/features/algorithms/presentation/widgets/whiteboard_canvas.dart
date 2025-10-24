import 'dart:math';
import 'package:flutter/material.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/features/algorithms/domain/whiteboard_models.dart';

class WhiteboardCanvas extends StatelessWidget {
  const WhiteboardCanvas({super.key, required this.frame});
  final WhiteboardFrame frame;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final normalizedNodes = _normalizeNodes(frame.nodes);
        final nodeLookup = {for (var node in normalizedNodes) node.id: node};

        // ⚙️ Smart scale logic:
        final autoScale = _computeAdaptiveScale(
          width: width,
          nodesCount: normalizedNodes.length,
          arraysCount: frame.arrays.fold(0, (s, a) => s + a.values.length),
        );

        return ClipRect(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 2.5,
            panEnabled: true,
            scaleEnabled: true,
            boundaryMargin: const EdgeInsets.all(80),
            child: Transform.scale(
              scale: autoScale,
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 🕸 Edges
                  Positioned.fill(
                    child: CustomPaint(
                      painter:
                          _EdgePainter(frame.edges, nodeLookup, width, height),
                    ),
                  ),

                  // 🟢 Nodes
                  ...normalizedNodes.map(
                    (node) => Positioned(
                      left: node.x * width - 32,
                      top: node.y * height - 32,
                      child: _NodeWidget(
                        node: node,
                        shrink: autoScale < 1,
                      ),
                    ),
                  ),

                  // 🟣 Pointers
                  ...frame.pointers.map(
                    (pointer) => _PointerWidget(
                      pointer: pointer,
                      nodeLookup: nodeLookup,
                      width: width,
                      height: height,
                    ),
                  ),

                  // 🧩 Arrays (responsive + scroll)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 12,
                          children: frame.arrays.map((a) {
                            return _ArrayWidget(a, shrink: autoScale < 1);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                  // 📝 Annotations
                  if (frame.annotations.isNotEmpty)
                    Positioned(
                      right: 16,
                      top: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: frame.annotations
                            .map(
                              (annotation) => Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.neonTeal
                                        .withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Text(
                                  annotation,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Normalize coordinates
  List<WhiteboardNode> _normalizeNodes(List<WhiteboardNode> nodes) {
    if (nodes.isEmpty) return nodes;
    final xs = nodes.map((n) => n.x).toList();
    final ys = nodes.map((n) => n.y).toList();
    final minX = xs.reduce(min);
    final maxX = xs.reduce(max);
    final minY = ys.reduce(min);
    final maxY = ys.reduce(max);
    if ((maxX - minX) <= 1 && (maxY - minY) <= 1) return nodes;

    return nodes
        .map(
          (n) => WhiteboardNode(
            id: n.id,
            label: n.label,
            x: (n.x - minX) / (maxX - minX),
            y: (n.y - minY) / (maxY - minY),
            highlight: n.highlight,
          ),
        )
        .toList();
  }

  /// 💡 Adaptive scale: only shrink when needed
  double _computeAdaptiveScale({
    required double width,
    required int nodesCount,
    required int arraysCount,
  }) {
    final totalElements = nodesCount + arraysCount;
    if (totalElements <= 20) return 1.0; // Large & clear for small sets
    if (totalElements <= 35) return 0.9;
    if (totalElements <= 50) return 0.8;
    if (totalElements <= 80) return 0.7;
    return 0.6; // Only shrink heavily for huge sets
  }
}

class _NodeWidget extends StatelessWidget {
  const _NodeWidget({required this.node, required this.shrink});
  final WhiteboardNode node;
  final bool shrink;

  @override
  Widget build(BuildContext context) {
    final size = shrink ? 48.0 : 64.0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: node.highlight
            ? AppColors.neonTeal.withValues(alpha: 0.9)
            : AppColors.midnightBlue,
        border: Border.all(
          color: node.highlight
              ? Colors.white
              : AppColors.neonTeal.withValues(alpha: 0.4),
          width: node.highlight ? 3 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonTeal.withValues(
              alpha: node.highlight ? 0.6 : 0.2,
            ),
            blurRadius: node.highlight ? 18 : 12,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          node.label,
          style: TextStyle(
            color: node.highlight ? AppColors.deepNight : Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: shrink ? 13 : 16,
          ),
        ),
      ),
    );
  }
}

class _EdgePainter extends CustomPainter {
  _EdgePainter(this.edges, this.lookup, this.width, this.height);
  final List<WhiteboardEdge> edges;
  final Map<String, WhiteboardNode> lookup;
  final double width;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withValues(alpha: 0.2);

    for (final edge in edges) {
      final fromNode = lookup[edge.from];
      final toNode = lookup[edge.to];
      if (fromNode == null || toNode == null) continue;

      final fromOffset = Offset(fromNode.x * width, fromNode.y * height);
      final toOffset = Offset(toNode.x * width, toNode.y * height);

      paint.color = edge.highlight
          ? AppColors.neonTeal
          : Colors.white.withValues(alpha: 0.25);
      canvas.drawLine(fromOffset, toOffset, paint);

      if (edge.directed) {
        final arrowPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = paint.color;
        final angle =
            atan2(toOffset.dy - fromOffset.dy, toOffset.dx - fromOffset.dx);
        const arrowSize = 12.0;
        final arrowPoint = toOffset - Offset(cos(angle) * 32, sin(angle) * 32);
        final path = Path()
          ..moveTo(arrowPoint.dx, arrowPoint.dy)
          ..lineTo(
            arrowPoint.dx - arrowSize * cos(angle - pi / 6),
            arrowPoint.dy - arrowSize * sin(angle - pi / 6),
          )
          ..lineTo(
            arrowPoint.dx - arrowSize * cos(angle + pi / 6),
            arrowPoint.dy - arrowSize * sin(angle + pi / 6),
          )
          ..close();
        canvas.drawPath(path, arrowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _EdgePainter oldDelegate) =>
      oldDelegate.edges != edges;
}

class _ArrayWidget extends StatelessWidget {
  const _ArrayWidget(this.array, {required this.shrink});
  final WhiteboardArray array;
  final bool shrink;

  @override
  Widget build(BuildContext context) {
    final fontSize = shrink ? 12.0 : 14.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(array.name,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: fontSize, color: Colors.white70)),
        const SizedBox(height: 6),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < array.values.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: EdgeInsets.symmetric(
                    horizontal: shrink ? 6 : 10,
                    vertical: shrink ? 5 : 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: array.highlightIndices.contains(i)
                        ? AppColors.neonTeal.withValues(alpha: 0.35)
                        : Colors.white.withValues(alpha: 0.08),
                    border: Border.all(
                      color: array.highlightIndices.contains(i)
                          ? AppColors.neonTeal
                          : Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    array.values[i],
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PointerWidget extends StatelessWidget {
  const _PointerWidget({
    required this.pointer,
    required this.nodeLookup,
    required this.width,
    required this.height,
  });

  final WhiteboardPointer pointer;
  final Map<String, WhiteboardNode> nodeLookup;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    Offset? origin;
    if (pointer.nodeId != null) {
      final node = nodeLookup[pointer.nodeId];
      if (node != null) {
        origin = Offset(node.x * width, node.y * height);
      }
    }

    return Positioned(
      left: (origin?.dx ?? width * 0.5) + pointer.offsetX,
      top: (origin?.dy ?? height * 0.2) + pointer.offsetY,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_right_alt, color: AppColors.neonTeal),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.neonTeal.withValues(alpha: 0.2),
              border: Border.all(color: AppColors.neonTeal),
            ),
            child: Text(
              pointer.label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

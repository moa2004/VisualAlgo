class WhiteboardFrame {
  const WhiteboardFrame({
    this.nodes = const [],
    this.edges = const [],
    this.arrays = const [],
    this.pointers = const [],
    this.annotations = const [],
  });

  final List<WhiteboardNode> nodes;
  final List<WhiteboardEdge> edges;
  final List<WhiteboardArray> arrays;
  final List<WhiteboardPointer> pointers;
  final List<String> annotations;

  factory WhiteboardFrame.fromJson(Map<String, dynamic> json) {
    return WhiteboardFrame(
      nodes: (json['nodes'] as List<dynamic>? ?? [])
          .map((node) => WhiteboardNode.fromJson(node as Map<String, dynamic>))
          .toList(),
      edges: (json['edges'] as List<dynamic>? ?? [])
          .map((edge) => WhiteboardEdge.fromJson(edge as Map<String, dynamic>))
          .toList(),
      arrays: (json['arrays'] as List<dynamic>? ?? [])
          .map(
            (array) => WhiteboardArray.fromJson(array as Map<String, dynamic>),
          )
          .toList(),
      pointers: (json['pointers'] as List<dynamic>? ?? [])
          .map(
            (pointer) =>
                WhiteboardPointer.fromJson(pointer as Map<String, dynamic>),
          )
          .toList(),
      annotations: (json['annotations'] as List<dynamic>? ?? [])
          .map((annotation) => annotation as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nodes': nodes.map((node) => node.toJson()).toList(),
      'edges': edges.map((edge) => edge.toJson()).toList(),
      'arrays': arrays.map((array) => array.toJson()).toList(),
      'pointers': pointers.map((pointer) => pointer.toJson()).toList(),
      'annotations': annotations,
    };
  }
}

class WhiteboardNode {
  const WhiteboardNode({
    required this.id,
    required this.label,
    required this.x,
    required this.y,
    this.highlight = false,
  });

  final String id;
  final String label;
  final double x;
  final double y;
  final bool highlight;

  factory WhiteboardNode.fromJson(Map<String, dynamic> json) {
    return WhiteboardNode(
      id: json['id'] as String,
      label: json['label'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      highlight: json['highlight'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'label': label, 'x': x, 'y': y, 'highlight': highlight};
  }
}

class WhiteboardEdge {
  const WhiteboardEdge({
    required this.from,
    required this.to,
    this.label,
    this.directed = true,
    this.highlight = false,
  });

  final String from;
  final String to;
  final String? label;
  final bool directed;
  final bool highlight;

  factory WhiteboardEdge.fromJson(Map<String, dynamic> json) {
    return WhiteboardEdge(
      from: json['from'] as String,
      to: json['to'] as String,
      label: json['label'] as String?,
      directed: json['directed'] as bool? ?? true,
      highlight: json['highlight'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'label': label,
      'directed': directed,
      'highlight': highlight,
    };
  }
}

class WhiteboardArray {
  const WhiteboardArray({
    required this.name,
    required this.values,
    this.highlightIndices = const [],
  });

  final String name;
  final List<String> values;
  final List<int> highlightIndices;

  factory WhiteboardArray.fromJson(Map<String, dynamic> json) {
    return WhiteboardArray(
      name: json['name'] as String,
      values: (json['values'] as List<dynamic>)
          .map((value) => '$value')
          .toList(),
      highlightIndices: (json['highlightIndices'] as List<dynamic>? ?? [])
          .map((e) => e as int)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
      'highlightIndices': highlightIndices,
    };
  }
}

class WhiteboardPointer {
  const WhiteboardPointer({
    required this.label,
    this.nodeId,
    this.arrayIndex,
    this.offsetX = 0,
    this.offsetY = 0,
  }) : assert(
         nodeId != null || arrayIndex != null,
         'Either nodeId or arrayIndex must be provided',
       );

  final String label;
  final String? nodeId;
  final int? arrayIndex;
  final double offsetX;
  final double offsetY;

  factory WhiteboardPointer.fromJson(Map<String, dynamic> json) {
    return WhiteboardPointer(
      label: json['label'] as String,
      nodeId: json['nodeId'] as String?,
      arrayIndex: json['arrayIndex'] as int?,
      offsetX: (json['offsetX'] as num?)?.toDouble() ?? 0,
      offsetY: (json['offsetY'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'nodeId': nodeId,
      'arrayIndex': arrayIndex,
      'offsetX': offsetX,
      'offsetY': offsetY,
    };
  }
}

import 'package:visual_algo/features/algorithms/domain/algorithm_model.dart';
import 'package:visual_algo/features/algorithms/domain/algorithm_step.dart';
import 'package:visual_algo/features/algorithms/domain/whiteboard_models.dart';

class AlgorithmStoryboardBuilder {
  const AlgorithmStoryboardBuilder._();

  static List<AlgorithmStep> build(AlgorithmModel algorithm) {
    switch (algorithm.id) {
      case 'binary_search':
        return _binarySearchStoryboard();
      case 'breadth_first_search':
        return _breadthFirstSearchStoryboard();
      case 'dijkstra':
        return _dijkstraStoryboard();
      case 'merge_sort':
        return _mergeSortStoryboard();
      case 'quick_sort':
        return _quickSortStoryboard();
      case 'heap_sort':
        return _heapSortStoryboard();
      case 'counting_sort':
        return _countingSortStoryboard();
      case 'radix_sort':
        return _radixSortStoryboard();
      case 'bucket_sort':
        return _bucketSortStoryboard();
      case 'bubble_sort':
        return _bubbleSortStoryboard();
      case 'insertion_sort':
        return _insertionSortStoryboard();
      case 'selection_sort':
        return _selectionSortStoryboard();
      case 'depth_first_search':
        return _depthFirstSearchStoryboard();
      case 'bellman_ford':
        return _bellmanFordStoryboard();
      case 'floyd_warshall':
        return _floydWarshallStoryboard();
      case 'prim_mst':
        return _primMstStoryboard();
      case 'kruskal_mst':
        return _kruskalMstStoryboard();
      case 'topological_sort_dfs':
        return _topologicalSortDfsStoryboard();
      case 'kosaraju_scc':
        return _kosarajuSccStoryboard();
      case 'disjoint_set_union':
        return _dsuStoryboard();
      case 'kahn_topological_sort':
        return _kahnTopoSortStoryboard();
      case 'tarjan_scc':
        return _tarjanSccStoryboard();
      case 'segment_tree':
        return _segmentTreeStoryboard();
      case 'fenwick_tree':
        return _fenwickTreeStoryboard();
      case 'binary_lifting_lca':
        return _binaryLiftingLcaStoryboard();
      case 'knapsack_01':
        return _knapsack01Storyboard();
      case 'longest_increasing_subsequence':
        return _lisStoryboard();
      case 'longest_common_subsequence':
        return _lcsStoryboard();
      case 'edit_distance':
        return _editDistanceStoryboard();
      case 'matrix_chain_multiplication':
        return _matrixChainStoryboard();
      case 'coin_change_min':
        return _coinChangeStoryboard();
      case 'kadane_algorithm':
        return _kadaneStoryboard();
      case 'floyd_cycle_detection':
        return _floydCycleStoryboard();
      case 'sieve_of_eratosthenes':
        return _sieveStoryboard();
      case 'miller_rabin_primality':
        return _millerRabinStoryboard();
      case 'binary_exponentiation':
        return _binaryExponentiationStoryboard();
      case 'fast_fourier_transform':
        return _fftStoryboard();
      case 'convex_hull_graham':
        return _grahamHullStoryboard();
      case 'line_sweep_interval_scheduling':
        return _lineSweepStoryboard();
      case 'two_sat':
        return _twoSatStoryboard();
      case 'kmp_string_matching':
        return _kmpStoryboard();
      case 'z_algorithm':
        return _zAlgorithmStoryboard();
      case 'rabin_karp':
        return _rabinKarpStoryboard();
      case 'manacher_algorithm':
        return _manacherStoryboard();
      case 'trie_prefix_tree':
        return _trieStoryboard();
      case 'avl_tree_insertion':
        return _avlStoryboard();
      case 'red_black_tree_insertion':
        return _redBlackStoryboard();
      case 'quickselect':
        return _quickselectStoryboard();
      case 'ternary_search_unimodal':
        return _ternaryStoryboard();
      case 'a_star_search':
        return _aStarStoryboard();
      default:
        if (algorithm.steps.length >= 4) return algorithm.steps;
        return algorithm.steps.isNotEmpty
            ? algorithm.steps
            : _fallbackStoryboard(algorithm);
    }
  }

  static List<AlgorithmStep> _trieStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: 'root',
        label: '(root)',
        x: 0.5,
        y: 0.1,
        highlight: true,
      ),
      const WhiteboardNode(id: 'a', label: 'a', x: 0.35, y: 0.3),
      const WhiteboardNode(id: 'b', label: 'b', x: 0.65, y: 0.3),
      const WhiteboardNode(id: 't', label: 't', x: 0.25, y: 0.5),
      const WhiteboardNode(id: 'p', label: 'p', x: 0.45, y: 0.5),
      const WhiteboardNode(id: 'e', label: 'e', x: 0.65, y: 0.5),
    ];
    final edges = [
      const WhiteboardEdge(from: 'root', to: 'a', directed: true),
      const WhiteboardEdge(from: 'root', to: 'b', directed: true),
      const WhiteboardEdge(from: 'a', to: 't', directed: true),
      const WhiteboardEdge(from: 'a', to: 'p', directed: true),
      const WhiteboardEdge(from: 'b', to: 'e', directed: true),
    ];

    return [
      AlgorithmStep(
        title: 'Initialize empty Trie',
        description: 'Start with root node having empty edges.',
        frame: WhiteboardFrame(
          nodes: [nodes.first],
          annotations: const ['Insert words sequentially'],
        ),
      ),
      AlgorithmStep(
        title: 'Insert "at"',
        description: 'Create edge a→t and mark t as end.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges.take(3).toList(),
          annotations: const ['EndOfWord flag'],
        ),
      ),
      AlgorithmStep(
        title: 'Insert "apple"',
        description: 'Reuse prefix "a", add nodes p,p,l,e. Mark e as end.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == 'p' || n.id == 'e'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          annotations: const ['Common prefix a reused'],
        ),
      ),
      AlgorithmStep(
        title: 'Insert "bee"',
        description: 'Create b→e→e chain, mark last e as end.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Multiple branches'],
        ),
      ),
      AlgorithmStep(
        title: 'Search "app"',
        description: 'Follow edges a→p→p. Not marked end → false.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Partial prefix found'],
        ),
      ),
      AlgorithmStep(
        title: 'Search "apple"',
        description: 'a→p→p→l→e ends at end flag → true.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Found word'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description:
            'Trie enables O(L) prefix lookup (L=word length). Space O(total chars).',
        frame: const WhiteboardFrame(
          annotations: ['Prefix tree with branching on chars'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _avlStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: '30',
        label: '30',
        x: 0.5,
        y: 0.1,
        highlight: true,
      ),
      const WhiteboardNode(id: '20', label: '20', x: 0.35, y: 0.3),
      const WhiteboardNode(id: '40', label: '40', x: 0.65, y: 0.3),
      const WhiteboardNode(id: '10', label: '10', x: 0.25, y: 0.5),
      const WhiteboardNode(id: '25', label: '25', x: 0.45, y: 0.5),
      const WhiteboardNode(id: '35', label: '35', x: 0.55, y: 0.5),
      const WhiteboardNode(id: '50', label: '50', x: 0.75, y: 0.5),
    ];
    final edges = [
      const WhiteboardEdge(from: '30', to: '20'),
      const WhiteboardEdge(from: '30', to: '40'),
      const WhiteboardEdge(from: '20', to: '10'),
      const WhiteboardEdge(from: '20', to: '25'),
      const WhiteboardEdge(from: '40', to: '35'),
      const WhiteboardEdge(from: '40', to: '50'),
    ];

    return [
      AlgorithmStep(
        title: 'Insert nodes',
        description: 'Insert BST-style: 30→20→40→10→25→35→50.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Standard BST insert'],
        ),
      ),
      AlgorithmStep(
        title: 'Detect imbalance',
        description: 'After inserting 10, node 30 has balance=2 (left-heavy).',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Rotate to rebalance'],
        ),
      ),
      AlgorithmStep(
        title: 'Perform right rotation at 30',
        description: 'Promote 20 to root, move 30 to right child.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == '20'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          annotations: const ['Single rotation'],
        ),
      ),
      AlgorithmStep(
        title: 'Insert 25',
        description: 'Balance(20)=0. Tree balanced.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['No rotation needed'],
        ),
      ),
      AlgorithmStep(
        title: 'Insert 35→50',
        description: 'Right subtree grows; check balance factors.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Keep |bf|≤1'],
        ),
      ),
      AlgorithmStep(
        title: 'Final balanced AVL tree',
        description: 'Each node |bf| ≤ 1. Height = O(log n).',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Balanced BST'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description:
            'Rotation types: LL, RR, LR, RL. Maintain O(log n) height.',
        frame: const WhiteboardFrame(
          annotations: ['Self-balancing after each insert'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _redBlackStoryboard() {
    return [
      AlgorithmStep(
        title: 'Insert new node',
        description:
            'Insert the key as in a regular Binary Search Tree (BST). Newly inserted node is always colored RED to maintain black-height balance flexibility.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Insert path',
              values: ['Root', '→ Left', '→ Right'],
            ),
            WhiteboardArray(name: 'New node', values: ['RED']),
          ],
          annotations: ['Every new node starts RED.'],
        ),
      ),
      AlgorithmStep(
        title: 'Case 1: Parent is black',
        description:
            'If the parent of the inserted node is BLACK, the tree remains valid (no two consecutive RED nodes). No fix needed.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Parent color', values: ['BLACK']),
            WhiteboardArray(name: 'Child color', values: ['RED']),
          ],
          annotations: ['Tree properties hold.'],
        ),
      ),
      AlgorithmStep(
        title: 'Case 2: Parent and Uncle are RED',
        description:
            'Violation: both parent (P) and uncle (U) are RED. Fix by recoloring: P→BLACK, U→BLACK, grandparent (G)→RED. Then re-evaluate at G because it might violate the rule upward.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Before', values: ['P=R', 'U=R', 'G=B']),
            WhiteboardArray(name: 'After', values: ['P=B', 'U=B', 'G=R']),
          ],
          annotations: ['Propagate fix upward to grandparent.'],
        ),
      ),
      AlgorithmStep(
        title: 'Case 3: Triangle configuration (LR or RL)',
        description:
            'If the new node and its parent form a triangle around the grandparent (e.g., left-right), rotate parent toward new node to linearize. Then proceed to Case 4.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Shape',
              values: ['LR → rotateLeft(P)', 'RL → rotateRight(P)'],
            ),
          ],
          annotations: ['Linearize structure before final rotation.'],
        ),
      ),
      AlgorithmStep(
        title: 'Case 4: Line configuration (LL or RR)',
        description:
            'If the new node and parent are on the same side (both left or both right), rotate the grandparent in the opposite direction (right for LL, left for RR). Then swap colors between parent and grandparent.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Action',
              values: ['LL → rotateRight(G)', 'RR → rotateLeft(G)'],
            ),
            WhiteboardArray(name: 'Recolor', values: ['P=B', 'G=R']),
          ],
          annotations: ['Restores black-height & removes double-red.'],
        ),
      ),
      AlgorithmStep(
        title: 'Ensure root is black',
        description:
            'Regardless of previous rotations, recolor the root to BLACK to ensure all paths start with a black node.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Root', values: ['BLACK']),
          ],
          annotations: ['Root must always be BLACK.'],
        ),
      ),
      AlgorithmStep(
        title: 'Visualize RB properties',
        description:
            '1️⃣ Each node is RED or BLACK.\n2️⃣ Root is BLACK.\n3️⃣ Leaves (NIL) are BLACK.\n4️⃣ Red node → both children BLACK.\n5️⃣ Every path has same black-height.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'RB Rules',
              values: [
                'Root black',
                'Leaves black',
                'No double red',
                'Equal black height',
              ],
            ),
          ],
          annotations: ['Invariant maintained after insertion.'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary & complexity',
        description:
            'Insertion uses ≤ 2 rotations and a few recolors. Balancing ensures tree height O(log n). Search, insert, delete remain O(log n).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Operations',
              values: ['Insert', 'Rotate', 'Recolor'],
            ),
            WhiteboardArray(name: 'Time', values: ['O(log n)']),
          ],
          annotations: ['Balanced via color + rotation.'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _quickselectStoryboard() {
    return [
      AlgorithmStep(
        title: 'Problem setup',
        description: 'Find k=3rd smallest in [7,2,1,6,8,5,3,4].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'arr',
              values: ['7', '2', '1', '6', '8', '5', '3', '4'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Choose pivot',
        description: 'Pick last element as pivot=4.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'pivot', values: ['4']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Partition',
        description:
            'Rearrange smaller left, larger right → [2,1,3,4,8,5,6,7]. Pivot index=3.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'partitioned',
              values: ['2', '1', '3', '4', '8', '5', '6', '7'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Compare k with pivot index',
        description:
            'k=3 < 3? =? If equal → found; else recurse left or right.',
        frame: const WhiteboardFrame(
          annotations: ['Pivot position guides recursion'],
        ),
      ),
      AlgorithmStep(
        title: 'Recurse left half',
        description: 'Subarray [2,1,3]. Pivot=3 → index=2 → found.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'subarray', values: ['2', '1', '3']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Return 3rd smallest = 3',
        description: 'Expected O(n), worst O(n²).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'result', values: ['3']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description:
            'Quickselect uses partition like Quicksort but recurses one side only.',
        frame: const WhiteboardFrame(
          annotations: ['Divide & conquer selection'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _ternaryStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: 'L',
        label: 'L=0',
        x: 0.1,
        y: 0.5,
        highlight: true,
      ),
      const WhiteboardNode(id: 'M1', label: 'mid1=3.33', x: 0.35, y: 0.3),
      const WhiteboardNode(id: 'M2', label: 'mid2=6.67', x: 0.65, y: 0.3),
      const WhiteboardNode(
        id: 'R',
        label: 'R=10',
        x: 0.9,
        y: 0.5,
        highlight: true,
      ),
    ];
    final edges = [
      const WhiteboardEdge(
        from: 'L',
        to: 'R',
        directed: false,
        label: 'Search interval',
      ),
      const WhiteboardEdge(
        from: 'M1',
        to: 'M2',
        directed: false,
        label: 'midpoints',
      ),
    ];

    return [
      AlgorithmStep(
        title: 'Define function and range',
        description:
            'We search for the maximum of a unimodal function f(x) = −(x−5.5)² + 30 over [0,10]. The curve rises, peaks near 5.5, then decreases.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'f(x)', values: ['unimodal ↑↓']),
            WhiteboardArray(name: 'Interval', values: ['l=0', 'r=10']),
          ],
          annotations: const ['Initial range for search'],
        ),
      ),
      AlgorithmStep(
        title: 'Compute midpoints',
        description:
            'Divide interval [l,r] into three parts: mid1 = l + (r−l)/3 = 3.33, mid2 = r − (r−l)/3 = 6.67.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'M1' || n.id == 'M2')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'midpoints', values: ['3.33', '6.67']),
          ],
          annotations: const ['Two test points per iteration'],
        ),
      ),
      AlgorithmStep(
        title: 'Evaluate f(mid1), f(mid2)',
        description:
            'Compute values: f(3.33) ≈ 27, f(6.67) ≈ 29. Since f(mid2) > f(mid1), discard the left third [0,3.33].',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'L' || n.id == 'M1')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      ),
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'f(mid1)', values: ['27']),
            WhiteboardArray(name: 'f(mid2)', values: ['29']),
          ],
          annotations: const ['Discard [L, mid1] region'],
        ),
      ),
      AlgorithmStep(
        title: 'Update search bounds',
        description:
            'Shift left boundary to mid1 → new interval [3.33,10]. We keep the region containing the higher value.',
        frame: WhiteboardFrame(
          nodes: [
            const WhiteboardNode(
              id: 'L2',
              label: 'L=3.33',
              x: 0.35,
              y: 0.5,
              highlight: true,
            ),
            const WhiteboardNode(
              id: 'M1b',
              label: 'mid1=5.55',
              x: 0.55,
              y: 0.3,
            ),
            const WhiteboardNode(
              id: 'M2b',
              label: 'mid2=8.33',
              x: 0.75,
              y: 0.3,
            ),
            const WhiteboardNode(
              id: 'R',
              label: 'R=10',
              x: 0.9,
              y: 0.5,
              highlight: true,
            ),
          ],
          edges: const [
            WhiteboardEdge(
              from: 'L2',
              to: 'R',
              directed: false,
              label: 'New search interval',
            ),
          ],
          arrays: const [
            WhiteboardArray(name: 'Interval', values: ['[3.33, 10]']),
          ],
          annotations: const ['New narrowed interval'],
        ),
      ),
      AlgorithmStep(
        title: 'Repeat until convergence',
        description:
            'Recalculate new midpoints each time and compare f(mid1), f(mid2). Continue until |r−l| < ε (very small).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Iterations',
              values: ['[3.33,10]', '[4,8]', '[5,6]', '[5.3,5.7]'],
            ),
          ],
          annotations: ['Each iteration removes 1/3 of the range'],
        ),
      ),
      AlgorithmStep(
        title: 'Converge near optimum',
        description:
            'Final interval becomes small around x ≈ 5.5. Return midpoint as the approximate maximum position.',
        frame: WhiteboardFrame(
          nodes: [
            const WhiteboardNode(
              id: 'L',
              label: '5.4',
              x: 0.45,
              y: 0.5,
              highlight: true,
            ),
            const WhiteboardNode(
              id: 'Peak',
              label: 'x* = 5.5',
              x: 0.55,
              y: 0.3,
              highlight: true,
            ),
            const WhiteboardNode(
              id: 'R',
              label: '5.6',
              x: 0.65,
              y: 0.5,
              highlight: true,
            ),
          ],
          edges: const [
            WhiteboardEdge(
              from: 'L',
              to: 'R',
              directed: false,
              label: 'final small interval',
            ),
          ],
          arrays: const [
            WhiteboardArray(name: 'x*', values: ['≈5.5']),
            WhiteboardArray(name: 'f(x*)', values: ['≈30']),
          ],
          annotations: const ['Peak located near 5.5'],
        ),
      ),
      AlgorithmStep(
        title: 'Applications',
        description:
            'Used in convex/unimodal optimization, game parameter tuning, or unimodal array max finding.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Applications',
              values: [
                'Convex optimization',
                'Physics simulations',
                'Game AI tuning',
                'Peak finding in arrays',
              ],
            ),
          ],
          annotations: ['Continuous optimization use cases'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary & Complexity',
        description:
            'Each iteration discards one-third of interval. Two evaluations per step. Total O(log(1/ε)) iterations until convergence.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Complexity', values: ['O(log(1/ε))']),
            WhiteboardArray(name: 'Evaluations per step', values: ['2']),
          ],
          annotations: ['Fast convergence for unimodal functions'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _aStarStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: 'S',
        label: 'Start',
        x: 0.2,
        y: 0.5,
        highlight: true,
      ),
      const WhiteboardNode(id: 'A', label: 'A', x: 0.4, y: 0.3),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.4, y: 0.7),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.6, y: 0.3),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.6, y: 0.7),
      const WhiteboardNode(id: 'G', label: 'Goal', x: 0.8, y: 0.5),
    ];
    final edges = [
      const WhiteboardEdge(from: 'S', to: 'A', label: '2'),
      const WhiteboardEdge(from: 'S', to: 'B', label: '3'),
      const WhiteboardEdge(from: 'A', to: 'C', label: '2'),
      const WhiteboardEdge(from: 'B', to: 'D', label: '2'),
      const WhiteboardEdge(from: 'C', to: 'G', label: '3'),
      const WhiteboardEdge(from: 'D', to: 'G', label: '2'),
    ];

    return [
      AlgorithmStep(
        title: 'Initialize open set',
        description: 'Add start node S with f=g+h. g=0, h=heuristic(S,G).',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Use priority queue by f'],
        ),
      ),
      AlgorithmStep(
        title: 'Expand S',
        description: 'Pop lowest f(S). Add neighbors A,B with updated costs.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Compute f=g+h'],
        ),
      ),
      AlgorithmStep(
        title: 'Compare f(A)=g+h vs f(B)=g+h',
        description: 'Select node with smaller f for expansion.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'f-values', values: ['A:6', 'B:7']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Expand A',
        description: 'Discover C via A: g(C)=g(A)+2. Add to open set.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Relax edges'],
        ),
      ),
      AlgorithmStep(
        title: 'Expand B',
        description: 'Check D via B: g(D)=5, f(D)=h(D)+5.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['D added'],
        ),
      ),
      AlgorithmStep(
        title: 'Choose lowest f (C vs D)',
        description: 'C→f=8, D→f=7 ⇒ expand D.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'open', values: ['C', 'D']),
            WhiteboardArray(name: 'expand', values: ['D']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Expand D → Goal',
        description: 'Relax edge D→G. Path found with minimal f.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges
              .map(
                (e) => e.to == 'G'
                    ? WhiteboardEdge(from: e.from, to: e.to, highlight: true)
                    : e,
              )
              .toList(),
          annotations: const ['Path: S→B→D→G'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description: 'A* uses f=g+h to guide search; optimal if h admissible.',
        frame: const WhiteboardFrame(annotations: ['Best-first + cost so far']),
      ),
    ];
  }

  static List<AlgorithmStep> _lineSweepStoryboard() {
    return [
      AlgorithmStep(
        title: 'Define intervals',
        description:
            'Given intervals [1,4], [2,5], [7,9], [3,6]. Goal: count overlaps or find max active.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'intervals',
              values: ['[1,4]', '[2,5]', '[7,9]', '[3,6]'],
            ),
          ],
          annotations: ['We’ll sweep across time axis'],
        ),
      ),
      AlgorithmStep(
        title: 'Convert to events',
        description: 'Each interval → (start,+1) and (end,−1) events.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'events',
              values: [
                '(1,+1)',
                '(2,+1)',
                '(3,+1)',
                '(4,−1)',
                '(5,−1)',
                '(6,−1)',
                '(7,+1)',
                '(9,−1)',
              ],
            ),
          ],
          annotations: ['sort by position, then by type'],
        ),
      ),
      AlgorithmStep(
        title: 'Sweep initialization',
        description: 'active=0, maxActive=0.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'active', values: ['0']),
            WhiteboardArray(name: 'maxActive', values: ['0']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Process event (1,+1)',
        description: 'active=1 → maxActive=1.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'position', values: ['1']),
            WhiteboardArray(name: 'active', values: ['1']),
          ],
          annotations: ['first interval starts'],
        ),
      ),
      AlgorithmStep(
        title: 'Process events (2,+1), (3,+1)',
        description: 'active increases to 3; maxActive updated.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'active', values: ['3']),
            WhiteboardArray(name: 'maxActive', values: ['3']),
          ],
          annotations: ['3 overlapping intervals'],
        ),
      ),
      AlgorithmStep(
        title: 'Process (4,−1),(5,−1),(6,−1)',
        description: 'Each end event decreases active count → returns to 0.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'active', values: ['2', '1', '0']),
          ],
          annotations: ['Intervals end'],
        ),
      ),
      AlgorithmStep(
        title: 'Process last interval (7,+1)…(9,−1)',
        description: 'active=1→0 again. maxActive stays 3.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'result', values: ['maxActive=3']),
          ],
          annotations: ['Peak overlap'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description:
            'Sort events O(n log n), sweep O(n). Used in interval scheduling & geometry.',
        frame: const WhiteboardFrame(
          annotations: ['Efficient 1D overlap tracking'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _twoSatStoryboard() {
    final nodes = [
      const WhiteboardNode(id: 'x', label: 'x', x: 0.25, y: 0.20),
      const WhiteboardNode(id: '¬x', label: '¬x', x: 0.25, y: 0.45),
      const WhiteboardNode(id: 'y', label: 'y', x: 0.55, y: 0.20),
      const WhiteboardNode(id: '¬y', label: '¬y', x: 0.55, y: 0.45),
    ];
    final edges = [
      const WhiteboardEdge(from: '¬x', to: 'y', directed: true),
      const WhiteboardEdge(from: '¬y', to: 'x', directed: true),
      const WhiteboardEdge(from: 'x', to: '¬y', directed: true),
      const WhiteboardEdge(from: 'y', to: '¬x', directed: true),
    ];

    return [
      AlgorithmStep(
        title: 'Input formula',
        description: '(x ∨ y) ∧ (¬x ∨ ¬y). Build implications ¬x→y, ¬y→x, etc.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Build 2n-node graph'],
        ),
      ),
      AlgorithmStep(
        title: 'Graph structure',
        description:
            'Each variable has x and ¬x nodes; edges encode implications.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Implication graph'],
        ),
      ),
      AlgorithmStep(
        title: 'Compute SCCs',
        description:
            'Run Kosaraju or Tarjan to find strongly connected components.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['SCC grouping'],
        ),
      ),
      AlgorithmStep(
        title: 'Check contradictions',
        description: 'If x and ¬x are in same SCC ⇒ UNSAT.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Separate SCC required'],
        ),
      ),
      AlgorithmStep(
        title: 'Topological order of SCCs',
        description: 'Assign truth values in reverse topological order.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'SCC order',
              values: ['S1:x', 'S2:¬y', 'S3:y', 'S4:¬x'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Assign values',
        description: 'If SCC(x) before SCC(¬x) ⇒ x=false, else true.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'assignment', values: ['x=true', 'y=false']),
          ],
          annotations: ['Satisfying assignment'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description: '2-SAT solvable in O(n+m) using SCC.',
        frame: const WhiteboardFrame(annotations: ['Linear-time SAT subclass']),
      ),
    ];
  }

  static List<AlgorithmStep> _rabinKarpStoryboard() {
    const text = ['a', 'b', 'a', 'b', 'c', 'a', 'b', 'a', 'b', 'c'];
    const pattern = ['a', 'b', 'c'];

    return [
      AlgorithmStep(
        title: 'Goal and setup',
        description:
            'Find all occurrences of P="abc" in T="ababcababc" efficiently using rolling hash.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Text (T)', values: text),
            WhiteboardArray(name: 'Pattern (P)', values: pattern),
          ],
          annotations: ['We will slide window of length m=3'],
        ),
      ),
      AlgorithmStep(
        title: 'Compute initial hashes',
        description:
            'Use base=26, mod=1e9+7. H(P)=a*26² + b*26¹ + c*26⁰ = 731. Compute same for first 3 chars of T.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Pattern (P)',
              values: pattern,
              highlightIndices: [0, 1, 2],
            ),
            WhiteboardArray(
              name: 'Text window T[0..2]',
              values: ['a', 'b', 'a'],
              highlightIndices: [0, 1, 2],
            ),
            WhiteboardArray(
              name: 'Hashes',
              values: ['H(P)=731', 'H(T[0..2])=703'],
            ),
          ],
          annotations: ['Compare hashes to detect potential matches'],
        ),
      ),
      AlgorithmStep(
        title: 'Slide window → i=1',
        description:
            'Remove old char a (26² term), add new char b. Rehash efficiently: newH = (oldH − a×26²)×26 + b.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'New window T[1..3]',
              values: ['b', 'a', 'b'],
              highlightIndices: [1, 2, 3],
            ),
            WhiteboardArray(name: 'Rolling Hash', values: ['≈980']),
          ],
          annotations: ['O(1) rehash per shift'],
        ),
      ),
      AlgorithmStep(
        title: 'Window i=2 → hash match',
        description:
            'Rehash → H(T[2..4])=731 matches H(P)=731 → possible match found. Verify substring.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Window T[2..4]',
              values: ['a', 'b', 'c'],
              highlightIndices: [2, 3, 4],
            ),
            WhiteboardArray(name: 'Hashes', values: ['H=731', 'Match!']),
          ],
          annotations: ['Possible collision → verify manually'],
        ),
      ),
      AlgorithmStep(
        title: 'Verify substring',
        description:
            'Compare P and T[2..4]: a=a, b=b, c=c → true match confirmed. Record start=2.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Pattern (P)',
              values: pattern,
              highlightIndices: [0, 1, 2],
            ),
            WhiteboardArray(
              name: 'Text segment',
              values: ['a', 'b', 'c'],
              highlightIndices: [2, 3, 4],
            ),
            WhiteboardArray(name: 'Matches', values: ['2']),
          ],
          annotations: ['Collision avoided via exact match'],
        ),
      ),
      AlgorithmStep(
        title: 'Continue rehashing windows',
        description:
            'Shift window right, compute new hashes until end. Another hash match at i=7 detected.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Window T[7..9]',
              values: ['a', 'b', 'c'],
              highlightIndices: [7, 8, 9],
            ),
            WhiteboardArray(name: 'Hashes', values: ['H=731', 'Match!']),
          ],
          annotations: ['Second match candidate found'],
        ),
      ),
      AlgorithmStep(
        title: 'Verify second match',
        description:
            'Compare T[7..9] with P: exact match confirmed. Record position 7.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Pattern (P)',
              values: pattern,
              highlightIndices: [0, 1, 2],
            ),
            WhiteboardArray(
              name: 'Text segment',
              values: ['a', 'b', 'c'],
              highlightIndices: [7, 8, 9],
            ),
            WhiteboardArray(name: 'Matches', values: ['2', '7']),
          ],
          annotations: ['Two total matches confirmed'],
        ),
      ),
      AlgorithmStep(
        title: 'Visualize rolling hash updates',
        description:
            'Each shift: subtract outgoing char * base^(m−1), multiply by base, add incoming char, mod 1e9+7.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Hash formula',
              values: ['Hᵢ₊₁ = ((Hᵢ − T[i]×26²)×26 + T[i+m]) mod M'],
            ),
          ],
          annotations: ['Efficient sliding hash update'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary & complexity',
        description:
            'Rabin–Karp uses a rolling hash to reduce comparisons. Average time O(n+m), worst O(nm) due to hash collisions. Matches at indices 2 and 7.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Text (T)', values: text),
            WhiteboardArray(name: 'Pattern (P)', values: pattern),
            WhiteboardArray(name: 'Matches', values: ['2', '7']),
          ],
          annotations: ['Hash + verification = efficient pattern search'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _kmpStoryboard() {
    const text = ['a', 'b', 'a', 'b', 'c', 'a', 'b', 'a', 'b', 'c'];
    const pattern = ['a', 'b', 'a', 'b', 'c'];

    return [
      AlgorithmStep(
        title: 'Goal & idea',
        description:
            'Search P inside T in O(n + m). Precompute LPS (longest proper prefix which is also suffix) to avoid rescanning the text.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Text (T)', values: text),
            WhiteboardArray(name: 'Pattern (P)', values: pattern),
            WhiteboardArray(name: 'LPS', values: ['?', '?', '?', '?', '?']),
          ],
          annotations: [
            'We will build LPS, then scan T using i (text) & j (pattern).',
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Build LPS: i=0',
        description:
            'LPS[0] = 0 by definition (no proper prefix/suffix for a single char).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [0],
            ),
            WhiteboardArray(
              name: 'LPS',
              values: ['0', '?', '?', '?', '?'],
              highlightIndices: [0],
            ),
          ],
          annotations: ['len = 0'],
        ),
      ),
      AlgorithmStep(
        title: 'Build LPS: i=1 (mismatch)',
        description:
            'Compare P[1]=b with P[len=0]=a → mismatch ⇒ LPS[1]=0, len stays 0.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [1, 0],
            ),
            WhiteboardArray(
              name: 'LPS',
              values: ['0', '0', '?', '?', '?'],
              highlightIndices: [1],
            ),
          ],
          annotations: ['fallback: len already 0'],
        ),
      ),
      AlgorithmStep(
        title: 'Build LPS: i=2 (match)',
        description: 'P[2]=a vs P[len=0]=a → match ⇒ len=1; LPS[2]=1.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [2, 0],
            ),
            WhiteboardArray(
              name: 'LPS',
              values: ['0', '0', '1', '?', '?'],
              highlightIndices: [2],
            ),
          ],
          annotations: ['len becomes 1'],
        ),
      ),
      AlgorithmStep(
        title: 'Build LPS: i=3 (match)',
        description: 'P[3]=b vs P[len=1]=b → match ⇒ len=2; LPS[3]=2.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [3, 1],
            ),
            WhiteboardArray(
              name: 'LPS',
              values: ['0', '0', '1', '2', '?'],
              highlightIndices: [3],
            ),
          ],
          annotations: ['len becomes 2'],
        ),
      ),
      AlgorithmStep(
        title: 'Build LPS: i=4 (fallbacks)',
        description:
            'P[4]=c vs P[len=2]=a → mismatch. Fallback len = LPS[len-1] = LPS[1] = 0. Compare c vs P[0]=a → mismatch again ⇒ LPS[4] = 0.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [4, 2, 0],
            ),
            WhiteboardArray(
              name: 'LPS',
              values: ['0', '0', '1', '2', '0'],
              highlightIndices: [4],
            ),
          ],
          annotations: ['final LPS = [0,0,1,2,0]'],
        ),
      ),
      AlgorithmStep(
        title: 'Scan: start (i=0, j=0)',
        description:
            'We compare T[i] and P[j]. On match advance both; on mismatch use LPS[j-1] to move j without moving i (unless j==0).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Text', values: text, highlightIndices: [0]),
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'LPS', values: ['0', '0', '1', '2', '0']),
          ],
          annotations: ['i=0, j=0'],
        ),
      ),
      AlgorithmStep(
        title: 'Scan: rolling matches',
        description:
            'Matches: a=b? yes (a), then b (j=1), a (j=2), b (j=3). Now i=4, j=4.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Text', values: text, highlightIndices: [4]),
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [4],
            ),
          ],
          annotations: ['matched so far: "abab" → j=4'],
        ),
      ),
      AlgorithmStep(
        title: 'Full match #1',
        description:
            'T[4]=c matches P[4]=c → j becomes 5 ⇒ one full occurrence ends at i=4. Record start = i - (m-1) = 0.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Text',
              values: text,
              highlightIndices: [0, 1, 2, 3, 4],
            ),
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [0, 1, 2, 3, 4],
            ),
            WhiteboardArray(name: 'Matches (start indices)', values: ['0']),
          ],
          annotations: ['Set j = LPS[4] = 0 to continue'],
        ),
      ),
      AlgorithmStep(
        title: 'Continue without rescanning',
        description:
            'After a full hit, set j = LPS[j-1] = LPS[4] = 0. i moves to 5. Compare T[5] with P[0].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Text', values: text, highlightIndices: [5]),
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'LPS', values: ['0', '0', '1', '2', '0']),
          ],
          annotations: ['i=5, j=0'],
        ),
      ),
      AlgorithmStep(
        title: 'Scan second window',
        description:
            'Again we match "ababc" starting at i=5. At i=9 & j=4 we match c → second full occurrence at start=5.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Text',
              values: text,
              highlightIndices: [5, 6, 7, 8, 9],
            ),
            WhiteboardArray(
              name: 'Pattern',
              values: pattern,
              highlightIndices: [0, 1, 2, 3, 4],
            ),
            WhiteboardArray(
              name: 'Matches (start indices)',
              values: ['0', '5'],
            ),
          ],
          annotations: ['Two matches found'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary & complexity',
        description:
            'KMP uses the LPS table to skip redundant comparisons. For T="ababcababc" and P="ababc", matches are at indices 0 and 5. Time O(n+m), space O(m).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Text', values: text),
            WhiteboardArray(name: 'Pattern', values: pattern),
            WhiteboardArray(name: 'LPS', values: ['0', '0', '1', '2', '0']),
            WhiteboardArray(name: 'Matches', values: ['0', '5']),
          ],
          annotations: ['No backtracking on the text'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _zAlgorithmStoryboard() {
    return [
      AlgorithmStep(
        title: 'Define string',
        description: 'S = "aabxaabxcaabxaabxay". Compute Z[i]=LCP(S, S[i..]).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'S',
              values: [
                'a',
                'a',
                'b',
                'x',
                'a',
                'a',
                'b',
                'x',
                'c',
                'a',
                'a',
                'b',
                'x',
                'a',
                'a',
                'b',
                'x',
                'a',
                'y',
              ],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Initialize window [L,R]',
        description: 'L=R=0. Z[0]=0 by convention.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Z', values: ['0', '?', '?', '?', '?']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Expand first prefix',
        description: 'Compare starting at i=1 → "aabx" matches 3 chars.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Z', values: ['0', '1', '0', '0']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Maintain [L,R] box',
        description: 'When inside [L,R], reuse Z value from mirrored index.',
        frame: const WhiteboardFrame(annotations: ['Optimize comparisons']),
      ),
      AlgorithmStep(
        title: 'Compute all Z values',
        description: 'Iterate i; update box as we expand new matches.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Z',
              values: ['0', '1', '0', '0', '4', '0', '0', '0', '0', '3'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Applications',
        description: 'Used in pattern matching: compute Z on P+"\$"+T.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'concat', values: ['P', '\$', 'T']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description:
            'O(n) time using sliding window. Similar idea to prefix-function in KMP.',
        frame: const WhiteboardFrame(
          annotations: ['Efficient string matching primitive'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _manacherStoryboard() {
    return [
      AlgorithmStep(
        title: 'Preprocess string',
        description: 'Transform S="abba" → "#a#b#b#a#" to handle even length.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'T',
              values: ['#', 'a', '#', 'b', '#', 'b', '#', 'a', '#'],
            ),
          ],
          annotations: ['insert delimiters'],
        ),
      ),
      AlgorithmStep(
        title: 'Initialize center & right',
        description: 'center=0, right=0. radius array P[i]=0.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'P', values: ['0', '0', '0', '0', '0']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Iterate over T',
        description:
            'For each i, mirror=i_mirror=2*center−i. Initialize P[i]=min(right−i, P[i_mirror]).',
        frame: const WhiteboardFrame(
          annotations: ['Use previously known palindromes'],
        ),
      ),
      AlgorithmStep(
        title: 'Expand palindrome around i',
        description: 'While T[i+P[i]+1]==T[i−P[i]−1] ⇒ increment P[i].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'example', values: ['i=4', 'P[i]=4']),
          ],
          annotations: ['abba fully matches'],
        ),
      ),
      AlgorithmStep(
        title: 'Update center/right',
        description: 'If i+P[i]>right ⇒ center=i; right=i+P[i].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'center', values: ['4']),
            WhiteboardArray(name: 'right', values: ['8']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Extract longest',
        description:
            'maxLen=max(P[i]); centerIndex=i; substring=(centerIndex−maxLen)/2.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'result', values: ['abba']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description: 'Linear-time palindrome detection using symmetry.',
        frame: const WhiteboardFrame(annotations: ['O(n) using mirror logic']),
      ),
    ];
  }

  static List<AlgorithmStep> _floydCycleStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: '1',
        label: '1',
        x: 0.10,
        y: 0.30,
        highlight: true,
      ),
      const WhiteboardNode(id: '2', label: '2', x: 0.22, y: 0.30),
      const WhiteboardNode(id: '3', label: '3', x: 0.34, y: 0.30),
      const WhiteboardNode(id: '4', label: '4', x: 0.46, y: 0.30),
      const WhiteboardNode(id: '5', label: '5', x: 0.58, y: 0.30),
      const WhiteboardNode(id: '6', label: '6', x: 0.70, y: 0.30),
      const WhiteboardNode(id: '7', label: '7', x: 0.82, y: 0.30),
      const WhiteboardNode(id: '8', label: '8', x: 0.82, y: 0.58),
    ];
    final edges = [
      const WhiteboardEdge(from: '1', to: '2'),
      const WhiteboardEdge(from: '2', to: '3'),
      const WhiteboardEdge(from: '3', to: '4'),
      const WhiteboardEdge(from: '4', to: '5'),
      const WhiteboardEdge(from: '5', to: '6'),
      const WhiteboardEdge(from: '6', to: '7'),
      const WhiteboardEdge(from: '7', to: '8'),
      const WhiteboardEdge(from: '8', to: '3'),
    ];

    return [
      AlgorithmStep(
        title: 'Initialize pointers',
        description:
            'Place slow and fast at head. If fast or fast.next becomes null → no cycle.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          pointers: const [
            WhiteboardPointer(label: 'slow', nodeId: '1', offsetY: -48),
            WhiteboardPointer(label: 'fast', nodeId: '1', offsetY: -80),
          ],
          annotations: const ['Head at node 1'],
        ),
      ),
      AlgorithmStep(
        title: 'Advance: slow +1, fast +2',
        description:
            'Move one step vs two. They diverge if there is a cycle or reach null if acyclic.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == '2' || n.id == '3')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          pointers: const [
            WhiteboardPointer(label: 'slow', nodeId: '2', offsetY: -48),
            WhiteboardPointer(label: 'fast', nodeId: '3', offsetY: -80),
          ],
          annotations: const ['slow at 2, fast at 3'],
        ),
      ),
      AlgorithmStep(
        title: 'Keep stepping',
        description: 'slow moves to 3, fast to 5; then slow 4, fast 7.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == '4' || n.id == '7')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          pointers: const [
            WhiteboardPointer(label: 'slow', nodeId: '4', offsetY: -48),
            WhiteboardPointer(label: 'fast', nodeId: '7', offsetY: -80),
          ],
          annotations: const ['Diverging speeds'],
        ),
      ),
      AlgorithmStep(
        title: 'Enter the cycle',
        description: 'fast wraps through the cycle: from 7→8→3. slow goes 4→5.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == '5' || n.id == '3')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => (e.from == '8' && e.to == '3')
                    ? WhiteboardEdge(from: e.from, to: e.to, highlight: true)
                    : e,
              )
              .toList(),
          pointers: const [
            WhiteboardPointer(label: 'slow', nodeId: '5', offsetY: -48),
            WhiteboardPointer(label: 'fast', nodeId: '3', offsetY: -80),
          ],
          annotations: const ['fast re-enters node 3'],
        ),
      ),
      AlgorithmStep(
        title: 'Meeting point detected',
        description:
            'After a few rounds, slow and fast meet inside the cycle (here at node 6).',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == '6'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          pointers: const [
            WhiteboardPointer(label: 'slow', nodeId: '6', offsetY: -48),
            WhiteboardPointer(label: 'fast', nodeId: '6', offsetY: -80),
          ],
          annotations: const ['Collision ⇒ cycle exists'],
        ),
      ),
      AlgorithmStep(
        title: 'Find cycle entry',
        description:
            'Move one pointer to head; advance both by 1. They meet at cycle entry.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == '1' || n.id == '3')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          pointers: const [
            WhiteboardPointer(
              label: 'ptr1 from head',
              nodeId: '1',
              offsetY: -70,
            ),
            WhiteboardPointer(
              label: 'ptr2 from meet',
              nodeId: '6',
              offsetY: -48,
            ),
          ],
          annotations: const ['Advance step-by-step'],
        ),
      ),
      AlgorithmStep(
        title: 'Cycle entry located',
        description: 'Both meet at node 3 → cycle entry.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == '3'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          pointers: const [
            WhiteboardPointer(label: 'entry', nodeId: '3', offsetY: -80),
          ],
          annotations: const ['Entry = node 3'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _sieveStoryboard() {
    const range = [
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
    ];

    return [
      AlgorithmStep(
        title: 'Initialize range',
        description:
            'Mark all numbers 2..N as potentially prime. We will cross off composites.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Numbers', values: range),
            WhiteboardArray(name: 'Composite flags', values: []),
          ],
          annotations: ['limit = ⌊√N⌋ = 5'],
        ),
      ),
      AlgorithmStep(
        title: 'p = 2: cross multiples',
        description: 'Cross 4,6,8,...,30 (start from 2²).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Numbers',
              values: range,
              highlightIndices: [
                2,
                4,
                6,
                8,
                10,
                12,
                14,
                16,
                18,
                20,
                22,
                24,
                26,
                28,
              ],
            ),
            WhiteboardArray(name: 'p', values: ['2']),
          ],
          annotations: ['Start crossing at 4'],
        ),
      ),
      AlgorithmStep(
        title: 'p = 3: cross multiples',
        description: 'Cross 9,12,15,18,21,24,27,30 (start from 3²).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Numbers',
              values: range,
              highlightIndices: [7, 10, 13, 16, 19, 22, 25, 28],
            ),
            WhiteboardArray(name: 'p', values: ['3']),
          ],
          annotations: ['Skip already crossed numbers'],
        ),
      ),
      AlgorithmStep(
        title: 'p = 5: cross multiples',
        description: 'Cross 25,30 (start from 25).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Numbers',
              values: range,
              highlightIndices: [23, 28],
            ),
            WhiteboardArray(name: 'p', values: ['5']),
          ],
          annotations: ['p > √N afterwards → stop'],
        ),
      ),
      AlgorithmStep(
        title: 'Collect primes',
        description: 'Remaining un-crossed numbers are primes.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Primes',
              values: ['2', '3', '5', '7', '11', '13', '17', '19', '23', '29'],
            ),
          ],
          annotations: ['Time O(n log log n), space O(n)'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _millerRabinStoryboard() {
    return [
      AlgorithmStep(
        title: 'Write n−1 as d · 2^s',
        description: 'For n=101 → n−1=100=25·2^2 ⇒ s=2, d=25 (odd).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'n', values: ['101']),
            WhiteboardArray(name: 'decomposition', values: ['s=2', 'd=25']),
          ],
          annotations: ['n must be odd > 2'],
        ),
      ),
      AlgorithmStep(
        title: 'Pick bases',
        description:
            'Choose small bases a (deterministic set for 32-bit). We try a ∈ {2,7,61}...',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'bases', values: ['2', '7', '61']),
          ],
          annotations: ['Run the test per base'],
        ),
      ),
      AlgorithmStep(
        title: 'Round for a = 2 (modular pow)',
        description: 'Compute x = a^d mod n = 2^25 mod 101 → x = 76.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'x', values: ['76']),
          ],
          annotations: ['Fast pow via binary exponentiation'],
        ),
      ),
      AlgorithmStep(
        title: 'Witness loop for a = 2',
        description:
            'If x==1 or x==n−1 pass; else square up to s−1 times: 76^2 ≡ 16, then 16^2 ≡ 54 (mod 101). None equals n−1 (=100).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'squarings', values: ['76', '16', '54']),
          ],
          annotations: ['Not n−1 → inconclusive yet'],
        ),
      ),
      AlgorithmStep(
        title: 'Decision for a = 2',
        description:
            'Because we did not hit 1 at start or n−1 in squarings, n would be composite. (But our picked numbers are illustrative; continue more bases for robustness.)',
        frame: const WhiteboardFrame(
          annotations: ['Any base that certifies composite → stop'],
        ),
      ),
      AlgorithmStep(
        title: 'Multiple bases strategy',
        description:
            'For real code, try fixed bases that are deterministic for 32/64-bit ranges, else few random bases give high confidence.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'deterministic sets',
              values: ['{2,7,61}', '{2,3,5,7,11,13}'],
            ),
          ],
          annotations: ['Error prob ≤ 4^{−k}'],
        ),
      ),
      AlgorithmStep(
        title: 'Summary',
        description:
            'Decompose n−1, test witnesses with powmod & squarings. Fast and practical for big integers.',
        frame: const WhiteboardFrame(
          annotations: ['Time: O(k log^3 n), Space: O(1)'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _binaryExponentiationStoryboard() {
    return [
      AlgorithmStep(
        title: 'Decompose exponent to bits',
        description:
            'Compute 3^13. Binary(13) = 1101₂ → process from LSB using square & multiply.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'base', values: ['3']),
            WhiteboardArray(
              name: 'exp bits (LSB→MSB)',
              values: ['1', '0', '1', '1'],
            ),
          ],
          annotations: ['ans = 1 initially'],
        ),
      ),
      AlgorithmStep(
        title: 'Bit 0 = 1 (multiply)',
        description: 'ans *= base → ans=3. Square base → 3²=9. Shift exp.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'ans', values: ['3']),
            WhiteboardArray(name: 'base', values: ['9']),
          ],
          annotations: ['after step 0'],
        ),
      ),
      AlgorithmStep(
        title: 'Bit 1 = 0 (skip multiply)',
        description: 'ans stays 3. Square base → 9²=81.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'ans', values: ['3']),
            WhiteboardArray(name: 'base', values: ['81']),
          ],
          annotations: ['after step 1'],
        ),
      ),
      AlgorithmStep(
        title: 'Bit 2 = 1 (multiply)',
        description: 'ans *= 81 → 243. Square base → 81²=6561.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'ans', values: ['243']),
            WhiteboardArray(name: 'base', values: ['6561']),
          ],
          annotations: ['after step 2'],
        ),
      ),
      AlgorithmStep(
        title: 'Bit 3 = 1 (multiply)',
        description: 'ans *= 6561 → 1594323. (final; exp exhausted)',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'ans', values: ['1594323']),
          ],
          annotations: ['3^13 = 1594323'],
        ),
      ),
      AlgorithmStep(
        title: 'Modular variant',
        description:
            'With modulus M, reduce after each multiply/square. Example: 3^13 mod 1000.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'trace (mod 1000)',
              values: [
                'ans=3',
                'base=9',
                'base=81',
                'ans=243',
                'base=561',
                'ans=… → 387',
              ],
            ),
          ],
          annotations: ['All ops mod M'],
        ),
      ),
      AlgorithmStep(
        title: 'Complexity',
        description:
            'Runs in O(log e) multiplications; each powmod uses O(log e) mult + reductions.',
        frame: const WhiteboardFrame(annotations: ['Square & multiply']),
      ),
    ];
  }

  static List<AlgorithmStep> _fftStoryboard() {
    final root = const WhiteboardNode(
      id: 'N8',
      label: 'FFT(8)',
      x: 0.50,
      y: 0.08,
      highlight: true,
    );
    final nodes = [
      root,
      const WhiteboardNode(id: 'E4', label: 'FFT(4) even', x: 0.25, y: 0.28),
      const WhiteboardNode(id: 'O4', label: 'FFT(4) odd', x: 0.75, y: 0.28),
      const WhiteboardNode(id: 'E2a', label: 'FFT(2)', x: 0.15, y: 0.48),
      const WhiteboardNode(id: 'E2b', label: 'FFT(2)', x: 0.35, y: 0.48),
      const WhiteboardNode(id: 'O2a', label: 'FFT(2)', x: 0.65, y: 0.48),
      const WhiteboardNode(id: 'O2b', label: 'FFT(2)', x: 0.85, y: 0.48),
    ];
    final edges = [
      const WhiteboardEdge(from: 'N8', to: 'E4', directed: false),
      const WhiteboardEdge(from: 'N8', to: 'O4', directed: false),
      const WhiteboardEdge(from: 'E4', to: 'E2a', directed: false),
      const WhiteboardEdge(from: 'E4', to: 'E2b', directed: false),
      const WhiteboardEdge(from: 'O4', to: 'O2a', directed: false),
      const WhiteboardEdge(from: 'O4', to: 'O2b', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Split even/odd',
        description:
            'Reorder input by even/odd indices. Recursively evaluate size-4 DFTs.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'a[0..7]',
              values: ['a0', 'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7'],
            ),
            WhiteboardArray(name: 'even', values: ['a0', 'a2', 'a4', 'a6']),
            WhiteboardArray(name: 'odd', values: ['a1', 'a3', 'a5', 'a7']),
          ],
          annotations: const ['Divide: 2 subproblems of size n/2'],
        ),
      ),
      AlgorithmStep(
        title: 'Recurse to size 2',
        description: 'Continue splitting until size=2 (base DFT).',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) =>
                    (n.id == 'E2a' ||
                        n.id == 'E2b' ||
                        n.id == 'O2a' ||
                        n.id == 'O2b')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          annotations: const ['Base DFT(2): [u,v] → [u+v, u−v]'],
        ),
      ),
      AlgorithmStep(
        title: 'Merge with twiddle factors',
        description:
            'Combine FFT(4) results: X_k = E_k + ω_n^k · O_k, X_{k+n/2} = E_k − ω_n^k · O_k.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'E[k]', values: ['E0', 'E1', 'E2', 'E3']),
            WhiteboardArray(name: 'O[k]', values: ['O0', 'O1', 'O2', 'O3']),
            WhiteboardArray(
              name: 'twiddles',
              values: ['ω^0', 'ω^1', 'ω^2', 'ω^3'],
            ),
          ],
          annotations: ['Combine pairwise'],
        ),
      ),
      AlgorithmStep(
        title: 'Butterflies',
        description:
            'Each pair forms a butterfly computation (add/sub after twiddle multiply).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'butterfly', values: ['(E0+O0)', '(E0−O0)']),
          ],
          annotations: ['Visualize cross edges as butterflies'],
        ),
      ),
      AlgorithmStep(
        title: 'Full output ordering',
        description:
            'Outputs X[0..7] are produced. (Bit-reversed input order → natural output).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'X',
              values: ['X0', 'X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7'],
            ),
          ],
          annotations: ['Time O(n log n)'],
        ),
      ),
      AlgorithmStep(
        title: 'IFFT note',
        description: 'Inverse FFT uses conjugate twiddles and scales by 1/n.',
        frame: const WhiteboardFrame(
          annotations: ['IFFT(ω) = (1/n) · FFT(ω̄)'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _grahamHullStoryboard() {
    final pts = [
      const WhiteboardNode(id: 'P1', label: 'P1', x: 0.20, y: 0.70),
      const WhiteboardNode(id: 'P2', label: 'P2', x: 0.35, y: 0.20),
      const WhiteboardNode(id: 'P3', label: 'P3', x: 0.75, y: 0.30),
      const WhiteboardNode(id: 'P4', label: 'P4', x: 0.60, y: 0.75),
      const WhiteboardNode(id: 'P5', label: 'P5', x: 0.28, y: 0.45),
      const WhiteboardNode(id: 'P6', label: 'P6', x: 0.50, y: 0.40),
      const WhiteboardNode(id: 'P7', label: 'P7', x: 0.82, y: 0.62),
    ];

    return [
      AlgorithmStep(
        title: 'Find pivot (lowest y, then leftmost)',
        description: 'Choose pivot P* with minimum y (break ties by x).',
        frame: WhiteboardFrame(
          nodes: pts
              .map(
                (n) => n.id == 'P2'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          annotations: const ['Pivot = P2'],
        ),
      ),
      AlgorithmStep(
        title: 'Sort by polar angle around pivot',
        description:
            'Sort all other points by angle w.r.t. pivot (increasing).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'angle order',
              values: ['P3', 'P7', 'P4', 'P1', 'P5', 'P6'],
            ),
          ],
          annotations: ['Collinear: keep farthest last'],
        ),
      ),
      AlgorithmStep(
        title: 'Initialize stack with first two',
        description: 'Push pivot and first point: [P2, P3].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'stack', values: ['P2', 'P3']),
          ],
          annotations: ['We will maintain counter-clockwise hull'],
        ),
      ),
      AlgorithmStep(
        title: 'Process next point P7',
        description: 'Turn(P2, P3, P7) is CCW → push. Stack = [P2, P3, P7].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'stack', values: ['P2', 'P3', 'P7']),
          ],
          annotations: ['Keep CCW turns'],
        ),
      ),
      AlgorithmStep(
        title: 'Process P4 (right turn → pop)',
        description:
            'Turn(P3, P7, P4) is CW → pop P7. Then Turn(P2, P3, P4) is CCW → push P4.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'stack', values: ['P2', 'P3', 'P4']),
          ],
          annotations: ['Pop until CCW'],
        ),
      ),
      AlgorithmStep(
        title: 'Process P1, then P5, then P6',
        description:
            'For each, pop while last turn is CW. Final hull stack stabilizes.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'stack', values: ['P2', 'P3', 'P4', 'P1']),
          ],
          annotations: ['Example final set'],
        ),
      ),
      AlgorithmStep(
        title: 'Draw hull edges',
        description: 'Connect stack in order and close polygon.',
        frame: WhiteboardFrame(
          nodes: pts
              .map(
                (n) =>
                    (n.id == 'P2' ||
                        n.id == 'P3' ||
                        n.id == 'P4' ||
                        n.id == 'P1')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: const [
            WhiteboardEdge(
              from: 'P2',
              to: 'P3',
              directed: false,
              highlight: true,
            ),
            WhiteboardEdge(
              from: 'P3',
              to: 'P4',
              directed: false,
              highlight: true,
            ),
            WhiteboardEdge(
              from: 'P4',
              to: 'P1',
              directed: false,
              highlight: true,
            ),
            WhiteboardEdge(
              from: 'P1',
              to: 'P2',
              directed: false,
              highlight: true,
            ),
          ],
          annotations: const ['Graham hull complete'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _lcsStoryboard() {
    return [
      AlgorithmStep(
        title: 'Initialize DP table',
        description:
            'Strings: X = "ABCBDAB", Y = "BDCAB". Initialize dp[i][0]=0, dp[0][j]=0.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'X',
              values: ['A', 'B', 'C', 'B', 'D', 'A', 'B'],
            ),
            WhiteboardArray(name: 'Y', values: ['B', 'D', 'C', 'A', 'B']),
          ],
          annotations: ['Empty prefixes = 0'],
        ),
      ),
      AlgorithmStep(
        title: 'Match B–B → dp[1][1]=1',
        description: 'First match found between X[1] and Y[1].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 1',
              values: ['0', '1', '1', '1', '1', '1'],
              highlightIndices: [1],
            ),
          ],
          annotations: ['dp[1][1]=1'],
        ),
      ),
      AlgorithmStep(
        title: 'Propagate Matches and Max',
        description: 'If match: dp[i][j]=dp[i-1][j-1]+1 else max(top,left).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp',
              values: [
                '0 1 1 1 1',
                '1 1 2 2 2',
                '1 2 2 3 3',
                '1 2 3 3 3',
                '1 2 3 4 4',
              ],
            ),
          ],
          annotations: ['DP filling in progress'],
        ),
      ),
      AlgorithmStep(
        title: 'Final LCS = "BCAB"',
        description: 'dp[m][n] = 4, sequence reconstructed from bottom-right.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Result', values: ['B', 'C', 'A', 'B']),
          ],
          annotations: ['Length = 4'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _editDistanceStoryboard() {
    return [
      AlgorithmStep(
        title: 'Define problem & base',
        description:
            'Compute minimum edits to transform "kitten" → "sitting". '
            'Let dp[i][j] = min edits to convert s[0..i) to t[0..j). Initialize first row/col.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 's', values: ['k', 'i', 't', 't', 'e', 'n']),
            WhiteboardArray(
              name: 't',
              values: ['s', 'i', 't', 't', 'i', 'n', 'g'],
            ),
            WhiteboardArray(name: 'dp row 0', values: ['0 1 2 3 4 5 6 7']),
            WhiteboardArray(name: 'dp row 1', values: ['1 . . . . . . .']),
          ],
          annotations: [
            'dp[0][j]=j (insertions), dp[i][0]=i (deletions)',
            'Transition: if s[i-1]==t[j-1] → dp[i-1][j-1], else 1+min(left,up,diag)',
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Fill row i=1 for "k"',
        description:
            'Compare "k" with each character of "sitting". Best for j=1 is substitute k→s (cost 1).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 1',
              values: ['1 1 2 3 4 5 6 7'],
              highlightIndices: [0],
            ),
          ],
          annotations: ['left=insert, up=delete, diag=substitute'],
        ),
      ),
      AlgorithmStep(
        title: 'Row i=2 adds "i"',
        description:
            'When matching j=2 (second char "i"), chars equal → take diagonal. Costs begin to drop.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 2',
              values: ['2 2 1 2 3 4 5 6'],
              highlightIndices: [2],
            ),
          ],
          annotations: ['Equal at (i=2, j=2) ⇒ copy diag 1'],
        ),
      ),
      AlgorithmStep(
        title: 'Row i=3 for "t"',
        description:
            'First "t" aligns well with j=3; equality uses diagonal again. Propagate mins around.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 3',
              values: ['3 3 2 1 2 3 4 5'],
              highlightIndices: [3],
            ),
          ],
          annotations: ['Equal at (3,3)'],
        ),
      ),
      AlgorithmStep(
        title: 'Row i=4 for second "t"',
        description:
            'Second "t" also matches t[4] (j=4 with 1-based indexing for dp), keeping low cost.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 4',
              values: ['4 4 3 2 1 2 3 4'],
              highlightIndices: [4],
            ),
          ],
          annotations: ['Equal at (4,4)'],
        ),
      ),
      AlgorithmStep(
        title: 'Row i=5 for "e"',
        description:
            '"e" vs "i" mismatches; choose 1 + min(left=2, up=2, diag=1)=2. Frontier rises slightly.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'dp row 5', values: ['5 5 4 3 2 2 3 4']),
          ],
          annotations: ['Mismatch → +1 + min(...)'],
        ),
      ),
      AlgorithmStep(
        title: 'Row i=6 for "n"',
        description:
            'At j=6 ("n") chars equal → dp=2; remaining j=7 requires insertion of "g".',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 6',
              values: ['6 6 5 4 3 3 2 3'],
              highlightIndices: [6, 7],
            ),
          ],
          annotations: ['Equal at (6,6), then insert "g"'],
        ),
      ),
      AlgorithmStep(
        title: 'Final distance and example edits',
        description:
            'Answer dp[6][7] = 3. One optimal sequence: substitute k→s, insert i before last n, append g.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Result', values: ['Edit distance = 3']),
          ],
          annotations: ['Trace back via argmin to reconstruct edits'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _matrixChainStoryboard() {
    return [
      AlgorithmStep(
        title: 'Define states & initialize diagonal',
        description:
            'Let m[i][j] be minimal scalars to multiply Ai..Aj (1-indexed). '
            'Base: m[i][i]=0 (single matrix). We will fill by chain length L=2..n.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'p (dims)',
              values: ['30', '35', '15', '5', '10', '20', '25'],
            ),
            WhiteboardArray(name: 'm diag', values: ['m[i][i]=0 for i=1..6']),
            WhiteboardArray(name: 's (splits)', values: ['empty']),
          ],
          annotations: [
            'Cost for split k: m[i][k] + m[k+1][j] + p[i-1]*p[k]*p[j]',
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Fill for chain length L=2 (adjacent pairs)',
        description:
            'm[1,2]=30*35*15=15750, m[2,3]=35*15*5=2625, m[3,4]=15*5*10=750, '
            'm[4,5]=5*10*20=1000, m[5,6]=10*20*25=5000. Split is the only k in each interval.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'm L=2 row-by-row',
              values: [
                'm[1,2]=15750 (k=1)',
                'm[2,3]=2625  (k=2)',
                'm[3,4]=750   (k=3)',
                'm[4,5]=1000  (k=4)',
                'm[5,6]=5000  (k=5)',
              ],
            ),
            WhiteboardArray(name: 's L=2', values: ['1', '2', '3', '4', '5']),
          ],
          annotations: ['First super-diagonal filled'],
        ),
      ),

      AlgorithmStep(
        title: 'L=3: interval [1,3]',
        description:
            'Try k=1: m[1,1]+m[2,3]+30*35*5 = 0+2625+5250=7875. '
            'Try k=2: m[1,2]+m[3,3]+30*15*5 = 15750+0+2250=18000. '
            'Pick 7875 with k=1.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'm[1,3] calc', values: ['7875']),
            WhiteboardArray(name: 's[1,3]', values: ['k=1']),
          ],
          annotations: ['Keep the minimum over k∈{1,2}'],
        ),
      ),
      AlgorithmStep(
        title: 'L=3: interval [2,4] and [3,5] and [4,6]',
        description:
            '[2,4]: min{ 2625+0+35*5*10=4375, 0+750+35*15*10=6000 } → 4375 (k=2). '
            '[3,5]: min{ 750+0+15*10*20=3750, 0+1000+15*5*20=2500 } → 2500 (k=4). '
            '[4,6]: min{1000+0+5*20*25=3500, 0+5000+5*10*25=6250 } → 3500 (k=4).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'm L=3 summary',
              values: [
                'm[2,4]=4375 (k=2)',
                'm[3,5]=2500 (k=4)',
                'm[4,6]=3500 (k=4)',
              ],
            ),
          ],
          annotations: ['Second super-diagonal filled'],
        ),
      ),
      AlgorithmStep(
        title: 'L=4: compute m[1,4]',
        description:
            'k=1:  m[1,1]+m[2,4]+30*35*10 = 0+4375+10500=14875\n'
            'k=2:  15750+750+30*15*10 = 15750+750+4500=21000\n'
            'k=3:  7875+0+30*5*10     = 7875+0+1500=9375  → pick 9375 at k=3.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'm[1,4]', values: ['9375']),
            WhiteboardArray(name: 'best split', values: ['k=3']),
          ],
          annotations: ['Try all k ∈ {1,2,3}'],
        ),
      ),
      AlgorithmStep(
        title: 'L=4: m[2,5] and m[3,6]',
        description:
            'm[2,5] = 2..5 (k∈{2,3,4}) = 7125 (best at k=4)\n'
            'm[3,6] = 3..6 (k∈{3,4,5}) = 5375 (best at k=5).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'm[2,5]', values: ['7125']),
            WhiteboardArray(name: 'm[3,6]', values: ['5375']),
          ],
          annotations: ['We keep both m and split s'],
        ),
      ),
      AlgorithmStep(
        title: 'L=5: compute m[1,5]',
        description:
            'k=1:  0+7125+30*35*20 = 0+7125+21000=28125\n'
            'k=2:  15750+2500+30*15*20 = 15750+2500+9000=27250\n'
            'k=3:  7875+1000+30*5*20 = 7875+1000+3000=11875\n'
            'k=4:  9375+0+30*10*20 = 9375+0+6000=15375  → pick 11875 (k=3).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'm[1,5]', values: ['11875']),
            WhiteboardArray(name: 's[1,5]', values: ['k=3']),
          ],
          annotations: ['Near-optimal substructure appears'],
        ),
      ),
      AlgorithmStep(
        title: 'L=5: compute m[2,6]',
        description:
            'k=2:  2625+5375+35*15*25 = 2625+5375+13125=21125\n'
            'k=3:  4375+5000+35*5*25  = 4375+5000+4375=13750\n'
            'k=4:  1000+? +35*10*25   = 1000+5000+8750=14750  (the middle term is m[5,6]=5000)\n'
            'k=5:  7125+0+35*20*25    = 7125+0+17500=24625  → pick 13750 (k=3).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'm[2,6]', values: ['13750']),
            WhiteboardArray(name: 's[2,6]', values: ['k=3']),
          ],
          annotations: ['Finish penultimate diagonal'],
        ),
      ),
      AlgorithmStep(
        title: 'L=6: final interval m[1,6]',
        description:
            'Try all k ∈ {1..5}:\n'
            'k=1:  0+13750 + 30*35*25 = 13750 + 26250 = 40000\n'
            'k=2:  15750+5375 + 30*15*25 = 21125 + 11250 = 32375\n'
            'k=3:  7875+5000 + 30*5*25 = 12875 + 3750 = 16625\n'
            'k=4:  9375+0   + 30*10*25 = 9375 + 7500 = 16875\n'
            'k=5:  11875+0  + 30*20*25 = 11875 + 15000 = 26875\n'
            'But using the standard tabulation the known optimum is 15125 with k=3 '
            'because subcosts m[1,3]=7875 and m[4,6]=3500 yield 7875+3500+ (30*5*25)=7875+3500+3750=15125.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'm[1,6] best', values: ['15125']),
            WhiteboardArray(name: 's[1,6]', values: ['k=3']),
          ],
          annotations: ['Use previously filled m[1,3] and m[4,6]'],
        ),
      ),
      AlgorithmStep(
        title: 'Reconstruct parenthesization using s-table',
        description:
            'From s[1,6]=3 ⇒ split at k=3 → (A1..A3)(A4..A6). '
            'Inside: s[1,3]=1 ⇒ (A1)(A2A3). Also s[4,6]=5 ⇒ (A4A5)A6. '
            'So the full form is ((A1 (A2 A3)) ((A4 A5) A6)).',
        frame: WhiteboardFrame(
          nodes: const [
            WhiteboardNode(
              id: 'root',
              label: '1..6',
              x: 0.5,
              y: 0.1,
              highlight: true,
            ),
            WhiteboardNode(
              id: 'L',
              label: '1..3',
              x: 0.25,
              y: 0.38,
              highlight: true,
            ),
            WhiteboardNode(
              id: 'R',
              label: '4..6',
              x: 0.75,
              y: 0.38,
              highlight: true,
            ),
            WhiteboardNode(id: 'LL', label: '1..1', x: 0.10, y: 0.7),
            WhiteboardNode(id: 'LR', label: '2..3', x: 0.40, y: 0.7),
            WhiteboardNode(id: 'RL', label: '4..5', x: 0.60, y: 0.7),
            WhiteboardNode(id: 'RR', label: '6..6', x: 0.90, y: 0.7),
          ],
          edges: const [
            WhiteboardEdge(
              from: 'root',
              to: 'L',
              directed: true,
              highlight: true,
            ),
            WhiteboardEdge(
              from: 'root',
              to: 'R',
              directed: true,
              highlight: true,
            ),
            WhiteboardEdge(from: 'L', to: 'LL', directed: true),
            WhiteboardEdge(from: 'L', to: 'LR', directed: true),
            WhiteboardEdge(from: 'R', to: 'RL', directed: true),
            WhiteboardEdge(from: 'R', to: 'RR', directed: true),
          ],
          arrays: const [
            WhiteboardArray(
              name: 'Parenthesization',
              values: ['((A1(A2A3))((A4A5)A6))'],
            ),
          ],
          annotations: ['Follow s[i][j] recursively'],
        ),
      ),
      AlgorithmStep(
        title: 'Complexity & takeaway',
        description:
            'We fill O(n^2) entries; each tries O(n) splits → O(n^3) time, O(n^2) space. '
            'DP enforces optimal substructure & overlapping subproblems.',
        frame: const WhiteboardFrame(
          annotations: ['Cost = 15125 for the textbook case'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _coinChangeStoryboard() {
    return [
      AlgorithmStep(
        title: 'State definition & base case',
        description:
            'dp[x] = min coins to make amount x. Initialize dp[0]=0 and others = ∞. '
            'We will iterate coins outer, amounts inner (bottom-up).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'coins', values: ['1', '2', '5']),
            WhiteboardArray(
              name: 'dp init (0..11)',
              values: [
                '0',
                '∞',
                '∞',
                '∞',
                '∞',
                '∞',
                '∞',
                '∞',
                '∞',
                '∞',
                '∞',
                '∞',
              ],
            ),
          ],
          annotations: ['Unreachable = ∞'],
        ),
      ),
      AlgorithmStep(
        title: 'Process coin = 1',
        description:
            'For x=1..11: dp[x]=min(dp[x], dp[x-1]+1). '
            'This simply sets dp[x]=x as a baseline.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp after coin 1',
              values: [
                '0',
                '1',
                '2',
                '3',
                '4',
                '5',
                '6',
                '7',
                '8',
                '9',
                '10',
                '11',
              ],
            ),
          ],
          annotations: ['Every amount reachable using 1s'],
        ),
      ),
      AlgorithmStep(
        title: 'Process coin = 2 (early updates)',
        description:
            'Update only x≥2. Even indices improve by using one more 2 instead of two 1s.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp after few 2s',
              values: [
                '0',
                '1',
                '1',
                '2',
                '2',
                '3',
                '3',
                '4',
                '4',
                '5',
                '5',
                '6',
              ],
            ),
          ],
          annotations: ['Examples: dp[4]=min(4, dp[2]+1=2)=2'],
        ),
      ),
      AlgorithmStep(
        title: 'Process coin = 5: first improvements',
        description:
            'For x≥5: dp[5]=1, dp[6]=min(3,dp[1]+1=2)=2, dp[7]=min(4,dp[2]+1=2)=2, dp[8]=min(4,dp[3]+1=3)=3, etc.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp while coin=5 iterates',
              values: [
                '0',
                '1',
                '1',
                '2',
                '2',
                '1',
                '2',
                '2',
                '3',
                '3',
                '2',
                '3',
              ],
            ),
          ],
          annotations: ['Big jumps reduce counts'],
        ),
      ),
      AlgorithmStep(
        title: 'Show transition equation explicitly',
        description:
            'Transition: dp[x] = min( dp[x], 1 + dp[x - coin] ), whenever x ≥ coin and dp[x-coin] ≠ ∞.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Equation',
              values: ['dp[x] = min(dp[x], 1 + dp[x-coin])'],
            ),
            WhiteboardArray(
              name: 'Example @ x=10',
              values: ['min(5+5, 2+2+2+2+2)=2'],
            ),
          ],
          annotations: ['Greedy is not sufficient in general → use DP'],
        ),
      ),
      AlgorithmStep(
        title: 'Backtrace how amount 11 is formed',
        description:
            'From dp[11]=3 we step to x=11-5=6 (because dp[6]=2), from dp[6]=2 to x=1, and from dp[1]=1 to 0. '
            'Thus 11 = 5 + 5 + 1.',
        frame: WhiteboardFrame(
          nodes: const [
            WhiteboardNode(
              id: '11',
              label: '11',
              x: 0.15,
              y: 0.25,
              highlight: true,
            ),
            WhiteboardNode(
              id: '6',
              label: '6',
              x: 0.40,
              y: 0.45,
              highlight: true,
            ),
            WhiteboardNode(
              id: '1',
              label: '1',
              x: 0.65,
              y: 0.65,
              highlight: true,
            ),
            WhiteboardNode(
              id: '0',
              label: '0',
              x: 0.88,
              y: 0.85,
              highlight: true,
            ),
          ],
          edges: const [
            WhiteboardEdge(
              from: '11',
              to: '6',
              directed: true,
              label: '-5',
              highlight: true,
            ),
            WhiteboardEdge(
              from: '6',
              to: '1',
              directed: true,
              label: '-5',
              highlight: true,
            ),
            WhiteboardEdge(
              from: '1',
              to: '0',
              directed: true,
              label: '-1',
              highlight: true,
            ),
          ],
          arrays: const [
            WhiteboardArray(name: 'Coins used', values: ['+5', '+5', '+1']),
          ],
          annotations: ['Follow predecessor x-coin with minimal dp'],
        ),
      ),
      AlgorithmStep(
        title: 'Edge cases & unreachable',
        description:
            'If some amounts are impossible with given coins, they remain ∞ and the answer is -1. '
            'Here every amount is reachable.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'dp[11]', values: ['3']),
          ],
          annotations: ['Return -1 only when dp[target]=∞'],
        ),
      ),
      AlgorithmStep(
        title: 'Complexity & final answer',
        description:
            'Time O(n * amount) with n=#coins, space O(amount). Final minimal coins for 11 is 3.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Answer', values: ['3 (5+5+1)']),
          ],
          annotations: ['1D DP is memory efficient'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _kadaneStoryboard() {
    const arr = ['-2', '1', '-3', '4', '-1', '2', '1', '-5', '4'];
    return [
      AlgorithmStep(
        title: 'Initialize',
        description:
            'Keep running sum "cur" and global max "best". Also track start/end of best window. '
            'cur = 0, best = -∞, bestL=0, bestR=-1.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'nums', values: arr, highlightIndices: [0]),
            WhiteboardArray(name: 'cur/best', values: ['cur=0', 'best=-∞']),
          ],
          annotations: ['cur = max(a[i], cur+a[i])'],
        ),
      ),
      AlgorithmStep(
        title: 'i=0, a=-2',
        description:
            'cur = max(-2, 0-2) = -2; best = -2; since cur<0, reset next start to i+1.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'cur', values: ['-2']),
            WhiteboardArray(name: 'best', values: ['-2']),
          ],
          annotations: ['negative cur → drop window'],
        ),
      ),
      AlgorithmStep(
        title: 'i=1, a=1',
        description:
            'cur = max(1, -2+1) = 1; best = max(-2,1)=1. best window [1,1].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'cur', values: ['1']),
            WhiteboardArray(name: 'best', values: ['1']),
            WhiteboardArray(name: 'best range', values: ['[1,1]']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'i=2, a=-3',
        description:
            'cur = max(-3, 1-3) = -2; best stays 1. Negative again → next start resets.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'cur', values: ['-2']),
            WhiteboardArray(name: 'best', values: ['1']),
          ],
          annotations: ['drop window again'],
        ),
      ),
      AlgorithmStep(
        title: 'i=3, a=4',
        description: 'cur = max(4, -2+4) = 4; best = 4; window becomes [3,3].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'cur', values: ['4']),
            WhiteboardArray(name: 'best', values: ['4']),
            WhiteboardArray(name: 'best range', values: ['[3,3]']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'i=4..6 expand window',
        description:
            'i=4: cur=4+(-1)=3 (keep), best=4; '
            'i=5: cur=3+2=5 → best=5, range [3,5]; '
            'i=6: cur=5+1=6 → best=6, range [3,6].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'cur progression', values: ['3', '5', '6']),
            WhiteboardArray(name: 'best progression', values: ['4', '5', '6']),
            WhiteboardArray(name: 'range', values: ['[3,6]']),
          ],
          annotations: ['greedy extend while cur≥0'],
        ),
      ),
      AlgorithmStep(
        title: 'i=7, a=-5',
        description:
            'cur = 6-5 = 1; best remains 6; window shrinks but stays valid.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'cur', values: ['1']),
            WhiteboardArray(name: 'best', values: ['6']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'i=8, a=4 & finalize',
        description:
            'cur = 1+4 = 5; best remains 6. Final best window is [3,6] → subarray [4,-1,2,1].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'best sum', values: ['6']),
            WhiteboardArray(name: 'best subarray', values: ['[4,-1,2,1]']),
          ],
          annotations: ['Return best'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _lisStoryboard() {
    const nums = ['10', '9', '2', '5', '3', '7', '101', '18'];

    return [
      AlgorithmStep(
        title: 'Initialize tails structure',
        description:
            'Maintain "tails[i]" = minimum possible tail value of an increasing subsequence of length i+1. Start empty.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [0]),
            WhiteboardArray(name: 'tails', values: []),
          ],
          annotations: ['Use binary search to place/replace.'],
        ),
      ),
      AlgorithmStep(
        title: 'Place 10 → tails = [10]',
        description:
            't=10 starts the first subsequence. LIS length so far = 1.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [0]),
            WhiteboardArray(
              name: 'tails',
              values: ['10'],
              highlightIndices: [0],
            ),
          ],
          annotations: ['length = 1'],
        ),
      ),
      AlgorithmStep(
        title: 'Process 9 → replace tails[0]',
        description:
            '9 < 10, so binary-search position 0 and replace. Smaller tail keeps options open.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [1]),
            WhiteboardArray(
              name: 'tails',
              values: ['9'],
              highlightIndices: [0],
            ),
          ],
          annotations: ['replace at pos 0'],
        ),
      ),
      AlgorithmStep(
        title: 'Process 2 → replace tails[0] again',
        description:
            '2 < 9, replace at pos 0. Still length = 1, but better tail.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [2]),
            WhiteboardArray(
              name: 'tails',
              values: ['2'],
              highlightIndices: [0],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Process 5 → extend length',
        description: '5 > 2, append at the end. Now LIS length becomes 2.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [3]),
            WhiteboardArray(
              name: 'tails',
              values: ['2', '5'],
              highlightIndices: [1],
            ),
          ],
          annotations: ['length = 2'],
        ),
      ),
      AlgorithmStep(
        title: 'Process 3 → replace tails[1]',
        description:
            'Binary-search finds position 1 (since 3 ≤ 5). Replace tails[1] with 3.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [4]),
            WhiteboardArray(
              name: 'tails',
              values: ['2', '3'],
              highlightIndices: [1],
            ),
          ],
          annotations: ['keep smaller tail at len=2'],
        ),
      ),
      AlgorithmStep(
        title: 'Process 7 → extend to length 3',
        description: '7 > 3, append. Length becomes 3.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [5]),
            WhiteboardArray(
              name: 'tails',
              values: ['2', '3', '7'],
              highlightIndices: [2],
            ),
          ],
          annotations: ['length = 3'],
        ),
      ),
      AlgorithmStep(
        title: 'Process 101 → extend to length 4',
        description:
            '101 is greater than the last tail (7), append to get length 4.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [6]),
            WhiteboardArray(
              name: 'tails',
              values: ['2', '3', '7', '101'],
              highlightIndices: [3],
            ),
          ],
          annotations: ['length = 4'],
        ),
      ),
      AlgorithmStep(
        title: 'Process 18 → replace tails[3]',
        description:
            '18 fits at position 3 (replace 101). Final tails = [2, 3, 7, 18]. Length = 4.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Nums', values: nums, highlightIndices: [7]),
            WhiteboardArray(
              name: 'tails',
              values: ['2', '3', '7', '18'],
              highlightIndices: [3],
            ),
          ],
          annotations: ['LIS length = 4'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _kosarajuSccStoryboard() {
    final nodes = [
      const WhiteboardNode(id: 'A', label: 'A', x: 0.18, y: 0.18),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.40, y: 0.15),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.30, y: 0.38),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.68, y: 0.25),
      const WhiteboardNode(id: 'E', label: 'E', x: 0.82, y: 0.48),
      const WhiteboardNode(id: 'F', label: 'F', x: 0.62, y: 0.62),
    ];
    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', directed: true),
      const WhiteboardEdge(from: 'B', to: 'C', directed: true),
      const WhiteboardEdge(from: 'C', to: 'A', directed: true),
      const WhiteboardEdge(from: 'B', to: 'D', directed: true),
      const WhiteboardEdge(from: 'D', to: 'E', directed: true),
      const WhiteboardEdge(from: 'E', to: 'D', directed: true),
      const WhiteboardEdge(from: 'E', to: 'F', directed: true),
    ];

    return [
      AlgorithmStep(
        title: 'Phase 1: DFS to compute finishing times',
        description:
            'Run DFS on the original graph. Each node is pushed to the stack when it finishes. We start from A.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == 'A'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Visited', values: ['A']),
            WhiteboardArray(name: 'Finish stack', values: []),
          ],
          annotations: const ['Push node after finishing all descendants'],
        ),
      ),
      AlgorithmStep(
        title: 'DFS explores the first SCC (A → B → C)',
        description:
            'DFS runs through A→B→C→A. All become visited, then finish in order: C, B, A (pushed to stack).',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'B' || n.id == 'C')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    (e.from == 'A' && e.to == 'B') ||
                        (e.from == 'B' && e.to == 'C') ||
                        (e.from == 'C' && e.to == 'A')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(name: 'Visited', values: ['A', 'B', 'C']),
            WhiteboardArray(name: 'Finish stack', values: ['C', 'B', 'A']),
          ],
          annotations: const ['Finish order (top): C, B, A'],
        ),
      ),
      AlgorithmStep(
        title: 'Continue DFS towards D, E, then F',
        description:
            'From B there is an edge to D. DFS visits D↔E cycle, then goes to F. Finish order adds: F, E, D.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'D' || n.id == 'E' || n.id == 'F')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    (e.from == 'D' && e.to == 'E') ||
                        (e.from == 'E' && e.to == 'D') ||
                        (e.from == 'E' && e.to == 'F')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Visited',
              values: ['A', 'B', 'C', 'D', 'E', 'F'],
            ),
            WhiteboardArray(
              name: 'Finish stack',
              values: ['C', 'B', 'A', 'F', 'E', 'D'],
            ),
          ],
          annotations: const [
            'Finish order stack (top→bottom): D, E, F, A, B, C',
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Phase 2: Reverse all edges',
        description:
            'Transpose the graph (reverse every edge). We will pop nodes from the stack and DFS on the reversed graph.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges
              .map(
                (e) => WhiteboardEdge(
                  from: e.to,
                  to: e.from,
                  directed: true,
                  highlight: true,
                  label: e.label,
                ),
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Finish stack',
              values: ['C', 'B', 'A', 'F', 'E', 'D'],
            ),
          ],
          annotations: const ['Transposed graph'],
        ),
      ),
      AlgorithmStep(
        title: 'Extract SCC #1 from stack top (D/E)',
        description:
            'Pop D: run DFS in the reversed graph to collect {D,E}. Mark them as SCC #1.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'D' || n.id == 'E')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: [
            const WhiteboardEdge(
              from: 'E',
              to: 'D',
              directed: true,
              highlight: true,
            ),
            const WhiteboardEdge(
              from: 'D',
              to: 'E',
              directed: true,
              highlight: true,
            ),
          ],
          arrays: const [
            WhiteboardArray(
              name: 'Finish stack (after pop D,E)',
              values: ['C', 'B', 'A', 'F'],
            ),
            WhiteboardArray(name: 'SCCs', values: ['{D,E}']),
          ],
          annotations: const ['Collect all reachable in reversed graph'],
        ),
      ),
      AlgorithmStep(
        title: 'Extract SCC #2 (F alone)',
        description: 'Pop F and DFS: no back edges → {F} is an SCC.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'F')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: const [],
          arrays: const [
            WhiteboardArray(
              name: 'Finish stack (after pop F)',
              values: ['C', 'B', 'A'],
            ),
            WhiteboardArray(name: 'SCCs', values: ['{D,E}', '{F}']),
          ],
          annotations: const ['Singleton SCC'],
        ),
      ),
      AlgorithmStep(
        title: 'Extract SCC #3 (A/B/C cycle)',
        description:
            'Pop A then DFS in reversed graph collects {A,B,C}. All SCCs are found.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'B' || n.id == 'C')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: [
            const WhiteboardEdge(
              from: 'B',
              to: 'A',
              directed: true,
              highlight: true,
            ),
            const WhiteboardEdge(
              from: 'C',
              to: 'B',
              directed: true,
              highlight: true,
            ),
            const WhiteboardEdge(
              from: 'A',
              to: 'C',
              directed: true,
              highlight: true,
            ),
          ],
          arrays: const [
            WhiteboardArray(name: 'Finish stack (empty)', values: []),
            WhiteboardArray(name: 'SCCs', values: ['{D,E}', '{F}', '{A,B,C}']),
          ],
          annotations: const ['Done: all SCCs extracted'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _dsuStoryboard() {
    return [
      AlgorithmStep(
        title: 'Initialize parent and rank',
        description:
            'Each element starts in its own set. parent[i]=i and rank[i]=0.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'parent',
              values: ['1', '2', '3', '4', '5', '6'],
            ),
            WhiteboardArray(
              name: 'rank',
              values: ['0', '0', '0', '0', '0', '0'],
            ),
          ],
          annotations: ['MakeSet for all elements'],
        ),
      ),
      AlgorithmStep(
        title: 'Union(1,2)',
        description:
            'Find leaders of 1 and 2. They differ → union by rank: parent[2]=1.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'parent',
              values: ['1', '1', '3', '4', '5', '6'],
              highlightIndices: [0, 1],
            ),
            WhiteboardArray(
              name: 'rank',
              values: ['1', '0', '0', '0', '0', '0'],
            ),
          ],
          annotations: ['Union by rank'],
        ),
      ),
      AlgorithmStep(
        title: 'Union(3,4)',
        description: 'Leaders are 3 and 4 → union. parent[4]=3.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'parent',
              values: ['1', '1', '3', '3', '5', '6'],
              highlightIndices: [2, 3],
            ),
            WhiteboardArray(
              name: 'rank',
              values: ['1', '0', '1', '0', '0', '0'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Union(2,3) → merges {1,2} with {3,4}',
        description:
            'Leader(2)=1 (path compression) and Leader(3)=3. Attach lower-rank root under higher-rank root.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'parent',
              values: ['1', '1', '1', '3', '5', '6'],
              highlightIndices: [1, 2],
            ),
            WhiteboardArray(
              name: 'rank',
              values: ['2', '0', '1', '0', '0', '0'],
            ),
          ],
          annotations: ['Sets now: {1,2,3,4}, {5}, {6}'],
        ),
      ),
      AlgorithmStep(
        title: 'Union(5,6)',
        description: 'Join 5 and 6 → parent[6]=5.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'parent',
              values: ['1', '1', '1', '3', '5', '5'],
              highlightIndices: [4, 5],
            ),
            WhiteboardArray(
              name: 'rank',
              values: ['2', '0', '1', '0', '1', '0'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Find(4) with path compression',
        description: 'Follow 4→3→1 then compress: parent[4]=1 and parent[3]=1.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'parent',
              values: ['1', '1', '1', '1', '5', '5'],
              highlightIndices: [2, 3],
            ),
            WhiteboardArray(
              name: 'rank',
              values: ['2', '0', '1', '0', '1', '0'],
            ),
          ],
          annotations: ['Path compression applied'],
        ),
      ),
      AlgorithmStep(
        title: 'Union(2,4) → same leader detected',
        description:
            'Leader(2)=1 and Leader(4)=1 → already in the same set. This would form a cycle in a graph scenario.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'parent',
              values: ['1', '1', '1', '1', '5', '5'],
            ),
            WhiteboardArray(
              name: 'rank',
              values: ['2', '0', '1', '0', '1', '0'],
            ),
          ],
          annotations: ['Cycle detection: rejected'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _kahnTopoSortStoryboard() {
    final nodes = [
      const WhiteboardNode(id: 'A', label: 'A', x: 0.15, y: 0.20),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.38, y: 0.18),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.62, y: 0.18),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.50, y: 0.55),
      const WhiteboardNode(id: 'E', label: 'E', x: 0.80, y: 0.60),
    ];
    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', directed: true),
      const WhiteboardEdge(from: 'A', to: 'C', directed: true),
      const WhiteboardEdge(from: 'B', to: 'D', directed: true),
      const WhiteboardEdge(from: 'C', to: 'D', directed: true),
      const WhiteboardEdge(from: 'D', to: 'E', directed: true),
    ];

    return [
      AlgorithmStep(
        title: 'Initialize indegrees and queue',
        description:
            'Compute indegree for each node. Push all nodes with indegree 0 into the queue.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == 'A'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'Indegree',
              values: ['A:0', 'B:1', 'C:1', 'D:2', 'E:1'],
            ),
            WhiteboardArray(
              name: 'Queue',
              values: ['A'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'Topo', values: []),
          ],
          annotations: const ['Start with indegree 0 vertices'],
        ),
      ),
      AlgorithmStep(
        title: 'Pop A, append to order, decrease neighbors',
        description:
            'Pop A from queue → append to topo. Decrease indegree of B and C; both become 0, so enqueue.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'B' || n.id == 'C')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => (e.from == 'A')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Indegree',
              values: ['A:0', 'B:0', 'C:0', 'D:2', 'E:1'],
            ),
            WhiteboardArray(
              name: 'Queue',
              values: ['B', 'C'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'Topo', values: ['A']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Process B',
        description:
            'Pop B. Append to topo, decrease indegree(D). If becomes 0, enqueue.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'B' || n.id == 'D')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => (e.from == 'B' && e.to == 'D')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Indegree',
              values: ['A:0', 'B:0', 'C:0', 'D:1', 'E:1'],
            ),
            WhiteboardArray(
              name: 'Queue',
              values: ['C'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'Topo', values: ['A', 'B']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Process C → D becomes 0',
        description: 'Pop C. Decrease indegree(D) to 0, enqueue D.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'C' || n.id == 'D')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => (e.from == 'C' && e.to == 'D')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Indegree',
              values: ['A:0', 'B:0', 'C:0', 'D:0', 'E:1'],
            ),
            WhiteboardArray(
              name: 'Queue',
              values: ['D'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'Topo', values: ['A', 'B', 'C']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Process D → E becomes 0',
        description: 'Pop D. Decrease indegree(E) to 0, enqueue E.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'D' || n.id == 'E')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => (e.from == 'D' && e.to == 'E')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Indegree',
              values: ['A:0', 'B:0', 'C:0', 'D:0', 'E:0'],
            ),
            WhiteboardArray(
              name: 'Queue',
              values: ['E'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'Topo', values: ['A', 'B', 'C', 'D']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Finish',
        description:
            'Pop E. Queue is empty and we collected all vertices → valid topological order.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => WhiteboardNode(
                  id: n.id,
                  label: n.label,
                  x: n.x,
                  y: n.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Topo', values: ['A', 'B', 'C', 'D', 'E']),
            WhiteboardArray(name: 'Queue', values: []),
          ],
          annotations: const ['If some vertices remain → there is a cycle'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _tarjanSccStoryboard() {
    final nodes = [
      const WhiteboardNode(id: 'A', label: 'A', x: 0.15, y: 0.20),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.40, y: 0.18),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.65, y: 0.20),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.30, y: 0.62),
      const WhiteboardNode(id: 'E', label: 'E', x: 0.75, y: 0.60),
    ];
    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', directed: true),
      const WhiteboardEdge(from: 'B', to: 'C', directed: true),
      const WhiteboardEdge(from: 'C', to: 'A', directed: true),
      const WhiteboardEdge(from: 'B', to: 'D', directed: true),
      const WhiteboardEdge(from: 'D', to: 'E', directed: true),
      const WhiteboardEdge(from: 'E', to: 'D', directed: true),
    ];

    return [
      AlgorithmStep(
        title: 'Initialize index/low arrays and stack',
        description:
            'index = -1 for all. Run DFS; upon visiting a node v, set index[v]=low[v]=time++, push v onto the stack.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == 'A'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'index',
              values: ['A:-', 'B:-', 'C:-', 'D:-', 'E:-'],
            ),
            WhiteboardArray(
              name: 'low',
              values: ['A:-', 'B:-', 'C:-', 'D:-', 'E:-'],
            ),
            WhiteboardArray(name: 'Stack', values: []),
          ],
          annotations: const ['time = 0'],
        ),
      ),
      AlgorithmStep(
        title: 'Visit A → B → C',
        description:
            'Push A,B,C on stack. Back-edge C→A updates low[C] to index[A].',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'B' || n.id == 'C')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    (e.from == 'C' && e.to == 'A') ||
                        (e.from == 'A' && e.to == 'B') ||
                        (e.from == 'B' && e.to == 'C')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'index',
              values: ['A:0', 'B:1', 'C:2', 'D:-', 'E:-'],
            ),
            WhiteboardArray(
              name: 'low',
              values: ['A:0', 'B:0', 'C:0', 'D:-', 'E:-'],
            ),
            WhiteboardArray(name: 'Stack', values: ['A', 'B', 'C']),
          ],
          annotations: const ['low[based on back-edges]'],
        ),
      ),
      AlgorithmStep(
        title: 'Root of SCC found at A (low==index)',
        description:
            'When returning to A, low[A]==index[A] → pop until A to form SCC: {A,B,C}.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'B' || n.id == 'C')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'index',
              values: ['A:0', 'B:1', 'C:2', 'D:-', 'E:-'],
            ),
            WhiteboardArray(
              name: 'low',
              values: ['A:0', 'B:0', 'C:0', 'D:-', 'E:-'],
            ),
            WhiteboardArray(name: 'Stack', values: []),
            WhiteboardArray(name: 'SCC', values: ['{A,B,C}']),
          ],
          annotations: const ['pop until A'],
        ),
      ),
      AlgorithmStep(
        title: 'Continue DFS via edge B→D',
        description:
            'Visit D then E and push onto stack. Mutual edges update low values.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'D' || n.id == 'E')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    ((e.from == 'D' && e.to == 'E') ||
                        (e.from == 'E' && e.to == 'D'))
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'index',
              values: ['A:0', 'B:1', 'C:2', 'D:3', 'E:4'],
            ),
            WhiteboardArray(
              name: 'low',
              values: ['A:0', 'B:0', 'C:0', 'D:3', 'E:3'],
            ),
            WhiteboardArray(name: 'Stack', values: ['D', 'E']),
            WhiteboardArray(name: 'SCC', values: ['{A,B,C}']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Root at D → second SCC',
        description: 'At D, low[D]==index[D] → pop until D to form {D,E}.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'D' || n.id == 'E')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Stack', values: []),
            WhiteboardArray(name: 'SCC', values: ['{A,B,C}', '{D,E}']),
          ],
          annotations: const ['All SCCs found'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _segmentTreeStoryboard() {
    final arr = ['2', '1', '5', '3', '4'];
    final nodes = [
      const WhiteboardNode(id: 'n1', label: '[0..4]', x: 0.50, y: 0.12),
      const WhiteboardNode(id: 'n2', label: '[0..2]', x: 0.30, y: 0.35),
      const WhiteboardNode(id: 'n3', label: '[3..4]', x: 0.70, y: 0.35),
      const WhiteboardNode(id: 'n4', label: '[0..1]', x: 0.18, y: 0.60),
      const WhiteboardNode(id: 'n5', label: '[2..2]', x: 0.42, y: 0.60),
      const WhiteboardNode(id: 'n6', label: '[3..3]', x: 0.58, y: 0.60),
      const WhiteboardNode(id: 'n7', label: '[4..4]', x: 0.82, y: 0.60),
    ];
    final edges = [
      const WhiteboardEdge(from: 'n1', to: 'n2', directed: false),
      const WhiteboardEdge(from: 'n1', to: 'n3', directed: false),
      const WhiteboardEdge(from: 'n2', to: 'n4', directed: false),
      const WhiteboardEdge(from: 'n2', to: 'n5', directed: false),
      const WhiteboardEdge(from: 'n3', to: 'n6', directed: false),
      const WhiteboardEdge(from: 'n3', to: 'n7', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Build: initialize leaves from the array',
        description:
            'Place array values on leaves: [0..1],[2..2],[3..3],[4..4]. Internal nodes will store sums.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) =>
                    (n.id == 'n4' ||
                        n.id == 'n5' ||
                        n.id == 'n6' ||
                        n.id == 'n7')
                    ? WhiteboardNode(
                        id: n.id,
                        label: '${n.label}\\nleaf',
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: [
            WhiteboardArray(
              name: 'arr',
              values: arr,
              highlightIndices: [0, 1, 2, 3, 4],
            ),
            const WhiteboardArray(
              name: 'tree',
              values: ['n4:2', 'n5:1', 'n6:5', 'n7:3/4? -> see build'],
            ),
          ],
          annotations: const ['Leaves reflect arr values'],
        ),
      ),
      AlgorithmStep(
        title: 'Build: compute parents bottom-up',
        description:
            'n4 = sum([0..1]) = 2+1=3, n5 = 5 on [2..2]? (correction: n5 is [2..2] so value=5). n6=[3..3]=3, n7=[4..4]=4. Then n2 = n4 + n5 = 3 + 5 = 8, n3 = n6 + n7 = 3 + 4 = 7, root n1 = 8 + 7 = 15.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => WhiteboardNode(
                  id: n.id,
                  label: n.label,
                  x: n.x,
                  y: n.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: edges
              .map(
                (e) => WhiteboardEdge(
                  from: e.from,
                  to: e.to,
                  directed: false,
                  highlight: true,
                ),
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'tree values',
              values: ['n4:3', 'n5:5', 'n6:3', 'n7:4', 'n2:8', 'n3:7', 'n1:15'],
            ),
          ],
          annotations: const ['Segment tree stores sums'],
        ),
      ),
      AlgorithmStep(
        title: 'Range query sum(1..3)',
        description:
            'Traverse: [0..4] splits to [0..2] and [3..4]. From [0..2] → take overlap [1..2]: n4([0..1]) contributes index 1 (=1) + n5([2..2]) (=5). From [3..4] → take n6([3..3]) (=3). Total = 1 + 5 + 3 = 9.',
        frame: WhiteboardFrame(
          nodes: nodes.map((n) {
            final ids = {'n2', 'n3', 'n4', 'n5', 'n6'};
            return ids.contains(n.id)
                ? WhiteboardNode(
                    id: n.id,
                    label: n.label,
                    x: n.x,
                    y: n.y,
                    highlight: true,
                  )
                : n;
          }).toList(),
          edges: edges.map((e) {
            final ids = {'n1-n2', 'n1-n3', 'n2-n4', 'n2-n5', 'n3-n6'};
            final key = '${e.from}-${e.to}';
            return ids.contains(key)
                ? WhiteboardEdge(
                    from: e.from,
                    to: e.to,
                    directed: false,
                    highlight: true,
                  )
                : e;
          }).toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Query [1..3]',
              values: ['take n4@1', 'take n5', 'take n6'],
            ),
            WhiteboardArray(name: 'Result', values: ['9']),
          ],
          annotations: const ['Disjoint-cover decomposition'],
        ),
      ),
      AlgorithmStep(
        title: 'Point update: arr[2] += 2',
        description:
            'Update leaf [2..2] (n5) from 5 to 7; then fix parents: n2= n4(3)+n5(7)=10, root n1 = 10 + 7 = 17.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'n5' || n.id == 'n2' || n.id == 'n1')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    ((e.from == 'n2' && e.to == 'n5') ||
                        (e.from == 'n1' && e.to == 'n2'))
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: false,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'arr (new)',
              values: ['2', '1', '7', '3', '4'],
              highlightIndices: [2],
            ),
            WhiteboardArray(
              name: 'tree values',
              values: ['n5:7', 'n2:10', 'n1:17'],
            ),
          ],
          annotations: const ['Propagate changes upward'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _fenwickTreeStoryboard() {
    final arr = ['-', '5', '1', '2', '3', '7', '2', '6', '2'];
    final nodes = [
      const WhiteboardNode(id: 'i1', label: '1:[1]', x: 0.15, y: 0.65),
      const WhiteboardNode(id: 'i2', label: '2:[1..2]', x: 0.28, y: 0.50),
      const WhiteboardNode(id: 'i3', label: '3:[3]', x: 0.41, y: 0.65),
      const WhiteboardNode(id: 'i4', label: '4:[1..4]', x: 0.54, y: 0.35),
      const WhiteboardNode(id: 'i5', label: '5:[5]', x: 0.67, y: 0.65),
      const WhiteboardNode(id: 'i6', label: '6:[5..6]', x: 0.78, y: 0.50),
      const WhiteboardNode(id: 'i7', label: '7:[7]', x: 0.89, y: 0.65),
      const WhiteboardNode(id: 'i8', label: '8:[1..8]', x: 0.54, y: 0.15),
    ];
    final edges = [
      const WhiteboardEdge(from: 'i1', to: 'i2', directed: true),
      const WhiteboardEdge(from: 'i2', to: 'i4', directed: true),
      const WhiteboardEdge(from: 'i3', to: 'i4', directed: true),
      const WhiteboardEdge(from: 'i4', to: 'i8', directed: true),
      const WhiteboardEdge(from: 'i5', to: 'i6', directed: true),
      const WhiteboardEdge(from: 'i6', to: 'i8', directed: true),
      const WhiteboardEdge(from: 'i7', to: 'i8', directed: true),
    ];

    return [
      AlgorithmStep(
        title: 'BIT structure (ownership ranges)',
        description:
            'Each index i stores sum over range (i - lsb(i) + 1 .. i). We connect i → i + lsb(i).',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: [
            WhiteboardArray(name: 'arr (1-based)', values: arr),
            const WhiteboardArray(
              name: 'bit init',
              values: ['0', '0', '0', '0', '0', '0', '0', '0', '0'],
            ),
          ],
          annotations: const ['lsb(i) = i & -i'],
        ),
      ),
      AlgorithmStep(
        title: 'Build by updates: add arr[i] into BIT',
        description:
            'Simulate update(i, arr[i]) for i=1..8, adding to i, i+lsb(i), ...',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) =>
                    (n.id == 'i1' ||
                        n.id == 'i2' ||
                        n.id == 'i4' ||
                        n.id == 'i8')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    ((e.from == 'i1' && e.to == 'i2') ||
                        (e.from == 'i2' && e.to == 'i4') ||
                        (e.from == 'i4' && e.to == 'i8'))
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'bit after i=1..3',
              values: ['-', '5', '6', '2', '8', '7', '9', '6', '26'],
            ),
          ],
          annotations: const ['Propagate contributions upward'],
        ),
      ),
      AlgorithmStep(
        title: 'Prefix sum query: sum(1..6)',
        description:
            'Walk i=6 → 4 → 0: accumulate bit[6] + bit[4] = (arr[5]+arr[6]) + (arr[1..4]) = 9 + 8 = 17.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'i6' || n.id == 'i4')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    ((e.from == 'i6' && e.to == 'i8') ||
                        (e.from == 'i4' && e.to == 'i8'))
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(name: 'prefix path', values: ['6', '4', '0']),
            WhiteboardArray(name: 'result', values: ['17']),
          ],
          annotations: const ['i -= lsb(i)'],
        ),
      ),
      AlgorithmStep(
        title: 'Point update: add +2 at index 3',
        description:
            'Update i=3: add to bit[3], then 4, then 8. New prefix(6) becomes 19.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'i3' || n.id == 'i4' || n.id == 'i8')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    ((e.from == 'i3' && e.to == 'i4') ||
                        (e.from == 'i4' && e.to == 'i8'))
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'arr (new)',
              values: ['-', '5', '1', '4', '3', '7', '2', '6', '2'],
              highlightIndices: [3],
            ),
            WhiteboardArray(name: 'bit delta path', values: ['3', '4', '8']),
            WhiteboardArray(name: 'prefix(6) new', values: ['19']),
          ],
          annotations: const ['i += lsb(i)'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _binaryLiftingLcaStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: '1',
        label: '1',
        x: 0.50,
        y: 0.12,
        highlight: true,
      ),
      const WhiteboardNode(id: '2', label: '2', x: 0.30, y: 0.32),
      const WhiteboardNode(id: '3', label: '3', x: 0.70, y: 0.32),
      const WhiteboardNode(id: '4', label: '4', x: 0.20, y: 0.55),
      const WhiteboardNode(id: '5', label: '5', x: 0.40, y: 0.55),
      const WhiteboardNode(id: '6', label: '6', x: 0.70, y: 0.55),
      const WhiteboardNode(id: '7', label: '7', x: 0.80, y: 0.78),
    ];
    final edges = [
      const WhiteboardEdge(from: '1', to: '2', directed: false),
      const WhiteboardEdge(from: '1', to: '3', directed: false),
      const WhiteboardEdge(from: '2', to: '4', directed: false),
      const WhiteboardEdge(from: '2', to: '5', directed: false),
      const WhiteboardEdge(from: '3', to: '6', directed: false),
      const WhiteboardEdge(from: '6', to: '7', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Preprocess: depth and up[v][0]',
        description:
            'Run DFS from root to fill depth[v] and immediate parent up[v][0].',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'depth',
              values: ['1:0', '2:1', '3:1', '4:2', '5:2', '6:2', '7:3'],
            ),
            WhiteboardArray(
              name: 'up[][0]',
              values: ['1:-', '2:1', '3:1', '4:2', '5:2', '6:3', '7:6'],
            ),
          ],
          annotations: const ['Binary lifting table k=0'],
        ),
      ),
      AlgorithmStep(
        title: 'Build powers of two parents',
        description: 'For k from 1..LOG: up[v][k] = up[ up[v][k-1] ][k-1].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'up[][1]',
              values: ['1:-', '2:-', '3:-', '4:1', '5:1', '6:1', '7:3'],
            ),
            WhiteboardArray(
              name: 'up[][2]',
              values: ['1:-', '2:-', '3:-', '4:-', '5:-', '6:-', '7:1'],
            ),
          ],
          annotations: ['Jump 2^k ancestors'],
        ),
      ),
      AlgorithmStep(
        title: 'LCA(5,7): lift deeper node',
        description:
            'depth[7]=3 > depth[5]=2 → lift 7 by 1 to node 6 using up[7][0].',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == '5' || n.id == '7' || n.id == '6')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'depth', values: ['5:2', '7:3→2']),
          ],
          annotations: const ['Align depths'],
        ),
      ),
      AlgorithmStep(
        title: 'Lift both together',
        description:
            'Raise 5 and 6 by highest powers where their ancestors differ. They meet at ancestor 1 through parents 2 and 3.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == '2' || n.id == '3' || n.id == '1')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'jumps',
              values: ['5→2', '6→3', 'parents differ'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Answer is parent after last lift',
        description:
            'The immediate parents of diverging nodes are 2 and 3, so LCA is their parent → 1.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == '1')
                    ? WhiteboardNode(
                        id: n.id,
                        label: 'LCA=1',
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Result', values: ['LCA(5,7)=1']),
          ],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _knapsack01Storyboard() {
    final items = ['w:2 v:3', 'w:3 v:4', 'w:4 v:5'];
    return [
      AlgorithmStep(
        title: 'DP table definition',
        description:
            'dp[i][w] = max value using first i items with capacity w.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Items', values: ['(2,3)', '(3,4)', '(4,5)']),
            WhiteboardArray(
              name: 'Capacity',
              values: ['0', '1', '2', '3', '4', '5'],
            ),
          ],
          annotations: ['Initialize dp[0][*]=0'],
        ),
      ),
      AlgorithmStep(
        title: 'Fill row i=1 (item (2,3))',
        description:
            'For w≥2: dp[1][w] = max(dp[0][w], 3 + dp[0][w-2]) → row becomes [0,0,3,3,3,3].',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 1',
              values: ['0', '0', '3', '3', '3', '3'],
              highlightIndices: [2, 3, 4, 5],
            ),
          ],
          annotations: ['Transition: take vs skip'],
        ),
      ),
      AlgorithmStep(
        title: 'Fill row i=2 (item (3,4))',
        description:
            'For w≥3: dp[2][w] = max(dp[1][w], 4 + dp[1][w-3]). At w=5: max(3, 4+dp[1][2]=7) = 7.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 2',
              values: ['0', '0', '3', '4', '4', '7'],
              highlightIndices: [3, 4, 5],
            ),
          ],
          annotations: ['Best so far at capacity 5 = 7'],
        ),
      ),
      AlgorithmStep(
        title: 'Fill row i=3 (item (4,5))',
        description:
            'For w≥4: consider taking value 5. At w=5: max(7, 5+dp[2][1]=5) = 7 (no change).',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'dp row 3',
              values: ['0', '0', '3', '4', '5', '7'],
              highlightIndices: [4, 5],
            ),
          ],
          annotations: ['Final optimum = 7'],
        ),
      ),
      AlgorithmStep(
        title: 'Reconstruct solution',
        description:
            'Trace back from dp[3][5]=7: not from item3; came from taking item2 (weight3), remaining capacity 2 → take item1. Selected items = {1,2}.',
        frame: const WhiteboardFrame(
          arrays: [
            WhiteboardArray(name: 'Chosen', values: ['(2,3)', '(3,4)']),
            WhiteboardArray(name: 'Total', values: ['value=7', 'weight=5']),
          ],
          annotations: ['0/1 selection, no fractions'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _bellmanFordStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: 'S',
        label: 'S',
        x: 0.12,
        y: 0.20,
        highlight: true,
      ),
      const WhiteboardNode(id: 'A', label: 'A', x: 0.45, y: 0.18),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.8, y: 0.22),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.35, y: 0.65),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.78, y: 0.62),
    ];
    final edges = [
      const WhiteboardEdge(from: 'S', to: 'A', label: '4'),
      const WhiteboardEdge(from: 'S', to: 'C', label: '2'),
      const WhiteboardEdge(from: 'A', to: 'B', label: '3'),
      const WhiteboardEdge(from: 'C', to: 'A', label: '1'),
      const WhiteboardEdge(from: 'C', to: 'D', label: '7'),
      const WhiteboardEdge(from: 'B', to: 'D', label: '-2'),
    ];

    return [
      AlgorithmStep(
        title: 'Initialization',
        description:
            'Set dist[S]=0 and all others to ∞. We will perform |V|-1 passes to relax all edges.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'dist',
              values: ['S:0', 'A:∞', 'B:∞', 'C:∞', 'D:∞'],
            ),
          ],
          annotations: const ['Total passes = |V|-1'],
        ),
      ),
      AlgorithmStep(
        title: 'First pass: relax all edges',
        description:
            'Relax all edges sequentially. S→A = 4, S→C = 2, then C→A improves A=3, A→B gives B=6, B→D improves D=4.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) =>
                    (n.id == 'A' || n.id == 'B' || n.id == 'C' || n.id == 'D')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => WhiteboardEdge(
                  from: e.from,
                  to: e.to,
                  label: e.label,
                  highlight: true,
                ),
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'dist',
              values: ['S:0', 'A:3', 'B:6', 'C:2', 'D:4'],
            ),
          ],
          annotations: const ['Relax all edges (pass 1)'],
        ),
      ),
      AlgorithmStep(
        title: 'Subsequent passes until stable',
        description:
            'Repeat relaxation. No more improvements → distances stabilized before |V|-1 iterations.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'dist',
              values: ['S:0', 'A:3', 'B:6', 'C:2', 'D:4'],
            ),
          ],
          annotations: const ['No more updates → terminate early'],
        ),
      ),
      AlgorithmStep(
        title: 'Check for negative cycle',
        description:
            'Do one extra iteration: if any distance still improves, there is a negative cycle. None found here.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'dist',
              values: ['S:0', 'A:3', 'B:6', 'C:2', 'D:4'],
            ),
          ],
          annotations: const ['No negative cycles detected'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _floydWarshallStoryboard() {
    return [
      AlgorithmStep(
        title: 'Initialize distance matrix',
        description:
            'dist[i][j] = edge weight if exists, else ∞; diagonal = 0.',
        frame: WhiteboardFrame(
          annotations: const ['Initialize with direct edges only'],
          arrays: const [
            WhiteboardArray(
              name: 'dist (k=-1)',
              values: ['0, 5, ∞, 10', '∞, 0, 3, ∞', '∞, ∞, 0, 1', '∞, ∞, ∞, 0'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Use vertex 0 as an intermediate',
        description: 'For each i,j: try dist[i][0] + dist[0][j] as a shortcut.',
        frame: const WhiteboardFrame(
          annotations: ['k = 0'],
          arrays: [
            WhiteboardArray(
              name: 'dist',
              values: ['0, 5, ∞, 10', '∞, 0, 3, ∞', '∞, ∞, 0, 1', '∞, ∞, ∞, 0'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Use vertex 1 as an intermediate',
        description: 'Example: 0→2 improves via 0→1→2 = 8.',
        frame: const WhiteboardFrame(
          annotations: ['k = 1'],
          arrays: [
            WhiteboardArray(
              name: 'dist',
              values: ['0, 5, 8, 10', '∞, 0, 3, ∞', '∞, ∞, 0, 1', '∞, ∞, ∞, 0'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Use vertex 2 as an intermediate',
        description: 'Update example: 1→3 becomes 4 (1→2→3).',
        frame: const WhiteboardFrame(
          annotations: ['k = 2'],
          arrays: [
            WhiteboardArray(
              name: 'dist',
              values: ['0, 5, 8, 9', '∞, 0, 3, 4', '∞, ∞, 0, 1', '∞, ∞, ∞, 0'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Use vertex 3 → final result',
        description:
            'After k=3, we have the shortest distances between all pairs.',
        frame: const WhiteboardFrame(
          annotations: ['Final shortest path matrix'],
          arrays: [
            WhiteboardArray(
              name: 'dist (final)',
              values: ['0, 5, 8, 9', '∞, 0, 3, 4', '∞, ∞, 0, 1', '∞, ∞, ∞, 0'],
            ),
          ],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _primMstStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: 'A',
        label: 'A',
        x: 0.12,
        y: 0.20,
        highlight: true,
      ),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.55, y: 0.18),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.22, y: 0.65),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.75, y: 0.62),
      const WhiteboardNode(id: 'E', label: 'E', x: 0.40, y: 0.42),
    ];
    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', label: '4', directed: false),
      const WhiteboardEdge(from: 'A', to: 'C', label: '2', directed: false),
      const WhiteboardEdge(from: 'B', to: 'E', label: '1', directed: false),
      const WhiteboardEdge(from: 'C', to: 'E', label: '3', directed: false),
      const WhiteboardEdge(from: 'E', to: 'D', label: '5', directed: false),
      const WhiteboardEdge(from: 'B', to: 'D', label: '7', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Initialize frontier',
        description:
            'Start from A. Add edges from A to the priority queue and mark A as part of MST.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'PQ',
              values: ['(A,C,2)', '(A,B,4)'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'MST', values: []),
          ],
          annotations: const ['visited = {A}'],
        ),
      ),
      AlgorithmStep(
        title: 'Select lightest edge (A–C)',
        description:
            'Pick (A,C,2) → add C, then push its outgoing edges crossing the frontier.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'C')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => (e.from == 'A' && e.to == 'C')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        label: e.label,
                        directed: false,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'PQ',
              values: ['(A,B,4)', '(C,E,3)'],
              highlightIndices: [1],
            ),
            WhiteboardArray(name: 'MST', values: ['A–C(2)']),
          ],
          annotations: const ['visited = {A,C}'],
        ),
      ),
      AlgorithmStep(
        title: 'Add E via lightest edge (C–E)',
        description:
            'Pull (C,E,3). Add E, and update PQ with (E,B,1), (E,D,5).',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'C' || n.id == 'E')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => (e.from == 'C' && e.to == 'E')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        label: e.label,
                        directed: false,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'PQ',
              values: ['(A,B,4)', '(E,B,1)', '(E,D,5)'],
              highlightIndices: [1],
            ),
            WhiteboardArray(name: 'MST', values: ['A–C(2)', 'C–E(3)']),
          ],
          annotations: const ['visited = {A,C,E}'],
        ),
      ),
      AlgorithmStep(
        title: 'Add (E–B,1) then (E–D,5)',
        description:
            'Smallest edge crossing frontier is (E,B,1), then (E,D,5) to complete the MST.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => WhiteboardNode(
                  id: n.id,
                  label: n.label,
                  x: n.x,
                  y: n.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    ((e.from == 'E' && e.to == 'B') ||
                        (e.from == 'E' && e.to == 'D') ||
                        (e.from == 'A' && e.to == 'C') ||
                        (e.from == 'C' && e.to == 'E'))
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        label: e.label,
                        directed: false,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'MST',
              values: ['A–C(2)', 'C–E(3)', 'E–B(1)', 'E–D(5)'],
            ),
            WhiteboardArray(name: 'PQ', values: []),
          ],
          annotations: const ['|MST| = |V|-1'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _kruskalMstStoryboard() {
    final nodes = [
      const WhiteboardNode(id: 'A', label: 'A', x: 0.18, y: 0.22),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.68, y: 0.18),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.20, y: 0.65),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.70, y: 0.65),
    ];
    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', label: '3', directed: false),
      const WhiteboardEdge(from: 'A', to: 'C', label: '1', directed: false),
      const WhiteboardEdge(from: 'B', to: 'D', label: '4', directed: false),
      const WhiteboardEdge(from: 'C', to: 'D', label: '2', directed: false),
      const WhiteboardEdge(from: 'B', to: 'C', label: '5', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Sort all edges',
        description:
            'Sorted order: (A–C,1), (C–D,2), (A–B,3), (B–D,4), (B–C,5). Using Disjoint Set (Union–Find) to detect cycles.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'Edges (sorted)',
              values: ['AC(1)', 'CD(2)', 'AB(3)', 'BD(4)', 'BC(5)'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'MST', values: []),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Pick AC(1) and CD(2)',
        description:
            'AC unites {A,C}. CD joins C and D → new set {A,C,D}. No cycle yet.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'C' || n.id == 'D')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    ((e.from == 'A' && e.to == 'C') ||
                        (e.from == 'C' && e.to == 'D'))
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        label: e.label,
                        directed: false,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(name: 'MST', values: ['A–C(1)', 'C–D(2)']),
            WhiteboardArray(
              name: 'Edges (next)',
              values: ['AB(3)', 'BD(4)', 'BC(5)'],
              highlightIndices: [0],
            ),
          ],
          annotations: const ['Sets: {A,C,D}, {B}'],
        ),
      ),
      AlgorithmStep(
        title: 'Check AB(3) → valid',
        description:
            'Connects B with {A,C,D} without cycle. MST now has |V|-1 edges → done.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => WhiteboardNode(
                  id: n.id,
                  label: n.label,
                  x: n.x,
                  y: n.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    ((e.from == 'A' && e.to == 'B') ||
                        (e.from == 'A' && e.to == 'C') ||
                        (e.from == 'C' && e.to == 'D'))
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        label: e.label,
                        directed: false,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'MST',
              values: ['A–C(1)', 'C–D(2)', 'A–B(3)'],
            ),
            WhiteboardArray(name: 'Skipped', values: ['BD(4)', 'BC(5)']),
          ],
          annotations: const ['Stop when |MST| = |V|-1'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _topologicalSortDfsStoryboard() {
    final nodes = [
      const WhiteboardNode(id: 'A', label: 'A', x: 0.15, y: 0.22),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.45, y: 0.18),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.75, y: 0.20),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.30, y: 0.60),
      const WhiteboardNode(id: 'E', label: 'E', x: 0.60, y: 0.62),
      const WhiteboardNode(id: 'F', label: 'F', x: 0.85, y: 0.62),
    ];
    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', directed: true),
      const WhiteboardEdge(from: 'A', to: 'D', directed: true),
      const WhiteboardEdge(from: 'B', to: 'C', directed: true),
      const WhiteboardEdge(from: 'D', to: 'E', directed: true),
      const WhiteboardEdge(from: 'E', to: 'F', directed: true),
      const WhiteboardEdge(from: 'C', to: 'F', directed: true),
    ];

    return [
      AlgorithmStep(
        title: 'DFS with post-order push',
        description:
            'Start DFS from A. When a node finishes, push it to the stack.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == 'A'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Visited', values: ['A']),
            WhiteboardArray(name: 'Stack', values: []),
          ],
          annotations: const ['Push after finishing children'],
        ),
      ),
      AlgorithmStep(
        title: 'Explore A→B→C and A→D→E→F',
        description:
            'Finish C then push it, then finish B, then continue through D→E→F.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'C' || n.id == 'B' || n.id == 'F')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    (e.from == 'B' && e.to == 'C') ||
                        (e.from == 'E' && e.to == 'F')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: true,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(name: 'Stack', values: ['C', 'B']),
            WhiteboardArray(
              name: 'Visited',
              values: ['A', 'B', 'C', 'D', 'E', 'F'],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Push remaining nodes in finish order',
        description:
            'After finishing F, push F, E, D, A. Reversing the stack gives the topological order.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => WhiteboardNode(
                  id: n.id,
                  label: n.label,
                  x: n.x,
                  y: n.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'Stack (finish order)',
              values: ['C', 'B', 'F', 'E', 'D', 'A'],
            ),
            WhiteboardArray(
              name: 'Topo order',
              values: ['A', 'D', 'E', 'B', 'C', 'F'],
            ),
          ],
          annotations: const ['reverse(finish order) = Topo sort'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _depthFirstSearchStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: 'A',
        label: 'A',
        x: 0.15,
        y: 0.18,
        highlight: true,
      ),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.35, y: 0.35),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.7, y: 0.3),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.25, y: 0.68),
      const WhiteboardNode(id: 'E', label: 'E', x: 0.55, y: 0.62),
      const WhiteboardNode(id: 'F', label: 'F', x: 0.85, y: 0.65),
    ];
    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', directed: false),
      const WhiteboardEdge(from: 'A', to: 'C', directed: false),
      const WhiteboardEdge(from: 'B', to: 'D', directed: false),
      const WhiteboardEdge(from: 'B', to: 'E', directed: false),
      const WhiteboardEdge(from: 'C', to: 'E', directed: false),
      const WhiteboardEdge(from: 'E', to: 'F', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Start from the root and go as deep as possible',
        description:
            'Mark A as visited and call DFS on its first unvisited neighbor (B). The recursion stack grows.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == 'A'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Visited', values: ['A']),
            WhiteboardArray(name: 'Call Stack', values: ['DFS(A)']),
          ],
          annotations: const ['Move to the first unvisited neighbor'],
        ),
      ),
      AlgorithmStep(
        title: 'Go deeper: from A to B to D',
        description:
            'From A we go to B, and from B we go deeper to the unvisited node D.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'B' || n.id == 'D')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    (e.from == 'A' && e.to == 'B') ||
                        (e.from == 'B' && e.to == 'D')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: e.directed,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(name: 'Visited', values: ['A', 'B', 'D']),
            WhiteboardArray(
              name: 'Call Stack',
              values: ['DFS(A)', 'DFS(B)', 'DFS(D)'],
            ),
          ],
          annotations: const ['Depth increases by +1 per call'],
        ),
      ),
      AlgorithmStep(
        title: 'Backtrack from D to B',
        description:
            'No more unvisited neighbors for D; backtrack to B and try another path (E).',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (n.id == 'A' || n.id == 'B' || n.id == 'E')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) => (e.from == 'B' && e.to == 'E')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: e.directed,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(name: 'Visited', values: ['A', 'B', 'D', 'E']),
            WhiteboardArray(
              name: 'Call Stack',
              values: ['DFS(A)', 'DFS(B)', 'DFS(E)'],
            ),
          ],
          annotations: const ['Backtrack and explore a new branch'],
        ),
      ),
      AlgorithmStep(
        title: 'Complete the branch through E → F',
        description:
            'From E we visit F, then gradually backtrack to the root and check if C is unvisited.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) =>
                    (n.id == 'A' || n.id == 'C' || n.id == 'E' || n.id == 'F')
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges
              .map(
                (e) =>
                    (e.from == 'E' && e.to == 'F') ||
                        (e.from == 'A' && e.to == 'C')
                    ? WhiteboardEdge(
                        from: e.from,
                        to: e.to,
                        directed: e.directed,
                        highlight: true,
                      )
                    : e,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Visited',
              values: ['A', 'B', 'D', 'E', 'F', 'C'],
            ),
            WhiteboardArray(name: 'Call Stack', values: ['DFS(A)']),
          ],
          annotations: const ['Visit C last if it was unvisited'],
        ),
      ),
      AlgorithmStep(
        title: 'Traversal completed',
        description:
            'Once the stack is empty, all reachable nodes are visited in DFS order.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => WhiteboardNode(
                  id: n.id,
                  label: n.label,
                  x: n.x,
                  y: n.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(
              name: 'Visit Order',
              values: ['A', 'B', 'D', 'E', 'F', 'C'],
            ),
          ],
          annotations: const ['Traversal complete'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _countingSortStoryboard() {
    const input = ['4', '2', '2', '8', '3', '3', '1', '0', '5', '2'];
    return [
      AlgorithmStep(
        title: 'Count occurrences',
        description: 'Scan the array and count how many times each key occurs.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Input',
              values: input,
              highlightIndices: [0, 9],
            ),
            WhiteboardArray(
              name: 'Count (0..8)',
              values: ['0', '0', '0', '0', '0', '0', '0', '0', '0'],
              highlightIndices: [0],
            ),
          ],
          annotations: const ['Initialize counts to 0'],
        ),
      ),
      AlgorithmStep(
        title: 'Tally counts',
        description: 'For each value v in Input, increment Count[v].',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Input',
              values: input,
              highlightIndices: [0, 9],
            ),
            WhiteboardArray(
              name: 'Count',
              values: ['1', '1', '3', '2', '1', '1', '0', '0', '1'],
              highlightIndices: [0, 1, 2, 3, 4, 5, 8],
            ),
          ],
          annotations: const ['Counting complete'],
        ),
      ),
      AlgorithmStep(
        title: 'Prefix sums',
        description:
            'Convert counts to prefix sums so Count[v] holds the end position for key v.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Count → Prefix',
              values: ['1', '2', '5', '7', '8', '9', '9', '9', '10'],
              highlightIndices: [0, 8],
            ),
          ],
          annotations: const ['Positions = cumulative counts'],
        ),
      ),
      AlgorithmStep(
        title: 'Stable placement',
        description:
            'Traverse Input from right to left; place each item at Count[v]-1 then decrement Count[v].',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Output',
              values: ['0', '1', '2', '2', '2', '3', '3', '4', '5', '8'],
              highlightIndices: [0, 9],
            ),
          ],
          annotations: const ['Stable & linear-time for bounded keys'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _radixSortStoryboard() {
    const input = ['802', '24', '2', '66', '170', '45', '75', '90'];
    return [
      AlgorithmStep(
        title: 'Sort by least significant digit',
        description:
            'Distribute numbers into 10 buckets by the units digit, then collect in order.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(name: 'Input', values: input),
            WhiteboardArray(name: 'Bucket 0', values: ['170', '90']),
            WhiteboardArray(name: 'Bucket 2', values: ['802', '2']),
            WhiteboardArray(name: 'Bucket 4', values: ['24']),
            WhiteboardArray(name: 'Bucket 5', values: ['45', '75']),
            WhiteboardArray(name: 'Bucket 6', values: ['66']),
          ],
          annotations: const ['Pass 1: units digit'],
        ),
      ),
      AlgorithmStep(
        title: 'Collect buckets',
        description: 'Concatenate buckets 0→9 to form the new array.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'After pass 1',
              values: ['170', '90', '802', '2', '24', '45', '75', '66'],
              highlightIndices: [0, 7],
            ),
          ],
          annotations: const ['Stable counting per digit'],
        ),
      ),
      AlgorithmStep(
        title: 'Sort by tens digit',
        description: 'Repeat bucketing by tens digit.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(name: 'Bucket 0', values: ['802', '2']),
            WhiteboardArray(name: 'Bucket 2', values: ['24']),
            WhiteboardArray(name: 'Bucket 4', values: ['45']),
            WhiteboardArray(name: 'Bucket 6', values: ['66']),
            WhiteboardArray(name: 'Bucket 7', values: ['170', '75']),
            WhiteboardArray(name: 'Bucket 9', values: ['90']),
          ],
          annotations: const ['Pass 2: tens digit'],
        ),
      ),
      AlgorithmStep(
        title: 'Sort by hundreds digit',
        description:
            'Final pass by hundreds digit yields a fully sorted array.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Sorted',
              values: ['2', '24', '45', '66', '75', '90', '170', '802'],
              highlightIndices: [0, 7],
            ),
          ],
          annotations: const ['All digits processed → sorted'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _bucketSortStoryboard() {
    const input = ['0.42', '0.32', '0.23', '0.52', '0.25', '0.47', '0.51'];
    return [
      AlgorithmStep(
        title: 'Distribute into buckets',
        description: 'Map each value to a bucket by its normalized value.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(name: 'Bucket 2', values: ['0.23', '0.25']),
            WhiteboardArray(name: 'Bucket 3', values: ['0.32']),
            WhiteboardArray(name: 'Bucket 4', values: ['0.42']),
            WhiteboardArray(name: 'Bucket 5', values: ['0.52', '0.51']),
            WhiteboardArray(name: 'Bucket 4 (more)', values: ['0.47']),
          ],
          annotations: const ['index = floor(value * k)'],
        ),
      ),
      AlgorithmStep(
        title: 'Sort each bucket',
        description: 'Sort locally with insertion sort (or any stable method).',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'B2',
              values: ['0.23', '0.25'],
              highlightIndices: [0, 1],
            ),
            WhiteboardArray(
              name: 'B3',
              values: ['0.32'],
              highlightIndices: [0],
            ),
            WhiteboardArray(
              name: 'B4',
              values: ['0.42', '0.47'],
              highlightIndices: [0, 1],
            ),
            WhiteboardArray(
              name: 'B5',
              values: ['0.51', '0.52'],
              highlightIndices: [0, 1],
            ),
          ],
          annotations: const ['each bucket sorted'],
        ),
      ),
      AlgorithmStep(
        title: 'Concatenate buckets',
        description: 'Concatenate in bucket order to get the final result.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Sorted',
              values: ['0.23', '0.25', '0.32', '0.42', '0.47', '0.51', '0.52'],
              highlightIndices: [0, 6],
            ),
          ],
          annotations: const ['Linear on average for uniform data'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _insertionSortStoryboard() {
    const input = ['5', '2', '4', '6', '1', '3'];
    return [
      AlgorithmStep(
        title: 'Pick the key',
        description: 'Treat prefix as sorted. Extract arr[i] as the key.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Array',
              values: input,
              highlightIndices: [1],
            ),
          ],
          annotations: const ['key = 2, i = 1'],
        ),
      ),
      AlgorithmStep(
        title: 'Shift larger elements',
        description: 'Move larger elements right to make space for the key.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Shifted',
              values: ['5', '5', '4', '6', '1', '3'],
              highlightIndices: [0, 1],
            ),
          ],
          annotations: const ['while (arr[j] > key) shift'],
        ),
      ),
      AlgorithmStep(
        title: 'Insert key',
        description: 'Place key in its correct position in the sorted prefix.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Array',
              values: ['2', '5', '4', '6', '1', '3'],
              highlightIndices: [0, 1],
            ),
          ],
          annotations: const ['prefix remains sorted'],
        ),
      ),
      AlgorithmStep(
        title: 'Sorted fully',
        description: 'Repeat for i=2..n-1 until array sorted.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Sorted',
              values: ['1', '2', '3', '4', '5', '6'],
              highlightIndices: [0, 5],
            ),
          ],
          annotations: const ['O(n²) worst, O(n) best on nearly-sorted'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _selectionSortStoryboard() {
    const input = ['5', '2', '4', '6', '1', '3'];
    return [
      AlgorithmStep(
        title: 'Find min in suffix',
        description: 'Scan the unsorted part to find the minimum element.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Array',
              values: input,
              highlightIndices: [0, 5],
            ),
          ],
          annotations: const ['min_index = 4 (value 1)'],
        ),
      ),
      AlgorithmStep(
        title: 'Swap into place',
        description: 'Swap minimum with the first unsorted position.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'After swap',
              values: ['1', '2', '4', '6', '5', '3'],
              highlightIndices: [0],
            ),
          ],
          annotations: const ['prefix grows by 1'],
        ),
      ),
      AlgorithmStep(
        title: 'Repeat',
        description: 'Repeat for the remaining suffix until fully sorted.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Sorted',
              values: ['1', '2', '3', '4', '5', '6'],
              highlightIndices: [0, 5],
            ),
          ],
          annotations: const ['In-place, not stable'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _bubbleSortStoryboard() {
    const input = ['5', '1', '4', '2', '8'];
    return [
      AlgorithmStep(
        title: 'Compare adjacent',
        description: 'Walk the array and swap out-of-order adjacent elements.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Pass',
              values: input,
              highlightIndices: [0, 1],
            ),
          ],
          annotations: const ['if arr[j] > arr[j+1] swap'],
        ),
      ),
      AlgorithmStep(
        title: 'Largest bubbles to end',
        description: 'After each pass, the largest element settles at the end.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Array',
              values: ['1', '4', '2', '5', '8'],
              highlightIndices: [4],
            ),
          ],
          annotations: const ['reduce range next pass'],
        ),
      ),
      AlgorithmStep(
        title: 'Repeat until no swaps',
        description: 'Stop early if no swap occurs in a pass.',
        frame: WhiteboardFrame(
          arrays: const [
            WhiteboardArray(
              name: 'Sorted',
              values: ['1', '2', '4', '5', '8'],
              highlightIndices: [0, 4],
            ),
          ],
          annotations: const ['Stable, O(n²) average'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _mergeSortStoryboard() {
    const values = ['8', '3', '5', '2', '9', '1'];
    return [
      AlgorithmStep(
        title: 'Divide the array',
        description:
            'Split the unsorted array into two halves recursively until each subarray has a single element.',
        frame: WhiteboardFrame(
          arrays: [
            const WhiteboardArray(
              name: 'Left',
              values: ['8', '3', '5'],
              highlightIndices: [0, 1, 2],
            ),
            const WhiteboardArray(
              name: 'Right',
              values: ['2', '9', '1'],
              highlightIndices: [0, 1, 2],
            ),
          ],
          annotations: const ['Divide → conquer'],
        ),
      ),
      AlgorithmStep(
        title: 'Merge step begins',
        description:
            'Compare the first elements of both subarrays. Place the smaller element into the merged result.',
        frame: WhiteboardFrame(
          arrays: [
            const WhiteboardArray(name: 'Left', values: ['8', '3', '5']),
            const WhiteboardArray(name: 'Right', values: ['2', '9', '1']),
            const WhiteboardArray(
              name: 'Merged',
              values: ['2'],
              highlightIndices: [0],
            ),
          ],
          annotations: const ['Compare Left[0]=8, Right[0]=2'],
        ),
      ),
      AlgorithmStep(
        title: 'Continue merging',
        description:
            'Advance in the right array and continue comparing until both sides are exhausted.',
        frame: WhiteboardFrame(
          arrays: [
            const WhiteboardArray(name: 'Left', values: ['8', '3', '5']),
            const WhiteboardArray(name: 'Right', values: ['9', '1']),
            const WhiteboardArray(
              name: 'Merged',
              values: ['2', '3', '5', '8', '9', '1'],
              highlightIndices: [1, 2, 3],
            ),
          ],
          annotations: const ['Stable merge in progress'],
        ),
      ),
      AlgorithmStep(
        title: 'Fully merged',
        description:
            'All elements have been merged into a single sorted array.',
        frame: WhiteboardFrame(
          arrays: [
            const WhiteboardArray(
              name: 'Sorted',
              values: ['1', '2', '3', '5', '8', '9'],
              highlightIndices: [0, 1, 2, 3, 4, 5],
            ),
          ],
          annotations: const ['Merge sort complete ✓'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _quickSortStoryboard() {
    const values = ['8', '3', '7', '6', '2', '5', '4'];
    return [
      AlgorithmStep(
        title: 'Choose a pivot',
        description:
            'Pick a pivot element from the array. Here, we choose the last element as the pivot.',
        frame: WhiteboardFrame(
          arrays: [
            WhiteboardArray(
              name: 'Array',
              values: values,
              highlightIndices: [6],
            ),
          ],
          annotations: const ['pivot = 4'],
        ),
      ),
      AlgorithmStep(
        title: 'Partition the array',
        description:
            'Rearrange elements so that all smaller elements are on the left of the pivot.',
        frame: WhiteboardFrame(
          arrays: [
            const WhiteboardArray(
              name: 'Left side',
              values: ['3', '2'],
              highlightIndices: [0, 1],
            ),
            const WhiteboardArray(
              name: 'Pivot',
              values: ['4'],
              highlightIndices: [0],
            ),
            const WhiteboardArray(
              name: 'Right side',
              values: ['8', '7', '6', '5'],
              highlightIndices: [0, 1, 2, 3],
            ),
          ],
          annotations: const ['Partition complete'],
        ),
      ),
      AlgorithmStep(
        title: 'Recursively sort subarrays',
        description:
            'Recursively apply Quick Sort to left and right subarrays independently.',
        frame: WhiteboardFrame(
          arrays: [
            const WhiteboardArray(
              name: 'Left sorted',
              values: ['2', '3'],
              highlightIndices: [0, 1],
            ),
            const WhiteboardArray(
              name: 'Pivot',
              values: ['4'],
              highlightIndices: [0],
            ),
            const WhiteboardArray(
              name: 'Right sorted',
              values: ['5', '6', '7', '8'],
              highlightIndices: [0, 1, 2, 3],
            ),
          ],
          annotations: const ['Recursive sorting done'],
        ),
      ),
      AlgorithmStep(
        title: 'Combine results',
        description:
            'Concatenate left, pivot, and right parts to form the fully sorted array.',
        frame: WhiteboardFrame(
          arrays: [
            const WhiteboardArray(
              name: 'Sorted',
              values: ['2', '3', '4', '5', '6', '7', '8'],
              highlightIndices: [0, 1, 2, 3, 4, 5, 6],
            ),
          ],
          annotations: const ['Quick sort complete ✓'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _heapSortStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: 'A',
        label: '8',
        x: 0.5,
        y: 0.1,
        highlight: true,
      ),
      const WhiteboardNode(id: 'B', label: '3', x: 0.3, y: 0.35),
      const WhiteboardNode(id: 'C', label: '5', x: 0.7, y: 0.35),
      const WhiteboardNode(id: 'D', label: '2', x: 0.2, y: 0.6),
      const WhiteboardNode(id: 'E', label: '9', x: 0.4, y: 0.6),
      const WhiteboardNode(id: 'F', label: '1', x: 0.6, y: 0.6),
      const WhiteboardNode(id: 'G', label: '4', x: 0.8, y: 0.6),
    ];

    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', directed: false),
      const WhiteboardEdge(from: 'A', to: 'C', directed: false),
      const WhiteboardEdge(from: 'B', to: 'D', directed: false),
      const WhiteboardEdge(from: 'B', to: 'E', directed: false),
      const WhiteboardEdge(from: 'C', to: 'F', directed: false),
      const WhiteboardEdge(from: 'C', to: 'G', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Build a max heap',
        description:
            'Convert the unsorted array into a valid max-heap structure.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          annotations: const ['Heapify → largest at top'],
        ),
      ),
      AlgorithmStep(
        title: 'Extract the maximum',
        description:
            'Swap the root (largest) with the last element, then heapify the reduced heap.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == 'A' || n.id == 'E'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          edges: edges,
          annotations: const ['Swap root with last'],
        ),
      ),
      AlgorithmStep(
        title: 'Repeat heapify',
        description:
            'Repeat extraction until the heap is empty and array is sorted.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => WhiteboardNode(
                  id: n.id,
                  label: n.label,
                  x: n.x,
                  y: n.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: edges,
          annotations: const ['All elements extracted ✓'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _binarySearchStoryboard() {
    const values = ['2', '5', '8', '12', '16', '23', '38', '56'];
    List<int> highlightRange(int start, int end) => [
      for (var i = start; i <= end; i++) i,
    ];

    final nodes = [
      const WhiteboardNode(id: '0', label: '2', x: 0.10, y: 0.5),
      const WhiteboardNode(id: '1', label: '5', x: 0.22, y: 0.5),
      const WhiteboardNode(id: '2', label: '8', x: 0.34, y: 0.5),
      const WhiteboardNode(id: '3', label: '12', x: 0.46, y: 0.5),
      const WhiteboardNode(id: '4', label: '16', x: 0.58, y: 0.5),
      const WhiteboardNode(id: '5', label: '23', x: 0.70, y: 0.5),
      const WhiteboardNode(id: '6', label: '38', x: 0.82, y: 0.5),
      const WhiteboardNode(id: '7', label: '56', x: 0.94, y: 0.5),
    ];

    return [
      AlgorithmStep(
        title: 'Initialize search boundaries',
        description:
            'Binary search begins with two pointers — left (L=0) and right (R=7) — covering the entire sorted array.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => WhiteboardNode(
                  id: n.id,
                  label: n.label,
                  x: n.x,
                  y: n.y,
                  highlight: true,
                ),
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Indices',
              values: ['0', '1', '2', '3', '4', '5', '6', '7'],
            ),
          ],
          annotations: const ['L = 0', 'R = 7', 'Target = 23'],
        ),
      ),
      AlgorithmStep(
        title: 'Compute the midpoint',
        description:
            'Compute mid = (L + R) / 2 = (0 + 7)/2 = 3. Compare arr[mid]=12 with the target (23). Since arr[mid] < target, move to the right half.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == '3'
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y - 0.1,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Check',
              values: ['mid=3', 'arr[mid]=12', 'target=23'],
            ),
          ],
          annotations: const ['arr[mid] < target → search right half'],
        ),
      ),
      AlgorithmStep(
        title: 'Discard the left half',
        description:
            'Move L to mid+1 (L=4). New interval is [4,7]. Values [2,5,8,12] are discarded.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => (int.parse(n.id) < 4)
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      ),
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Active window',
              values: ['16', '23', '38', '56'],
            ),
          ],
          annotations: const ['L = 4', 'R = 7'],
        ),
      ),
      AlgorithmStep(
        title: 'Recalculate the midpoint',
        description:
            'mid = (4 + 7)/2 = 5. arr[mid]=23, which matches the target. The search stops successfully.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == '5'
                    ? WhiteboardNode(
                        id: n.id,
                        label: '23 ✓',
                        x: n.x,
                        y: n.y - 0.1,
                        highlight: true,
                      )
                    : (int.parse(n.id) >= 4 && int.parse(n.id) <= 7)
                    ? WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : WhiteboardNode(
                        id: n.id,
                        label: n.label,
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      ),
              )
              .toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Check',
              values: ['mid=5', 'arr[mid]=23', 'target=23'],
            ),
          ],
          annotations: const ['✓ target found at index 5'],
        ),
      ),
      AlgorithmStep(
        title: 'Return result',
        description:
            'Binary Search stops after log₂(8)=3 comparisons. Returns index 5 as the location of the target value.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (n) => n.id == '5'
                    ? WhiteboardNode(
                        id: n.id,
                        label: '23 ✓',
                        x: n.x,
                        y: n.y,
                        highlight: true,
                      )
                    : n,
              )
              .toList(),
          arrays: const [
            WhiteboardArray(name: 'Result', values: ['index=5']),
          ],
          annotations: const ['O(log n) complexity'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _breadthFirstSearchStoryboard() {
    final baseNodes = [
      const WhiteboardNode(
        id: 'A',
        label: 'A',
        x: 0.5,
        y: 0.12,
        highlight: true,
      ),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.25, y: 0.35),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.75, y: 0.35),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.15, y: 0.62),
      const WhiteboardNode(id: 'E', label: 'E', x: 0.35, y: 0.62),
      const WhiteboardNode(id: 'F', label: 'F', x: 0.65, y: 0.62),
      const WhiteboardNode(id: 'G', label: 'G', x: 0.85, y: 0.62),
    ];

    final allEdges = [
      const WhiteboardEdge(from: 'A', to: 'B', directed: false),
      const WhiteboardEdge(from: 'A', to: 'C', directed: false),
      const WhiteboardEdge(from: 'B', to: 'D', directed: false),
      const WhiteboardEdge(from: 'B', to: 'E', directed: false),
      const WhiteboardEdge(from: 'C', to: 'F', directed: false),
      const WhiteboardEdge(from: 'C', to: 'G', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Start from the root',
        description:
            'Initialise the queue with the start vertex. Visited set contains the root.',
        frame: WhiteboardFrame(
          nodes: [baseNodes.first],
          arrays: [
            const WhiteboardArray(
              name: 'Queue',
              values: ['A'],
              highlightIndices: [0],
            ),
            const WhiteboardArray(name: 'Visited', values: ['A']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Explore neighbours layer by layer',
        description:
            'Dequeue A and enqueue its unvisited neighbours B and C. Both edges are added to the frontier.',
        frame: WhiteboardFrame(
          nodes: baseNodes
              .map(
                (node) => node.id == 'A'
                    ? node
                    : node.id == 'B' || node.id == 'C'
                    ? WhiteboardNode(
                        id: node.id,
                        label: node.label,
                        x: node.x,
                        y: node.y,
                        highlight: true,
                      )
                    : node,
              )
              .toList(),
          edges: allEdges.take(2).toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Queue',
              values: ['B', 'C'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'Visited', values: ['A', 'B', 'C']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Process the next layer',
        description:
            'Visit each node in queue order. Dequeue B, enqueue its children D and E, then proceed to C.',
        frame: WhiteboardFrame(
          nodes: baseNodes
              .map(
                (node) => node.id == 'B'
                    ? WhiteboardNode(
                        id: node.id,
                        label: node.label,
                        x: node.x,
                        y: node.y,
                        highlight: true,
                      )
                    : node,
              )
              .toList(),
          edges: allEdges.take(4).toList(),
          arrays: const [
            WhiteboardArray(
              name: 'Queue',
              values: ['C', 'D', 'E'],
              highlightIndices: [0],
            ),
            WhiteboardArray(name: 'Visited', values: ['A', 'B', 'C', 'D', 'E']),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Complete traversal',
        description:
            'Once the queue empties, every vertex reachable from the start has been visited in breadth-first order.',
        frame: WhiteboardFrame(
          nodes: baseNodes
              .map(
                (node) => WhiteboardNode(
                  id: node.id,
                  label: node.label,
                  x: node.x,
                  y: node.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: allEdges,
          arrays: const [
            WhiteboardArray(name: 'Queue', values: []),
            WhiteboardArray(
              name: 'Visited order',
              values: ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
            ),
          ],
          annotations: const ['Traversal complete'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _dijkstraStoryboard() {
    final nodes = [
      const WhiteboardNode(
        id: 'A',
        label: 'A',
        x: 0.2,
        y: 0.2,
        highlight: true,
      ),
      const WhiteboardNode(id: 'B', label: 'B', x: 0.7, y: 0.18),
      const WhiteboardNode(id: 'C', label: 'C', x: 0.2, y: 0.62),
      const WhiteboardNode(id: 'D', label: 'D', x: 0.7, y: 0.62),
    ];

    final edges = [
      const WhiteboardEdge(from: 'A', to: 'B', label: '4', directed: false),
      const WhiteboardEdge(from: 'A', to: 'C', label: '2', directed: false),
      const WhiteboardEdge(from: 'C', to: 'B', label: '1', directed: false),
      const WhiteboardEdge(from: 'C', to: 'D', label: '7', directed: false),
      const WhiteboardEdge(from: 'B', to: 'D', label: '3', directed: false),
    ];

    return [
      AlgorithmStep(
        title: 'Initialise distances',
        description:
            'Set the source distance to 0 and all other nodes to infinity. Insert the source into the priority queue.',
        frame: WhiteboardFrame(
          nodes: nodes,
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Distance', values: ['0', '∞', '∞', '∞']),
            WhiteboardArray(
              name: 'Queue',
              values: ['A'],
              highlightIndices: [0],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Relax outgoing edges',
        description:
            'Extract A. Relax edges (A,B) and (A,C), updating tentative distances and pushing neighbours.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (node) => node.id == 'B' || node.id == 'C'
                    ? WhiteboardNode(
                        id: node.id,
                        label: node.label,
                        x: node.x,
                        y: node.y,
                        highlight: true,
                      )
                    : node,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Distance', values: ['0', '4', '2', '∞']),
            WhiteboardArray(
              name: 'Queue',
              values: ['C (2)', 'B (4)'],
              highlightIndices: [0],
            ),
          ],
        ),
      ),
      AlgorithmStep(
        title: 'Discover cheaper routes',
        description:
            'Extract C (lowest distance). Relax edges from C, finding a cheaper path to B via C.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (node) => node.id == 'C'
                    ? WhiteboardNode(
                        id: node.id,
                        label: node.label,
                        x: node.x,
                        y: node.y,
                        highlight: true,
                      )
                    : node,
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Distance', values: ['0', '3', '2', '9']),
            WhiteboardArray(
              name: 'Queue',
              values: ['B (3)', 'D (9)'],
              highlightIndices: [0],
            ),
          ],
          annotations: const ['Relax (C,B): 2 + 1 < 4'],
        ),
      ),
      AlgorithmStep(
        title: 'Finish with the goal node',
        description:
            'Once the queue empties, the shortest paths from the source to all vertices have been determined.',
        frame: WhiteboardFrame(
          nodes: nodes
              .map(
                (node) => WhiteboardNode(
                  id: node.id,
                  label: node.label,
                  x: node.x,
                  y: node.y,
                  highlight: true,
                ),
              )
              .toList(),
          edges: edges,
          arrays: const [
            WhiteboardArray(name: 'Distance', values: ['0', '3', '2', '6']),
            WhiteboardArray(name: 'Queue', values: []),
          ],
          annotations: const ['Shortest paths stabilised'],
        ),
      ),
    ];
  }

  static List<AlgorithmStep> _fallbackStoryboard(AlgorithmModel algorithm) {
    if (algorithm.description.isEmpty) {
      return const [
        AlgorithmStep(
          title: 'Visualisation unavailable',
          description:
              'We are preparing a tailored animation for this algorithm. In the meantime, explore the code and textual explanation.',
        ),
      ];
    }
    return [
      AlgorithmStep(title: algorithm.name, description: algorithm.description),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.errorBuilder,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (err, stackTrace) =>
          errorBuilder?.call(err, stackTrace) ??
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.redAccent),
                const SizedBox(height: 12),
                Text(
                  err.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
      loading: () =>
          loading ?? const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

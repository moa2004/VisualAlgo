import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_algo/features/auth/domain/auth_user.dart';
import 'package:visual_algo/features/auth/presentation/sign_in_screen.dart';
import 'package:visual_algo/features/auth/presentation/sign_up_screen.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:visual_algo/features/home/presentation/home_screen.dart';
import 'package:visual_algo/features/algorithms/presentation/algorithm_catalog_screen.dart';
import 'package:visual_algo/features/algorithms/presentation/algorithm_detail_screen.dart';
import 'package:visual_algo/features/quizzes/presentation/quiz_setup_screen.dart';
import 'package:visual_algo/features/quizzes/presentation/quiz_run_screen.dart';
import 'package:visual_algo/features/quizzes/presentation/quiz_result_screen.dart';
import 'package:visual_algo/features/analytics/presentation/analytics_screen.dart';
import 'package:visual_algo/features/quizzes/domain/quiz_models.dart';
import 'package:visual_algo/features/profile/presentation/profile_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = ref.watch(_authRefreshListenableProvider);

  return GoRouter(
    initialLocation: SignInScreen.routePath,
    refreshListenable: refreshListenable,
    routes: [
      GoRoute(
        path: SignInScreen.routePath,
        name: SignInScreen.routeName,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: SignUpScreen.routePath,
        name: SignUpScreen.routeName,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: HomeScreen.routePath,
        name: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: AlgorithmCatalogScreen.routeSegment,
            name: AlgorithmCatalogScreen.routeName,
            builder: (context, state) => const AlgorithmCatalogScreen(),
            routes: [
              GoRoute(
                path: AlgorithmDetailScreen.routeSegment,
                name: AlgorithmDetailScreen.routeName,
                builder: (context, state) {
                  final algorithmId = state.pathParameters['algorithmId']!;
                  return AlgorithmDetailScreen(algorithmId: algorithmId);
                },
              ),
            ],
          ),
          GoRoute(
            path: QuizSetupScreen.routeSegment,
            name: QuizSetupScreen.routeName,
            builder: (context, state) => const QuizSetupScreen(),
          ),
          GoRoute(
            path: QuizRunScreen.routeSegment,
            name: QuizRunScreen.routeName,
            builder: (context, state) {
              final configuration = state.extra as QuizRunConfiguration;
              return QuizRunScreen(configuration: configuration);
            },
          ),
          GoRoute(
            path: QuizResultScreen.routeSegment,
            name: QuizResultScreen.routeName,
            builder: (context, state) {
              final result = state.extra as QuizResultPayload;
              return QuizResultScreen(result: result);
            },
          ),
          GoRoute(
            path: AnalyticsScreen.routeSegment,
            name: AnalyticsScreen.routeName,
            builder: (context, state) => const AnalyticsScreen(),
          ),
          GoRoute(
            path: 'profile',
            name: ProfileScreen.routeName,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) => null,
  );
});

final _authRefreshListenableProvider = Provider<ChangeNotifier>((ref) {
  final notifier = _AuthRefreshNotifier(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(this._ref) {
    _subscription = _ref.listen<AsyncValue<AuthUser?>>(
      authStateChangesProvider,
      (_, __) => notifyListeners(),
      fireImmediately: false,
    );
  }

  final Ref _ref;
  late final ProviderSubscription<AsyncValue<AuthUser?>> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

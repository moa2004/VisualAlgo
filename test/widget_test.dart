import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visual_algo/app.dart';
import 'package:visual_algo/features/splash/presentation/splash_screen.dart';

void main() {
  testWidgets('App renders splash screen logo text', (tester) async {
    SplashScreen.animationsEnabled = false;
    addTearDown(() => SplashScreen.animationsEnabled = true);

    await tester.pumpWidget(const ProviderScope(child: AlgorithMatApp()));
    await tester.pump();

    expect(find.text('AlgorithMat'), findsWidgets);
  });
}

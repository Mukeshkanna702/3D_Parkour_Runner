import 'package:flutter_test/flutter_test.dart';
import 'package:skyrush_neon_escape/main.dart';

void main() {
  testWidgets('SkyRush App Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(const SkyRushApp());
  });
}

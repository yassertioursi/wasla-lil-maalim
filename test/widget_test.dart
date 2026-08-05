import 'package:flutter_test/flutter_test.dart';

import 'package:wsllmlm/main.dart';

void main() {
  testWidgets('HomeScreen renders app name and start button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const WslaApp());

    expect(find.text('وصلة للمعالم'), findsOneWidget);
    expect(find.text('ابدأ اللعبة'), findsOneWidget);
  });
}
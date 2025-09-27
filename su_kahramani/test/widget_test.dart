import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:su_kahramani/main.dart';
import 'package:su_kahramani/home_page.dart';

void main() {
  testWidgets('HomePage loads with initial name and navigates to story', (WidgetTester tester) async {
    // Build our app with initial values and trigger a frame.
    await tester.pumpWidget(MyApp(initialName: null));

    // Verify that the app starts with the initial screen (e.g., the start button).
    expect(find.text('Merhaba! \n Su Kahramanı olmaya hazır mısın?'), findsOneWidget);

    // Simulate tapping the "Hikayeye Başla" button when no name is entered.
    await tester.tap(find.text('Hikayeye Başla'));
    await tester.pumpAndSettle();

    // Verify that the name dialog appears.
    expect(find.text('Adın Nedir?'), findsOneWidget);

    // Enter a name and submit.
    await tester.enterText(find.byType(TextField), 'Damla');
    await tester.tap(find.text('Tamam'));
    await tester.pumpAndSettle();

    // Verify that the name is updated in the text.
    expect(find.text('Merhaba Damla! \n Su Kahramanı olmaya hazır mısın?'), findsOneWidget);

    // Simulate tapping "Hikayeye Başla" again to navigate to the story.
    await tester.tap(find.text('Hikayeye Başla'));
    await tester.pumpAndSettle();

    // Verify that the first story page (StoryBrush) is loaded.
    expect(find.text('Unutma, su kahramanısın. Dişlerini nasıl fırçalarsın Damla?'), findsOneWidget);
  });
}
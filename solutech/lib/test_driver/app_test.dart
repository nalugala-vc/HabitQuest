import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  group('Flutter Auth Test', () {
    final emailField = find.byValueKey("email-field");
    final password = find.byValueKey("password-button");
    final signInButton = find.text("Sign In");
    final homepage = find.byType("Homepage");
    final snackBar = find.byType("SnackBar");

    FlutterDriver? driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test("Login fails with incorrect email and password", () async {
      await driver!.tap(emailField);
      await driver!.enterText("test@testmail.com");
      await driver!.tap(password);
      await driver!.enterText("test");
      await driver!.tap(signInButton);
      await driver!.waitFor(snackBar);

      assert(snackBar != null);
      await driver!.waitUntilNoTransientCallbacks();
      assert(homepage == null);
    });
  });
}

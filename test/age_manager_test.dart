import 'package:flutter_test/flutter_test.dart';
import 'package:warehouse_prop_testing/age_manager.dart';

void main() {
  test('When user is old enough (i) then check() returns true', () async {
    final mgr = AgeManager();

    final actual = mgr.checkLegalAge(1970, 1, 1);
    const expected = true;

    expect(actual, expected);
  });

  test('When user is old enough (ii) then check() returns true', () async {
    final mgr = AgeManager();

    final actual = mgr.checkLegalAge(2004, 1, 1);
    const expected = true;

    expect(actual, expected);
  });

  test('When user is NOT old enough then check() returns false', () async {
    final mgr = AgeManager();

    final actual = mgr.checkLegalAge(2010, 1, 1);
    const expected = false;

    expect(actual, expected);
  });
}

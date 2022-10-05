// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:glados/glados.dart'
    as g; //XXX: since some methods and props are also define in the flutter test lib, we add a preffix
import 'package:warehouse_prop_testing/age_manager.dart';

/*
 * Entry point for testing
 */
void main() {
  var i = 0;

  Iterable<g.Shrinkable<int>> shrinkValues() {
    return [];
  }

  g.Shrinkable<int> getRandomYear(g.Random r, int i) {
    return g.Shrinkable(r.nextInt(70) + 1970, shrinkValues);
  }

  g.Shrinkable<int> getRandomMonth(g.Random r, int i) {
    return g.Shrinkable(r.nextInt(12) + 1, shrinkValues);
  }

  g.Shrinkable<int> getRandomDay(g.Random r, int i) {
    return g.Shrinkable(r.nextInt(31) + 1, shrinkValues);
  }

  /*
   * Property-based tests are Glados().test() instead of simple test()
   * 
   * The GladosN states the number of inputs for the current test 
   */
  g.Glados3(getRandomYear, getRandomMonth, getRandomDay)
      .test('When checking birthday months then both in the same month', (int year, int month, int day) {
    final mgr = AgeManager();

    DateTime birthday = DateTime.parse("$year${month.toPaddedString()}${day.toPaddedString()}");

    final futureBirthday = mgr.getLegalAgeTime(birthday);

    print("Iteration: ${i++} --------------------------------------------------------");
    print("Birthday : $birthday in month ${birthday.month}");
    print("Legal age: $futureBirthday in month ${futureBirthday.month}");

    expect(futureBirthday.month, birthday.month);
    //expect(futureBirthday.day, birthday.day);
  });
}

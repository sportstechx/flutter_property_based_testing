# warehouse_prop_testing

Property-based testing example on a Flutter app using Glados library

## Getting Started

Property-based testing is a practice on which we exercise intensively a property (or a set of properties) of our program. It comes from the world
of functional programming but can be applied to any programming paradigm.

The properties exercised may map explicitly to attributes of our classes (accepted range of values of some variable, for instance) or conditions/statements that our program guarantees.

Either way, the goal in this type of testing is "breaking" the program on behalf of this property: meaning, finding a set of input values that make the tested property evaluate to false.

Once a "breaking" input is found, the system modifies it automatically in order to find its minimal expression: we want to have the "breaking" input, but on its most simple/comprehensive form. This process is usually called "shrinking".

In order to carry out these kind of tests, we basically need:

- a test harness environment that allows us to define a basic set of input values
- a system to slightly modify (if needed) the inputs provided to tests
- some automatic mechanism to iterate over the tests, so we can exercise different combinations of inputs

Since the implementation of these features would be expensive, the sample program uses a 3rd party library for Flutter/dart:

https://pub.dev/packages/glados/install

which does most of the heavy-lifting for us.

## Source code

App UI in

* my_app.dart

is just a wireframe. It displays dummy data and allows no interaction.

So interesting parts would be:

* warehouse.dart
    Basic implementation of a product storage mechanism

* warehouse_test.dart
    Example-based tests created manually for the previous class

* warehouse_prop_test.dart
    Property-based tests run by the 3rd party lib for the previous class

* age_manager.dart
    Buggy implementation of an age check mechanism to see if user can user our app

* age_manager_test.dart
    Example-based tests created manually for the previous class

* age_manager_prop_test.dart
    Property-based tests run by the 3rd party lib for the previous class

## Running the code

Launch the app (web supported too) with:

* flutter run

Run tests with:

* flutter test

Run tests with coverage:

* flutter test --coverage
* genhtml -o coverage coverage/lcov.info
* open coverage/index.html

Run integration test:

* flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart 

although some conflicting issues with the integration sdk may be thrown

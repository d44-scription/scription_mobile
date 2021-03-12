# COMP3000-scription-mobile

Mobile frontend for the Scription app

## Getting Started

Running this project locally will require the Flutter SDK to be installed, and a valid device or emulator connected to run it on.

Information on how to achieve this can be found [here](https://flutter.dev/docs/get-started).

## Running locally

With a device connected and the flutter SDK installed, running the app is as simple as:

```dart
$ flutter run
  > ...
  > ✓ Built build/app/outputs/flutter-apk/app-debug.apk.
  > ...
  > Flutter run key commands.
  > r Hot reload. 🔥🔥🔥
  > R Hot restart.
  > h Repeat this help message.
  > d Detach (terminate "flutter run" but leave application running).
  > c Clear the screen
  > q Quit (terminate the application on the device).
```

The commands listed above can then be used to reload the app when changes are made.

## API Connections

By default, the app connects to the *Staging* API, to remove the dependency on running the API locally.

API connections are made in the app using the [dio](https://pub.dev/packages/dio) package, and are stubbed in tests using the [http_mock_adapter](https://pub.dev/packages/http_mock_adapter) package.

## Testing

Adding new tests requires the document to be added under the `tests/` directory *and* to have the `_test.dart` prefix.

[lcov](https://github.com/linux-test-project/lcov) is used to collect test coverage:

```dart
$ flutter test --coverage
  > ...
  > All tests passed!
$ genhtml coverage/lcov.info -o coverage/html
  > ...
  > Overall coverage rate:
  > lines......: XX% (YYY of ZZZ lines)
  > functions..: XX% (YYY of ZZZ functions)
```

### Warning

Flutter tests running on MacOS 11, Big Sur, has issues with directory permissions that causes erratic test failures.
This is out of my control, and is largely avoidable by lowering the `concurrency` option in tests from 10 to 1:

```dart
$ flutter test --concurrency 1 --coverage
  > ...
  > All tests passed!
```

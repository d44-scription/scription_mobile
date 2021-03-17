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

## Integration Tests

Integration tests are run differently since they need a version of the app to be spun up first.

Firstly, an emulator or device *must* be connected prior to running tests.

The tests can then be run with:

```dart
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/login_test.dart
```

Integration tests are stored under `integration_test/` and the `target` option in the command above can be updated to point to different suites.

## Deploying

1. **Important**: Update the API URL in `lib/http-common.dart` to point to the target API.
2. Created an `appbundle` build of the app using:

```flutter
$ flutter build appbundle --build-name '1.0.1' --build-number 2
  > ✓ Built build/app/outputs/bundle/release/app-release.aab (17.9MB).
```

The `--build-name` and `--build-number` override the default values (which are "1") & must be unique for every deploy.

This will create a file named `app-release.aab` found at `build/app/outputs/bundle/release/app-release.aab`. This is what is uploaded to the Google Play console following their standards & processes for deployment.

import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

const defaultTimeout = Timeout(Duration(seconds: 3));

void main() {
  test(
    'defaults',
    () async {
      final proc = await TestProcess.start('dart', ['bin/server.dart']);

      await expectLater(
        proc.stdout,
        emitsThrough('Listening on :8080'),
      );

      final response = await get(Uri.parse('http://localhost:8080/rest'));
      expect(response.statusCode, 200);
      expect(response.body, 'Hello, World!');

      proc.signal(ProcessSignal.sigterm);
    },
    timeout: defaultTimeout,
  );
}

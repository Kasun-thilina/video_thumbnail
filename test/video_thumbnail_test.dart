import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_video_thumbnail/get_video_thumbnail.dart';
import 'package:get_video_thumbnail/src/image_format.dart';
import 'package:get_video_thumbnail/src/video_thumbnail_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannelVideoThumbnail.methodChannel;
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  const codec = StandardMethodCodec();

  late List<MethodCall> log;

  /// Stands in for the native side: acknowledges the outgoing call with `true`,
  /// then pushes the result back over the same channel keyed by `callId`, the
  /// way the Android and iOS implementations do.
  void mockNativeReply(String resultMethod, Object? result) {
    messenger.setMockMethodCallHandler(channel, (MethodCall call) async {
      log.add(call);
      final callId = (call.arguments as Map)['callId'] as int;

      scheduleMicrotask(() {
        messenger.handlePlatformMessage(
          channel.name,
          codec.encodeMethodCall(
            MethodCall(resultMethod, {'callId': callId, 'result': result}),
          ),
          (_) {},
        );
      });

      return true;
    });
  }

  setUp(() => log = <MethodCall>[]);

  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  test('thumbnailFile forwards its arguments and resolves the native callback',
      () async {
    mockNativeReply('result#file', '/tmp/thumb.jpg');

    final file = await VideoThumbnail.thumbnailFile(
      video: 'video',
      thumbnailPath: 'path',
      imageFormat: ImageFormat.JPEG,
      maxWidth: 123,
      maxHeight: 456,
      quality: 45,
    );

    expect(file.path, '/tmp/thumb.jpg');

    final call = log.single;
    expect(call.method, 'file');

    final args = call.arguments as Map;
    expect(args['video'], 'video');
    expect(args['path'], 'path');
    expect(args['format'], ImageFormat.JPEG.index);
    expect(args['maxw'], 123);
    expect(args['maxh'], 456);
    expect(args['quality'], 45);
  });

  test('thumbnailData returns the bytes sent back by the platform', () async {
    mockNativeReply('result#data', Uint8List.fromList(<int>[1, 2, 3, 4]));

    final bytes = await VideoThumbnail.thumbnailData(
      video: 'video',
      imageFormat: ImageFormat.PNG,
      quality: 10,
    );

    expect(bytes, <int>[1, 2, 3, 4]);
    expect(log.single.method, 'data');
    expect((log.single.arguments as Map)['format'], ImageFormat.PNG.index);
  });

  test('an error from the platform surfaces as a failed future', () async {
    mockNativeReply('result#error', 'boom');

    expect(
      VideoThumbnail.thumbnailData(video: 'video'),
      throwsA(isA<Exception>()),
    );
  });
}

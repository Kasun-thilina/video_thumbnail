import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_video_thumbnail/src/image_format.dart';
import 'package:get_video_thumbnail/video_thumbnail.dart';

void main() {
  const channel = MethodChannel('video_thumbnail');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      final m = methodCall.method;
      final a = methodCall.arguments as Map<String, dynamic>;

      return '$m=${a["video"]}:${a["path"]}:${a["format"]}:${a["maxhow"]}:${a["quality"]}';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('thumbnailData', () async {
    expect(
      await VideoThumbnail.thumbnailFile(
        video: 'video',
        thumbnailPath: 'path',
        imageFormat: ImageFormat.JPEG,
        maxWidth: 123,
        maxHeight: 123,
        quality: 45,
      ),
      'file=video:path:0:123:45',
    );
  });
}

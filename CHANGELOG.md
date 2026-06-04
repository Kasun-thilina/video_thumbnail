## 0.8.0
* Added Swift Package Manager (SPM) support for iOS, alongside the existing CocoaPods support
* Modernized the Android build to align with Flutter 3.44 standards: declarative Gradle plugins block, AGP 8.11.1, Gradle 8.14, Kotlin 2.2.20, and compileSdk 36
* Migrated the example and plugin Android manifests to namespace-based configuration (removed the deprecated `package` attribute)

## 0.7.0
* Android Project migrated to kotlin following latest flutter standards
* will use MediaMetadataRetriever.OPTION_CLOSEST_SYNC to generate thumbnail only if the bitmap/ file generation is failed or is null

## 0.6.5
* MediaMetadataRetriever.OPTION_CLOSEST updated with MediaMetadataRetriever.OPTION_CLOSEST_SYNC to avoid null pointers in thumbnail generation


## 0.6.4
* Thanks for Andrew-Bekhiet
  - refactor code.

## 0.6.3
* Thanks for Andrew-Bekhiet
  - refactor code
  - Includes fixes for memory leak issues in the base plugin which caused "MissingPluginException(No implementation found for method data on channel plugins.justsoft.xyz/video_thumbnail)" issue.

* initial release for this flutter plugin.

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

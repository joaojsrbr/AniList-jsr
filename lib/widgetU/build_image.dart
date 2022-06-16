import 'package:anisearch2/widgetU/build_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class BuildImageWidget extends StatelessWidget {
  final bool avatar;
  final String imageUrl;
  final double borderradius;
  final Color? color;
  final double? height;
  final bool colorfilter;
  final double? width;
  final BoxConstraints? constraints;
  final BoxFit fit;
  final List<Color>? colors;
  final Key? cachedkey;
  final BlendMode colorBlendMode;
  final FilterQuality filterQuality;
  final List<double>? stops;
  const BuildImageWidget({
    required this.imageUrl,
    this.colorBlendMode = BlendMode.modulate,
    this.constraints,
    this.height,
    this.stops,
    this.colorfilter = false,
    this.colors,
    this.width,
    this.cachedkey,
    this.color,
    this.fit = BoxFit.cover,
    this.borderradius = 0.0,
    this.avatar = false,
    this.filterQuality = FilterQuality.low,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final customCacheManager = CacheManager(
        Config('Image-Manga-Anime', stalePeriod: const Duration(days: 1)));

    return BuildWidget(
      avatar: avatar,
      colorfilter: colorfilter,
      builder: (av, co) {
        return av
            ? ClipRRect(
                borderRadius: BorderRadius.circular(borderradius),
                child: Container(
                  color: Colors.grey[200],
                  constraints: constraints,
                  child: CachedNetworkImage(
                    memCacheHeight: 1000,
                    memCacheWidth: 1000,

                    cacheManager: customCacheManager,
                    key: cachedkey,
                    // colorBlendMode: colorBlendMode,
                    imageUrl: imageUrl,
                    filterQuality: filterQuality,
                    color: color,
                    width: double.infinity,
                    fit: fit,
                    placeholder: (context, url) => Container(
                      color: Colors.black12,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.black12,
                      child: const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(borderradius),
                child: co
                    ? ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: colors!,
                            stops: stops,
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: colorBlendMode,
                        child: InteractiveViewer(
                          minScale: 0.1, // min scale
                          maxScale: 1.0, // max scale
                          scaleEnabled: true,
                          panEnabled: true,
                          child: CachedNetworkImage(
                            // memCacheHeight: 1000,
                            // memCacheWidth: 1000,
                            cacheManager: customCacheManager,
                            key: cachedkey,
                            fit: fit,
                            imageUrl: imageUrl,
                            // colorBlendMode: colorBlendMode,
                            height: height,
                            color: color,

                            filterQuality: filterQuality,
                            width: width,

                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                            ),

                            errorWidget: (context, url, error) => Container(
                              color: Colors.black12,
                              child: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(borderradius),
                        ),
                        height: (constraints == null)
                            ? height
                            : constraints!.maxHeight * .99,
                        width: (constraints == null)
                            ? width
                            : constraints!.maxWidth * .99,
                        constraints: constraints,
                        child: CachedNetworkImage(
                          // maxWidthDiskCache: 500,
                          // maxHeightDiskCache: 700,
                          memCacheHeight: GetPlatform.isWeb ? 2000 : 1000,
                          memCacheWidth: GetPlatform.isWeb ? 2000 : 1000,
                          cacheManager: customCacheManager,
                          key: cachedkey,
                          imageUrl: imageUrl,
                          // colorBlendMode: colorBlendMode,
                          // height: height,
                          // width: width,
                          color: color,
                          filterQuality: filterQuality,
                          fit: fit,
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Container(
                              color: Colors.black12,
                              child: Icon(
                                Icons.error,
                                size: (height! * .5).toDouble(),
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
              );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class BuildImageWidget extends StatelessWidget {
  final bool avatar;
  final String? imageUrl;
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
    this.imageUrl,
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

    return avatar
        ? (imageUrl == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(borderradius),
                child: Container(
                  constraints: constraints,
                  child: CachedNetworkImage(
                    memCacheHeight: GetPlatform.isWeb ? 2000 : 600,
                    memCacheWidth: GetPlatform.isWeb ? 2000 : 600,
                    cacheManager: customCacheManager,
                    key: cachedkey,
                    imageUrl: imageUrl!,
                    filterQuality: filterQuality,
                    color: color,
                    width: double.infinity,
                    fit: fit,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[400],
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
        : (imageUrl == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(borderradius),
                child: colorfilter
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
                            memCacheHeight: GetPlatform.isWeb ? 2000 : 600,
                            memCacheWidth: GetPlatform.isWeb ? 2000 : 600,
                            cacheManager: customCacheManager,
                            key: cachedkey,
                            fit: fit,
                            imageUrl: imageUrl!,
                            height: height,
                            color: color,
                            filterQuality: filterQuality,
                            width: width,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[400],
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
                    : (imageUrl == null)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(borderradius),
                            ),
                            height: (constraints == null)
                                ? height
                                : constraints!.maxHeight,
                            width: (constraints == null)
                                ? width
                                : constraints!.maxWidth,
                            child: CachedNetworkImage(
                              memCacheHeight: GetPlatform.isWeb ? 2000 : 600,
                              memCacheWidth: GetPlatform.isWeb ? 2000 : 600,
                              cacheManager: customCacheManager,
                              key: cachedkey,
                              imageUrl: imageUrl!,
                              color: color,
                              filterQuality: filterQuality,
                              fit: fit,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[400],
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
  }
}

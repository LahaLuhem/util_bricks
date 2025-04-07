import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fpdart/fpdart.dart';

import 'const_values.dart';

/// Wrapper for all Icons, [Svg]s, local Json files and other assets.
abstract class ConstMedia {
  // PNGs

  // SVGs

  // JSONs

  static SvgPicture buildIcon(
    String iconReference, {
    BoxFit fit = BoxFit.contain,
    Clip clipBehavior = Clip.hardEdge,
    Alignment alignment = Alignment.center,
  }) => SvgPicture.asset(iconReference, fit: fit, clipBehavior: clipBehavior, alignment: alignment);

  static SvgPicture buildIconWithSize(
    String iconReference, {
    double? width,
    double? height,
    Clip clipBehavior = Clip.hardEdge,
  }) => SvgPicture.asset(
    iconReference,
    width: width,
    height: height,
    fit: BoxFit.fitWidth,
    clipBehavior: clipBehavior,
  );

  /// Fetches an SVG image from a [Uri] or a [Uint8List] directly.
  ///
  /// Can be a URL(https scheme) or a local asset path.
  /// Does NOT check for XML validity though.
  /// So would fail silently if XML is unacceptable.
  static SvgPicture buildIconWithLocalUriOrByteData({
    required Either<Uri, Uint8List> uriOrUint8List,
    double? height,
    double? width,
    BoxFit fit = BoxFit.fitHeight,
  }) => uriOrUint8List.fold(
    (Uri iconReference) =>
        (iconReference.isScheme(ConstValues.httpsScheme))
            ? SvgPicture.network(iconReference.toString(), height: height, width: width, fit: fit)
            : SvgPicture.asset(iconReference.toString(), height: height, width: width, fit: fit),
    (Uint8List dataBytes) => SvgPicture.memory(dataBytes, height: height, width: width, fit: fit),
  );

  ///Builds an [ImageProvider] of respective type, given the [urlPath].
  static ImageProvider imageFromProviderPath({required String urlPath}) {
    final uri = Uri.parse(urlPath);
    if (uri.isScheme(ConstValues.httpsScheme)) return NetworkImage(urlPath);
    return AssetImage(uri.toString());
  }
}

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const xcolor = Color(0xFF730095);
const ocolor = Color(0xFFF38056);

CustomColors lightCustomColors = const CustomColors(
  sourceXcolor: Color(0xFF730095),
  xcolor: Color(0xFF912FB2),
  onXcolor: Color(0xFFFFFFFF),
  xcolorContainer: Color(0xFFFAD7FF),
  onXcolorContainer: Color(0xFF330044),
  sourceOcolor: Color(0xFFF38056),
  ocolor: Color(0xFF9F411C),
  onOcolor: Color(0xFFFFFFFF),
  ocolorContainer: Color(0xFFFFDBCF),
  onOcolorContainer: Color(0xFF380C00),
);

CustomColors darkCustomColors = const CustomColors(
  sourceXcolor: Color(0xFF730095),
  xcolor: Color(0xFFF0B0FF),
  onXcolor: Color(0xFF54006D),
  xcolorContainer: Color(0xFF760698),
  onXcolorContainer: Color(0xFFFAD7FF),
  sourceOcolor: Color(0xFFF38056),
  ocolor: Color(0xFFFFB59C),
  onOcolor: Color(0xFF5C1A00),
  ocolorContainer: Color(0xFF7F2A05),
  onOcolorContainer: Color(0xFFFFDBCF),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceXcolor,
    required this.xcolor,
    required this.onXcolor,
    required this.xcolorContainer,
    required this.onXcolorContainer,
    required this.sourceOcolor,
    required this.ocolor,
    required this.onOcolor,
    required this.ocolorContainer,
    required this.onOcolorContainer,
  });

  final Color? sourceXcolor;
  final Color? xcolor;
  final Color? onXcolor;
  final Color? xcolorContainer;
  final Color? onXcolorContainer;
  final Color? sourceOcolor;
  final Color? ocolor;
  final Color? onOcolor;
  final Color? ocolorContainer;
  final Color? onOcolorContainer;

  @override
  CustomColors copyWith({
    Color? sourceXcolor,
    Color? xcolor,
    Color? onXcolor,
    Color? xcolorContainer,
    Color? onXcolorContainer,
    Color? sourceOcolor,
    Color? ocolor,
    Color? onOcolor,
    Color? ocolorContainer,
    Color? onOcolorContainer,
  }) {
    return CustomColors(
      sourceXcolor: sourceXcolor ?? this.sourceXcolor,
      xcolor: xcolor ?? this.xcolor,
      onXcolor: onXcolor ?? this.onXcolor,
      xcolorContainer: xcolorContainer ?? this.xcolorContainer,
      onXcolorContainer: onXcolorContainer ?? this.onXcolorContainer,
      sourceOcolor: sourceOcolor ?? this.sourceOcolor,
      ocolor: ocolor ?? this.ocolor,
      onOcolor: onOcolor ?? this.onOcolor,
      ocolorContainer: ocolorContainer ?? this.ocolorContainer,
      onOcolorContainer: onOcolorContainer ?? this.onOcolorContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceXcolor: Color.lerp(sourceXcolor, other.sourceXcolor, t),
      xcolor: Color.lerp(xcolor, other.xcolor, t),
      onXcolor: Color.lerp(onXcolor, other.onXcolor, t),
      xcolorContainer: Color.lerp(xcolorContainer, other.xcolorContainer, t),
      onXcolorContainer:
          Color.lerp(onXcolorContainer, other.onXcolorContainer, t),
      sourceOcolor: Color.lerp(sourceOcolor, other.sourceOcolor, t),
      ocolor: Color.lerp(ocolor, other.ocolor, t),
      onOcolor: Color.lerp(onOcolor, other.onOcolor, t),
      ocolorContainer: Color.lerp(ocolorContainer, other.ocolorContainer, t),
      onOcolorContainer:
          Color.lerp(onOcolorContainer, other.onOcolorContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceXcolor]
  ///   * [CustomColors.xcolor]
  ///   * [CustomColors.onXcolor]
  ///   * [CustomColors.xcolorContainer]
  ///   * [CustomColors.onXcolorContainer]
  ///   * [CustomColors.sourceOcolor]
  ///   * [CustomColors.ocolor]
  ///   * [CustomColors.onOcolor]
  ///   * [CustomColors.ocolorContainer]
  ///   * [CustomColors.onOcolorContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceXcolor: sourceXcolor!.harmonizeWith(dynamic.primary),
      xcolor: xcolor!.harmonizeWith(dynamic.primary),
      onXcolor: onXcolor!.harmonizeWith(dynamic.primary),
      xcolorContainer: xcolorContainer!.harmonizeWith(dynamic.primary),
      onXcolorContainer: onXcolorContainer!.harmonizeWith(dynamic.primary),
      sourceOcolor: sourceOcolor!.harmonizeWith(dynamic.primary),
      ocolor: ocolor!.harmonizeWith(dynamic.primary),
      onOcolor: onOcolor!.harmonizeWith(dynamic.primary),
      ocolorContainer: ocolorContainer!.harmonizeWith(dynamic.primary),
      onOcolorContainer: onOcolorContainer!.harmonizeWith(dynamic.primary),
    );
  }
}

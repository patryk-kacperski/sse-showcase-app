import 'package:flutter/material.dart';

class StandardListTile extends StatelessWidget {
  const StandardListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.selected = false,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.contentPadding,
    this.dense,
    this.visualDensity,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.isThreeLine = false,
    this.shape,
    this.focusNode,
    this.autofocus = false,
    this.mouseCursor,
    this.onLongPress,
    this.leadingAndTrailingTextStyle,
    this.titleAlignment,
    this.cardMargin,
    this.cardElevation,
    this.cardShape,
    this.cardColor,
    this.cardShadowColor,
    this.cardSurfaceTintColor,
    this.cardBorderOnForeground = true,
    this.cardSemanticContainer = true,
    this.cardClipBehavior,
  });

  // ListTile properties
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;
  final bool selected;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool? dense;
  final VisualDensity? visualDensity;
  final Color? tileColor;
  final Color? selectedTileColor;
  final bool? enableFeedback;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;
  final bool isThreeLine;
  final ShapeBorder? shape;
  final FocusNode? focusNode;
  final bool autofocus;
  final MouseCursor? mouseCursor;
  final VoidCallback? onLongPress;
  final TextStyle? leadingAndTrailingTextStyle;
  final ListTileTitleAlignment? titleAlignment;

  // Card properties
  final EdgeInsetsGeometry? cardMargin;
  final double? cardElevation;
  final ShapeBorder? cardShape;
  final Color? cardColor;
  final Color? cardShadowColor;
  final Color? cardSurfaceTintColor;
  final bool cardBorderOnForeground;
  final bool cardSemanticContainer;
  final Clip? cardClipBehavior;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: cardMargin,
      elevation: cardElevation,
      shape: cardShape,
      color: cardColor,
      shadowColor: cardShadowColor,
      surfaceTintColor: cardSurfaceTintColor,
      borderOnForeground: cardBorderOnForeground,
      semanticContainer: cardSemanticContainer,
      clipBehavior: cardClipBehavior,
      child: ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        enabled: enabled,
        selected: selected,
        titleTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        contentPadding: contentPadding,
        dense: dense,
        visualDensity: visualDensity,
        tileColor: tileColor,
        selectedTileColor: selectedTileColor,
        enableFeedback: enableFeedback,
        horizontalTitleGap: horizontalTitleGap,
        minVerticalPadding: minVerticalPadding,
        minLeadingWidth: minLeadingWidth,
        isThreeLine: isThreeLine,
        shape: shape,
        focusNode: focusNode,
        autofocus: autofocus,
        mouseCursor: mouseCursor,
        onLongPress: onLongPress,
        leadingAndTrailingTextStyle: leadingAndTrailingTextStyle,
        titleAlignment: titleAlignment,
      ),
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:system_theme/system_theme.dart';

AccentColor getAccentColor(SystemAccentColor accent) {
  return AccentColor.swatch({
    'darkest': accent.darkest,
    'darker': accent.darker,
    'dark': accent.dark,
    'normal': accent.accent,
    'light': accent.light,
    'lighter': accent.lighter,
    'lightest': accent.lightest,
  });
}

Future<void> setEffect(WindowEffect effect) => Window.setEffect(effect: effect);

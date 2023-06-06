// ignore_for_file: prefer_const_constructors

import 'package:dart_style/dart_style.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_gen_core/generators/generator_helper.dart';
import 'package:flutter_gen_core/settings/config.dart';
import 'package:flutter_gen_core/settings/pubspec.dart';
import 'package:flutter_gen_core/utils/error.dart';
import 'package:flutter_gen_core/utils/string.dart';

class FontsGenConfig {
  FontsGenConfig._(
    this.fontsConfig,
    this._packageName,
  );

  factory FontsGenConfig.fromConfig(Config config) {
    return FontsGenConfig._(
      config.pubspec.flutterGen.fonts,
      config.pubspec.packageName,
    );
  }

  FlutterGenFonts fontsConfig;
  final String _packageName;
}

String generateFonts(
  DartFormatter formatter,
  List<FlutterFonts> fonts,
  FontsGenConfig config,
) {
  if (fonts.isEmpty) {
    throw InvalidSettingsException(
        'The value of "flutter/fonts:" is incorrect.');
  }

  final buffer = StringBuffer();
  final className = config.fontsConfig.outputs.className;
  buffer.writeln(header);
  buffer.writeln(ignore);
  buffer.writeln('class $className {');
  buffer.writeln('$className._();');
  buffer.writeln();

  String packagePath = '';
  if (config.fontsConfig.outputs.packageParameterEnabled == true) {
    packagePath = 'packages/${config._packageName}/';
  }

  fonts.map((element) => element.family).distinct().sorted().forEach((family) {
    buffer.writeln("""/// Font family: $family
    static const String ${family.camelCase()} = '$packagePath$family';""");
  });

  buffer.writeln('}');
  return formatter.format(buffer.toString());
}

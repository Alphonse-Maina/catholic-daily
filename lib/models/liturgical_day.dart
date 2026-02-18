import 'dart:ui';
import 'package:flutter/material.dart';

class LiturgicalDay {
  final String season;
  final String color;
  final String celebration;

  LiturgicalDay({
    required this.season,
    required this.color,
    required this.celebration,
  });
  Color get colorValue {
    switch (color.toLowerCase()) {
      case "green":
        return Colors.green;
      case "violet":
        return Colors.purple;
      case "white":
        return Colors.grey.shade200;
      case "red":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

}

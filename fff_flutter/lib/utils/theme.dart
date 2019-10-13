import "package:flutter/material.dart";
import "package:fff/utils/colors.dart" as fff_colors;

final ThemeData theme = ThemeData(
  // Define the default font family.
  fontFamily: "Muli",

  dialogTheme: const DialogTheme(
    contentTextStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: fff_colors.black,
    ),
  ),

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    display4: const TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.normal,
      color: fff_colors.black,
    ),
    display3: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.normal,
      color: fff_colors.black,
    ),
    display2: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: fff_colors.black,
    ),
    display1: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.normal,
      color: fff_colors.black,
    ),
    title: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.normal,
      color: fff_colors.black,
    ),
    headline: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: fff_colors.black,
    ),
    subhead: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: fff_colors.black,
    ),
    body2: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    body1: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    caption: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: fff_colors.black,
    ),
    button: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
  ),
);

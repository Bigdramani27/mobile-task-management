import 'package:flutter/material.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_widget.dart';


void successShowRoundedSnackBar(BuildContext context, String errorMessage) {
  // Define the SnackBar with rounded edges, an icon, and a text message
  final snackBar = SnackBar(
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: green), // Error icon
          const SizedBox(width: 10), // Space between icon and text
          Expanded(
            child: CustomText(
              text: errorMessage,
              color: policeColor,
              size: h3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: const Color(0xFFECFDF3),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.90,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: green, width: 1),
    ),
    duration: const Duration(seconds: 4),
  );

  // Display the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void errorShowRoundedSnackBar(BuildContext context, String errorMessage) {
  // Define the SnackBar with rounded edges, an icon, and a text message
  final snackBar = SnackBar(
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: primary), // Error icon
          const SizedBox(width: 10), // Space between icon and text
          Expanded(
            child: CustomText(
              text: errorMessage,
              color: primary,
              size: h3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: lightRed,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.90,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: lightRed, width: 1),
    ),
    duration: const Duration(seconds: 4),
  );

  // Display the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

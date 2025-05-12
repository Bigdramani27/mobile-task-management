import 'package:flutter/material.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/widgets/custom_widget.dart';

  // Error snackbar message
void errorShowRoundedSnackBar(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: error),
          const SizedBox(width: 10), 
          Expanded(child: CustomText(text: errorMessage)),
        ],
      ),
    ),
    backgroundColor: const Color(0xFFFEF3F2),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
    ),
    behavior: SnackBarBehavior.floating, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: error, width: 1), 
    ),
    duration: const Duration(seconds: 4), 
  );

  // Display the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//success snackbar messasge
void successShowRoundedSnackBar(BuildContext context, String errorMessage) {
  // Define the SnackBar with rounded edges, an icon, and a text message
  final snackBar = SnackBar(
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: primary), 
          const SizedBox(width: 10), 
          Expanded(child: CustomText(text: errorMessage)),
        ],
      ),
    ),
    backgroundColor: const Color(0xFFFEF3F2),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
    ),
    behavior: SnackBarBehavior.floating, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: primary, width: 1), 
    ),
    duration: const Duration(seconds: 4),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

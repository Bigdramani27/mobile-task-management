import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';


class CustomBackButton extends StatefulWidget {
  final void Function() onTap;
  const CustomBackButton({super.key, required this.onTap});

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: h1,
            color: background,
          ),
        ),
      ),
    );
  }
}

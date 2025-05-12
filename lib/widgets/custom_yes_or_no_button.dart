import 'package:flutter/material.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_widget.dart';


class CustomYesOrNoButton extends StatefulWidget {
  final bool isYes;
  final bool isNo;
  final void Function() noTap;
  final void Function() yesTap;
  const CustomYesOrNoButton({
    super.key,
    this.isYes = false,
    this.isNo = false,
    required this.noTap,
    required this.yesTap,
  });

  @override
  State<CustomYesOrNoButton> createState() => _CustomYesOrNoButtonState();
}

class _CustomYesOrNoButtonState extends State<CustomYesOrNoButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.yesTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: widget.isYes ? primary :transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primary),
              ),
              child:  Center(
                  child: CustomText(
                text: "Yes",
                fontWeight: FontWeight.w600,
                color: widget.isYes ? background :primary,
                size: h3,
              )),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: GestureDetector(
            onTap: widget.noTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: widget.isNo ? policeColor : transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: policeColor),
              ),
              child: Center(
                  child: CustomText(
                text: "No",
                fontWeight: FontWeight.w600,
                color: widget.isNo ? background : policeColor,
                size: h3,
              )),
            ),
          ),
        ),
      ],
    );
  }
}

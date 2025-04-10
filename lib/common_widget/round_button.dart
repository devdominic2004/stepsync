import 'package:flutter/material.dart';
import 'package:stepsync/common/color_extension.dart';

enum RoundButtonType { bgGradient, bgSGradient, textGradient }

class RoundButton extends StatelessWidget {
  final String title;
  final RoundButtonType type;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;

  const RoundButton({
    super.key,
    required this.title,
    this.type = RoundButtonType.bgGradient,
    required this.onPressed,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              type == RoundButtonType.bgSGradient
                  ? TColor.secondaryG
                  : TColor.primaryG,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow:
            type == RoundButtonType.bgGradient ||
                    type == RoundButtonType.bgSGradient
                ? const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]
                : null,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textColor: TColor.primaryColor1,
        minWidth: double.maxFinite,
        elevation:
            type == RoundButtonType.bgGradient ||
                    type == RoundButtonType.bgSGradient
                ? 0
                : 1,
        color:
            type == RoundButtonType.bgGradient ||
                    type == RoundButtonType.bgSGradient
                ? Colors.transparent
                : TColor.white,
        child:
            type == RoundButtonType.bgGradient ||
                    type == RoundButtonType.bgSGradient
                ? Text(
                  title,
                  style: TextStyle(
                    color: TColor.white,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                )
                : ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: TColor.primaryG,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                      Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                    );
                  },
                  child: Text(
                    title,
                    style: TextStyle(
                      color: TColor.primaryColor1,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
      ),
    );
  }
}

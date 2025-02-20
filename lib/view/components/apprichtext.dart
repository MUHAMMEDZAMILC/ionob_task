import 'package:flutter/material.dart';

class AppRichText extends StatelessWidget {
  final String normalText;
  final String richText;
  final String? fontFamily,richfontFamily;
  final Color normalTextColor, richTextColor;
  final FontWeight richFontWeight, normalFontWeight;
  final double? fontSize, richTextFontSize;
  final double? letterspace, richletterspace;

  const AppRichText(
      {super.key,
      required this.normalText,
      required this.richText,
      this.fontFamily,this.richfontFamily,
      this.normalTextColor = Colors.black,
      this.richTextColor = Colors.black,
      this.normalFontWeight = FontWeight.w300,
      this.richFontWeight = FontWeight.normal,
      this.fontSize,
      this.richTextFontSize,
      this.letterspace,
      this.richletterspace});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text.rich(
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        TextSpan(
          children: [
            TextSpan(
                text: normalText,
                style: TextStyle(
                    color: normalTextColor,
                    fontSize: fontSize ?? 12,
                    fontWeight: normalFontWeight,
                    fontFamily: 'Montserrat',
                    letterSpacing: letterspace)),
            TextSpan(
              text: richText,
              style: TextStyle(
                  color: richTextColor,
                  fontSize: richTextFontSize ?? (fontSize ?? 12),
                  fontWeight: richFontWeight,
                  fontFamily: 'Montserrat',
                  letterSpacing: richletterspace),
            ),
          ],
        ),
      ),
    );
  }
}
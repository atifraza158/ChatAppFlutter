// ignore_for_file: file_names
import 'package:chat_app/views/Utils/app_colors.dart';
import 'package:chat_app/views/Utils/app_text/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String buttonName;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final Color? buttonColor;
  final Color textColor;
  final Color iconColor;
  final FontWeight? fontWeight;
  final BorderRadius? buttonRadius;
  final IconData icon;
  final String iconImage;
  final bool isIcon;
  final bool isCenter;
  final double iconSize;
  final double paddingBtwn;
  final VoidCallback onTap;
  final double borderWidth;
  final Color borderColor;

  const AppButton({
    Key? key,
    required this.buttonName,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 52,
    this.buttonColor,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w500,
    this.buttonRadius,
    this.iconColor = Colors.white,
    this.icon = Icons.home,
    this.iconImage = "",
    this.isIcon = false,
    this.isCenter = false,
    this.iconSize = 30,
    this.paddingBtwn = 0,
    required this.onTap,
    this.textSize = 16,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    // required Color textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                offset: Offset(0, 10),
                blurRadius: 20,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                AppColors.linear_gradient3,
                AppColors.themeColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: buttonColor ?? AppColors.themeColor,
            borderRadius: buttonRadius ?? BorderRadius.circular(10),
            border: Border.all(
              width: borderWidth,
              color: borderColor,
            ),
          ),
          child: Padding(
            padding: isCenter
                ? const EdgeInsets.symmetric(horizontal: 20)
                : EdgeInsets.only(left: paddingBtwn == 0 ? 0 : 15),
            child: Row(
              mainAxisAlignment: paddingBtwn == 0
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isIcon
                    ? iconImage == ""
                        ? Icon(
                            icon,
                            color: iconColor,
                            size: iconSize,
                          )
                        : Image.asset(
                            iconImage,
                            height: iconSize,
                          )
                    : Container(),
                isCenter
                    ? const Spacer()
                    : SizedBox(
                        width: paddingBtwn == 0
                            ? isIcon
                                ? 10
                                : 0
                            : paddingBtwn,
                      ),
                Center(
                  child: AppText(
                      title: buttonName,
                      color: textColor,
                      fontWeight: fontWeight ?? FontWeight.w700,
                      size: textSize),
                ),
                isCenter ? const Spacer() : Container(),
                isCenter
                    ? isIcon
                        ? iconImage == ""
                            ? Icon(
                                icon,
                                color: iconColor,
                                size: iconSize,
                              )
                            : Image.asset(iconImage,
                                height: iconSize, color: Colors.transparent)
                        : Container()
                    : Container(),
              ],
            ),
          )),
    );
  }
}

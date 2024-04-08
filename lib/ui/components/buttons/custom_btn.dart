import 'package:cubex/core/core.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final bool online;
  final bool isOutline;
  final String text;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Color? offlineColor;
  final Color? onlineColor;
  final Color? outlineColor;
  final Color? textColor;
  final double? borderWidth;
  final BorderStyle? borderStyle;

  const CustomButton({
    super.key,
    required this.onTap,
    this.online = true,
    this.isOutline = false,
    required this.text,
    this.isLoading = false,
    this.borderRadius,
    this.width,
    this.height,
    this.offlineColor,
    this.onlineColor,
    this.outlineColor,
    this.textColor,
    this.borderWidth,
    this.borderStyle,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !online || isLoading,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width ?? Sizer.screenWidth,
          height: Sizer.height(height ?? 56),
          decoration: (online && !isLoading)
              ? BoxDecoration(
                  borderRadius: borderRadius,
                  color: isOutline
                      ? AppColors.transparent
                      : onlineColor ?? AppColors.brandBlue,
                  border: isOutline
                      ? Border.all(
                          color: outlineColor ?? AppColors.brandBlue,
                          width: borderWidth ?? 1.0,
                          style: borderStyle ?? BorderStyle.solid,
                        )
                      : null,
                )
              : BoxDecoration(
                  borderRadius: borderRadius,
                  color: offlineColor ?? AppColors.baseGray,
                ),
          child: Center(
            child: isLoading
                ? const FittedBox(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    text,
                    style: AppTypography.text16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: online
                          ? textColor ?? AppColors.white
                          : AppColors.gray500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

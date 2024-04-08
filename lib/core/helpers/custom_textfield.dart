import 'package:cubex/core/core.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatefulWidget {
  final String? errorText, labelText, hintText, optionalText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool? isPassword, isConfirmPassword, showSuffixIcon;
  final Widget? suffixIcon, prefix, prefixIcon;
  final KeyboardType keyboardType;
  final double? width, height, labelSize;
  final double borderRadius;
  final bool? isReadOnly;
  final FocusNode? focusNode;
  final bool showLabelHeader, hideBorder;
  final Color? labelColor;
  final Color? fillColor;
  final Color? textfieldColor;
  final bool isOptional;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.optionalText,
    this.labelColor,
    this.textfieldColor,
    this.fillColor = Colors.transparent,
    this.labelSize,
    this.controller,
    this.isPassword = false,
    this.isConfirmPassword = false,
    this.showSuffixIcon = false,
    this.hideBorder = false,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.errorText,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.isReadOnly = false,
    this.keyboardType = KeyboardType.regular,
    this.showLabelHeader = false,
    this.focusNode,
    this.isOptional = false,
    this.onChanged,
    this.onSubmitted,
    this.contentPadding,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    List<KeyboardType> numsKeyboardType = [
      KeyboardType.decimal,
      KeyboardType.number,
      KeyboardType.accountNo,
      KeyboardType.bvn
    ];
    // KeyboardOverlay.showOverlay(context);
    if (widget.focusNode != null &&
        numsKeyboardType.contains(widget.keyboardType)) {
      KeyboardOverlay.addRemoveFocusNode(context, widget.focusNode!);
    }
  }

  @override
  void dispose() {
    // Clean up the focus node
    super.dispose();
    // if (widget.focusNode != null && mounted) {
    //   widget.focusNode?.dispose();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.showLabelHeader
            ? Column(
                children: [
                  Row(
                    children: [
                      Text(widget.labelText!,
                          style: TextStyle(
                            color: AppColors.gray600,
                            fontSize: widget.labelSize ?? 12.sp,
                            fontWeight: FontWeight.w400,
                          )),
                      Text(
                          widget.optionalText != null
                              ? widget.optionalText!
                              : widget.isOptional
                                  ? " (Optional)"
                                  : "",
                          style: TextStyle(
                            color: AppColors.gray600,
                            fontWeight: FontWeight.w500,
                            fontSize: widget.labelSize ?? 15.sp,
                          )),
                    ],
                  ),
                  YBox(4.h),
                ],
              )
            : const SizedBox(),
        Container(
          // color: AppColors.alertRed,
          width: widget.width ?? double.infinity,
          height: widget.height ?? 49.h,
          alignment: Alignment.center,
          // color: Colors.red,
          child: Center(
            child: TextField(
              // cursorHeight: 14.sp,
              cursorColor: AppColors.black,
              focusNode: widget.focusNode,
              style: TextStyle(
                color: widget.textfieldColor ?? AppColors.gray700,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              controller: widget.controller,
              obscureText: widget.isPassword! && !showPassword,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              onTap: widget.onTap,
              readOnly: widget.isReadOnly!,
              decoration: InputDecoration(
                errorText: widget.errorText,
                errorStyle: TextStyle(
                    color: AppColors.red, fontSize: 0.01.sp, height: 0.2),
                contentPadding: widget.contentPadding ??
                    EdgeInsets.only(
                      //left: 16.w,
                      top: 20.h,
                      bottom: 0.h,
                      left: 16.w,
                      right: 10.w,
                    ),
                // labelText: widget.labelText,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray500,
                ),
                suffixIcon: widget.suffixIcon ?? suffixIcon(),
                prefix: widget.prefix,
                prefixIcon: widget.prefixIcon,
                // suffixIconColor: AppColors.brandOrange,

                fillColor: widget.fillColor,
                filled: true,
                // isCollapsed: true,
                // isDense: true,
                // labelStyle: TextStyle(color: bluishGrey, fontSize: 14.sp),
                enabledBorder: OutlineInputBorder(
                  borderSide: widget.hideBorder
                      ? BorderSide.none
                      : const BorderSide(
                          width: 1,
                          color: AppColors.gray500,
                        ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: widget.hideBorder
                      ? BorderSide.none
                      : const BorderSide(
                          width: 1,
                          color: AppColors.primaryLightBlue,
                        ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                border: OutlineInputBorder(
                  borderSide: widget.hideBorder
                      ? BorderSide.none
                      : const BorderSide(
                          width: 1,
                          color: AppColors.primaryLightBlue,
                        ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                errorBorder: OutlineInputBorder(
                  //borderSide: BorderSide.none,
                  borderSide: widget.hideBorder
                      ? BorderSide.none
                      : BorderSide(
                          width: 1, color: AppColors.red.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: widget.hideBorder
                      ? BorderSide.none
                      : BorderSide(
                          width: 1, color: AppColors.red.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: widget.hideBorder
                      ? BorderSide.none
                      : const BorderSide(
                          width: 1,
                          color: AppColors.primaryLightBlue,
                        ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
            ),
          ),
        ),
        widget.errorText == null
            ? const SizedBox.shrink()
            : Text(
                widget.errorText ?? "",
                style: TextStyle(
                    color: AppColors.red.withOpacity(0.8), fontSize: 12.sp),
              )
      ],
    );
  }

  Widget? suffixIcon() {
    if (widget.isPassword! || widget.isConfirmPassword!) {
      return GestureDetector(
          onTap: () => setState(() {
                showPassword = !showPassword;
              }),
          child: PasswordSuffixWidget(
            showPassword: showPassword,
          ));
    }
    if (widget.showSuffixIcon! && widget.suffixIcon == null) {
      return const Icon(
        Iconsax.arrow_down,
        size: 18,
        color: AppColors.black,
      );
    }

    if (widget.showSuffixIcon! && widget.suffixIcon != null) {
      //return const Icon(FontAwesomeIcons.circleCheck, size: 16, color: green);
      return widget.suffixIcon;
    }
    return null;
  }
}

class PasswordSuffixWidget extends StatelessWidget {
  final bool showPassword;
  const PasswordSuffixWidget({super.key, required this.showPassword});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 26.h,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 11.h,
        bottom: 11.h,
      ),
      decoration: BoxDecoration(
        // color: AppColors.black,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: showPassword
          ? const Icon(
              Iconsax.eye_slash5,
              size: 24,
              color: AppColors.black,
            )
          : const Icon(
              Iconsax.eye4,
              size: 24,
              color: AppColors.black,
            ),
    );
  }
}

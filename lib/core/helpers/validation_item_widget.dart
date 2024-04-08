import 'package:cubex/core/core.dart';

class ValidationItemWidget extends StatelessWidget {
  final String label;
  final bool isValid;
  const ValidationItemWidget({
    required this.label,
    this.isValid = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.h,
          //padding: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: isValid ? AppColors.lightBlue : null,
            border: Border.all(
              color: isValid ? AppColors.lightBlue : AppColors.baseGray,
            ),
          ),
          child: const Icon(Icons.check, size: 16, color: AppColors.white),
        ),
        XBox(8.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: isValid ? AppColors.brandBlack : AppColors.gray500,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}

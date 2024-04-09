import 'package:cubex/core/core.dart';

class NumberKey extends StatelessWidget {
  const NumberKey({
    super.key,
    required this.number,
    required this.onNumberSelected,
  });

  final int number;
  final Function(int) onNumberSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        onTap: () => onNumberSelected(number),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Sizer.width(16),
            vertical: Sizer.height(14),
          ),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.numPad,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: AppTypography.text24.copyWith(
                color: AppColors.darkBlue100,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

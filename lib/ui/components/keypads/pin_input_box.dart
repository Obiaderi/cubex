import 'package:cubex/core/core.dart';

class PINInputBox extends StatefulWidget {
  final String codeInput;
  final bool isActive; // New parameter to indicate if the input box is active

  const PINInputBox({
    super.key,
    required this.codeInput,
    this.isActive = false, // Default to false if not provided
  });

  @override
  State<PINInputBox> createState() => _PINInputBoxState();
}

class _PINInputBoxState extends State<PINInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47.w,
      height: 47.w,
      padding: EdgeInsets.only(top: Sizer.height(8)),
      decoration: BoxDecoration(
        color: widget.codeInput.isEmpty ? AppColors.white : AppColors.gray300,
        borderRadius: BorderRadius.circular(
          Sizer.radius(4),
        ),
        border: Border.all(
          width: Sizer.width(0.73),
          color:
              widget.codeInput.isEmpty ? AppColors.gray500 : AppColors.gray300,
        ),
        boxShadow:
            widget.isActive // Add a subtle shadow when the input box is active
                ? [
                    BoxShadow(
                      color: AppColors.gray500.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
      ),
      child: widget.codeInput.isNotEmpty
          ? const Center(
              child: Text(
                '*',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

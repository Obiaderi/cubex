import 'package:cubex/core/core.dart';
import 'package:cubex/ui/components/components.dart';
import 'package:lottie/lottie.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
    this.onConfirm,
    this.onCancel,
  });

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            AppAssets.sad,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
            animate: true, // Start playing as soon as the widget is loaded
            repeat: true, // Loop the animation
          ),
          Text(
            "You want to leave?",
            textAlign: TextAlign.center,
            style: AppTypography.text16.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const YBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  height: 36,
                  onTap: onCancel ??
                      () {
                        Navigator.pop(context);
                      },
                  online: true,
                  text: "Stay",
                ),
              ),
              const XBox(20),
              Expanded(
                child: CustomButton(
                  height: 36,
                  onlineColor: AppColors.red,
                  onTap: onConfirm,
                  online: true,
                  text: "Log out",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

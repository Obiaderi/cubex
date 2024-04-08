import 'package:another_flushbar/flushbar.dart';
import 'package:cubex/core/core.dart';

class FlushBarToast {
  static Flushbar<dynamic> fLSnackBar(
      {required String message,
      Color? textColor,
      Color? backgroundColor,
      int? duration,
      FlushbarPosition? position}) {
    return Flushbar<dynamic>(
      messageText: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.white)),
      backgroundColor: backgroundColor ?? AppColors.creditGreen,
      borderRadius: BorderRadius.circular(5.r),
      flushbarPosition: position ?? FlushbarPosition.TOP,
      margin: EdgeInsets.only(
        left: 20.h,
        bottom: 20.h,
        right: 12.w,
      ),
      duration: Duration(seconds: duration ?? 3),
    );
  }
}

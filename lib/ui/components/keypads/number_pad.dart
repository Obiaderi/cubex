import 'package:cubex/core/core.dart';
import 'package:iconsax/iconsax.dart';

import 'number_key.dart';

class NumberPad extends StatelessWidget {
  final Function(int) onNumberSelected;
  // final Function() onBioAuthenticate;

  const NumberPad({
    super.key,
    required this.onNumberSelected,
    // required this.onBioAuthenticate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      alignment: Alignment.bottomCenter,
      constraints: const BoxConstraints(
          // maxHeight: Sizes.dimen_400,
          ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NumberKey(number: 1, onNumberSelected: onNumberSelected),
                    NumberKey(number: 2, onNumberSelected: onNumberSelected),
                    NumberKey(number: 3, onNumberSelected: onNumberSelected),
                  ]),
            ),
            const YBox(16),
            SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NumberKey(number: 4, onNumberSelected: onNumberSelected),
                    NumberKey(number: 5, onNumberSelected: onNumberSelected),
                    NumberKey(number: 6, onNumberSelected: onNumberSelected),
                  ]),
            ),
            const YBox(16),
            SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NumberKey(number: 7, onNumberSelected: onNumberSelected),
                    NumberKey(number: 8, onNumberSelected: onNumberSelected),
                    NumberKey(number: 9, onNumberSelected: onNumberSelected),
                  ]),
            ),
            const YBox(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Container()),
                NumberKey(number: 0, onNumberSelected: onNumberSelected),
                backSpace(),
              ],
            )
          ]),
    );
  }

  backSpace() {
    return Expanded(
      child: InkWell(
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        onTap: () => onNumberSelected(-1),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Sizer.width(16),
            vertical: Sizer.height(14),
          ),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.numPad2,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Iconsax.arrow_left,
              color: AppColors.darkBlue100,
              size: Sizer.width(35),
            ),
          ),
        ),
      ),
    );
  }
}

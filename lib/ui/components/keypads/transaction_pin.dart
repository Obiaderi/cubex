import 'package:cubex/core/core.dart';
import 'package:cubex/ui/components/keypads/keypads.dart';
import 'package:provider/provider.dart';

class TransactionPIN extends StatefulWidget {
  // final Function(String pin) onSubmit;

  const TransactionPIN({
    super.key,
    // required this.onSubmit,
  });

  @override
  State<TransactionPIN> createState() => _TransactionPINState();
}

class _TransactionPINState extends State<TransactionPIN> {
  late Size size;
  String pinCode = '';
  int currentInputIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return PINInputBox(
                    codeInput: index < pinCode.length ? pinCode[index] : '',
                    isActive: index == currentInputIndex,
                  );
                }).expand((widget) => [widget, const XBox(8)]).toList(),
              )
            ],
          ),
          const YBox(10),
          Text(
            "Pin: 1234",
            style: AppTypography.text14.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const YBox(100),
          NumberPad(
            onNumberSelected: (value) {
              if (value != -1) {
                if (pinCode.length < 4) {
                  setState(() {
                    pinCode = pinCode + value.toString();
                    currentInputIndex++;
                  });
                }
              } else {
                if (pinCode.isNotEmpty) {
                  setState(() {
                    pinCode = pinCode.substring(0, pinCode.length - 1);
                    currentInputIndex--;
                  });
                }
              }
              context.read<AuthVM>().setPassCode(pinCode);
              // if (pinCode.length == 4) {

              //   // widget.onSubmit(pinCode);
              //   // pinCode = "";
              //   // currentInputIndex = 0;
              // }
            },
          )
        ],
      ),
    );
  }
}

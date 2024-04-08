import 'dart:ui';

import 'package:cubex/core/core.dart';

class BusyOverlay extends StatefulWidget {
  final Widget child;
  final bool show;

  const BusyOverlay({super.key, required this.child, this.show = false});

  @override
  State<BusyOverlay> createState() => _BusyOverlayState();
}

class _BusyOverlayState extends State<BusyOverlay> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: Sizer.screenWidth,
        height: Sizer.screenWidth,
        child: Stack(
          children: <Widget>[
            widget.child,
            Visibility(
              visible: widget.show,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 10, sigmaY: 10), // Adjust the blur intensity
                child: Container(
                  color: Colors.black12.withOpacity(
                      0.2), // Adjust the background color and opacity
                ),
              ),
            ),
            Center(
              child: IgnorePointer(
                ignoring: !widget.show,
                child: Visibility(
                  visible: widget.show,
                  child:
                      const CircularProgressIndicator(), // Removed valueColor for adaptive color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

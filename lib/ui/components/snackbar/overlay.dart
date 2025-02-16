import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterbloc/ui/components/snackbar/snackbar.dart';

void showAnimatedSnackBar({
  required BuildContext context,
  required String message,
  Duration duration = const Duration(seconds: 3),
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
}) {
  // Create an OverlayEntry to display the SnackBar
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top, // Position at the top of the screen
      left: 0,
      right: 0,
      child: AnimatedSnackBar(
        message: message,
        duration: duration,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    ),
  );

  // Insert the OverlayEntry into the Overlay
  Overlay.of(context)?.insert(overlayEntry);

  // Remove the OverlayEntry after the duration
  Future.delayed(duration, () {
    overlayEntry.remove();
  });
}
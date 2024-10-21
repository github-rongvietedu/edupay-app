import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String text,Color color) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => _CustomSnackbar(text: text,textColor: color),
  );

  overlay.insert(overlayEntry);

  // Remove the Snackbar after 3 seconds with animation
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}

class _CustomSnackbar extends StatefulWidget {
  final String text;
  Color textColor;

  _CustomSnackbar({required this.text,required this.textColor});

  @override
  __CustomSnackbarState createState() => __CustomSnackbarState();
}

class __CustomSnackbarState extends State<_CustomSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1.0), // Start below the screen
      end: Offset(0, 0),     // End at its normal position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12.0,
      left: 10.0,
      right: 10.0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(1),
              borderRadius: BorderRadius.circular(8.5),
            ),
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

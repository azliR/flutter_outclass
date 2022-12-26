import 'package:flutter/material.dart';

class ProgressOverlay extends StatelessWidget {
  const ProgressOverlay({
    super.key,
    required this.visible,
    required this.child,
  });
  
  final bool visible;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null) child! else const SizedBox(),
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !visible,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              color: visible
                  ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6)
                  : Colors.transparent,
              child: Visibility(
                visible: visible,
                child: const SafeArea(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

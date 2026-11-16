import 'package:flutter/widgets.dart';

class ScrollableChild extends StatelessWidget {
  const new({super.key, required this.child, this.scrollDirection = .vertical});
  final Axis scrollDirection;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: scrollDirection,
      child: child,
    );
  }
}

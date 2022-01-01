import 'package:flutter/material.dart';

class FlexibleTitleVisibilityController extends StatefulWidget {
  final Widget child;

  const FlexibleTitleVisibilityController({Key? key, required this.child})
      : super(key: key);

  @override
  _FlexibleTitleVisibilityControllerState createState() {
    return _FlexibleTitleVisibilityControllerState();
  }
}

class _FlexibleTitleVisibilityControllerState
    extends State<FlexibleTitleVisibilityController> {
  ScrollPosition? scrollPosition;
  bool isVisible = false;

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    removeListener();
    addListener();
  }

  void addListener() {
    scrollPosition = Scrollable.of(context)?.position;
    scrollPosition?.addListener(positionListener);
    //  positionListener();
  }

  void removeListener() {
    scrollPosition?.removeListener(positionListener);
  }

  void positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();

    bool visible = true;

    if (settings != null)
      visible = settings.minExtent > settings.currentExtent - 50;

    if (isVisible != visible) setState(() => isVisible = visible);
  }

  @override
  Widget build(BuildContext context) =>
      Visibility(visible: isVisible, child: widget.child);
}

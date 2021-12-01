import 'package:flutter/material.dart';

class EdgeResizeableContainer extends StatefulWidget {
  final Widget? child;
  final Function(double)? onLeftResize;
  final Function(double)? onRightResize;
  final Function(double)? onTopResize;
  final Function(double)? onBottomResize;

  final double? initialWidth;
  final double? initialHeight;

  final Decoration? decoration;

  const EdgeResizeableContainer({
    Key? key,
    @required this.child,
    this.onBottomResize,
    this.onLeftResize,
    this.onRightResize,
    this.onTopResize,
    this.initialWidth,
    this.initialHeight,
    this.decoration,
  }) : super(key: key);

  @override
  State<EdgeResizeableContainer> createState() =>
      _EdgeResizeableContainerState();
}

class _EdgeResizeableContainerState extends State<EdgeResizeableContainer> {
  final GlobalKey containerKey = GlobalKey();
  final double edgeWidth = 8;

  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double decorationHorizontalInset =
        widget.decoration?.padding?.horizontal ?? 0;
    double decorationVerticalInset = widget.decoration?.padding?.vertical ?? 0;
    print("$decorationHorizontalInset, $decorationVerticalInset");
    print("${widget.initialWidth}-${widget.initialHeight}");
    return Container(
      key: containerKey,
      width: widget.initialWidth == null
          ? widget.initialWidth
          : widget.initialWidth! - decorationHorizontalInset,
      height: widget.initialHeight == null
          ? widget.initialHeight
          : widget.initialHeight! - decorationVerticalInset,
      decoration: widget.decoration,
      child: Stack(
        children: [
          widget.child ?? Container(),
          widget.onTopResize == null
              ? Container()
              : Positioned(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      child: Container(
                        height: edgeWidth,
                        width: double.infinity,
                        color: Colors.transparent,
                      ),
                      onVerticalDragUpdate: (DragUpdateDetails dragDetails) {
                        if (widget.onTopResize != null) {
                          double? currentHeight = widget.initialHeight;
                          currentHeight ??=
                              containerKey.currentContext?.size?.height;
                          if (currentHeight == null) return;
                          widget.onTopResize!(
                              currentHeight + dragDetails.delta.dy);
                        }
                      },
                    ),
                  ),
                  top: 0,
                  left: 0,
                  right: 0,
                ),
          widget.onBottomResize == null
              ? Container()
              : Positioned(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      child: Container(
                        height: edgeWidth,
                        width: double.infinity,
                        color: Colors.transparent,
                      ),
                      onVerticalDragUpdate: (DragUpdateDetails dragDetails) {
                        if (widget.onBottomResize != null) {
                          double? currentHeight = widget.initialHeight;
                          currentHeight ??=
                              containerKey.currentContext?.size?.height;
                          if (currentHeight == null) return;
                          widget.onBottomResize!(
                              currentHeight - dragDetails.delta.dy);
                        }
                      },
                    ),
                  ),
                  bottom: 0,
                  left: 0,
                  right: 0,
                ),
          widget.onLeftResize == null
              ? Container()
              : Positioned(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      child: Container(
                        height: double.infinity,
                        width: edgeWidth,
                        color: Colors.transparent,
                      ),
                      onHorizontalDragUpdate: (DragUpdateDetails dragDetails) {
                        if (widget.onLeftResize != null) {
                          double? currentWidth = widget.initialWidth;
                          currentWidth ??=
                              containerKey.currentContext?.size?.width;
                          if (currentWidth == null) return;
                          widget.onLeftResize!(
                              currentWidth - dragDetails.delta.dx);
                        }
                      },
                    ),
                  ),
                  left: 0,
                  top: 0,
                  bottom: 0,
                ),
          widget.onRightResize == null
              ? Container()
              : Positioned(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      child: Container(
                        height: double.infinity,
                        width: edgeWidth,
                        color: Colors.transparent,
                      ),
                      onHorizontalDragUpdate: (DragUpdateDetails dragDetails) {
                        if (widget.onRightResize != null) {
                          double? currentWidth = widget.initialWidth;
                          currentWidth ??=
                              containerKey.currentContext?.size?.width;
                          if (currentWidth == null) return;
                          widget.onRightResize!(
                              currentWidth + dragDetails.delta.dx);
                        }
                      },
                    ),
                  ),
                  right: 0,
                  top: 0,
                  bottom: 0,
                ),
        ],
      ),
    );
  }
}

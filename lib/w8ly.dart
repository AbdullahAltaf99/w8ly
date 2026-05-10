library w8ly;

import 'package:flutter/material.dart';

class W8lyWeightPicker extends StatefulWidget {
  final int minWeight;
  final int maxWeight;
  final int initialWeight;
  final ValueChanged<int> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final String unit;
  final Widget? indicator;
  final Color? indicatorColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? labelTextStyle;

  const W8lyWeightPicker({
    super.key,
    required this.initialWeight,
    this.indicatorColor = Colors.red,
    required this.onChanged,
    this.minWeight = 1,
    this.maxWeight = 200,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.indicator,
    required this.unit,
    this.selectedTextStyle,
    this.labelTextStyle,
  });

  @override
  State<W8lyWeightPicker> createState() => _W8lyWeightPickerState();
}

class _W8lyWeightPickerState extends State<W8lyWeightPicker> {
  late int selectedWeight;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    selectedWeight = widget.initialWeight;

    // Calculate initial offset
    double initialOffset = (selectedWeight - widget.minWeight) * 10.0;

    _scrollController = ScrollController(initialScrollOffset: initialOffset);
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    int newWeight =
        widget.minWeight + (_scrollController.offset / 10.0).round();

    // Clamp within range
    newWeight = newWeight.clamp(widget.minWeight, widget.maxWeight);

    if (newWeight != selectedWeight) {
      setState(() => selectedWeight = newWeight);
      widget.onChanged(newWeight);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final tickMaxHeight = (screenHeight * 0.045).clamp(18.0, 36.0);
    final tickMinHeight = tickMaxHeight * 0.5;
    final indicatorHeight = (screenHeight * 0.03).clamp(12.0, 24.0);
    final offsetFromTicks = screenHeight * 0.005;
    final gapBetweenTicksAndIndicator = (screenHeight * 0.015).clamp(8.0, 16.0);
    final tickWidth = 10.0;
    return SizedBox(
      height:
          tickMaxHeight +
          gapBetweenTicksAndIndicator +
          indicatorHeight +
          offsetFromTicks +
          60,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            controller: _scrollController,
            itemCount: widget.maxWeight - widget.minWeight + 1,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 2 - 10.0 / 2,
            ),
            itemBuilder: (context, index) {
              final weight = widget.minWeight + index;
              final isMajor = weight % 5 == 0;
              final isLabel = weight % 10 == 0;

              return SizedBox(
                width: tickWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isLabel)
                      Text(
                        '$weight',
                        style:
                            widget.labelTextStyle ??
                            TextStyle(
                              fontSize: screenHeight * 0.015,
                              color: widget.inactiveColor,
                              fontWeight: FontWeight.w400,
                            ),
                        softWrap: false,
                        overflow: TextOverflow.visible,
                      ),

                    Container(
                      width: 2,
                      height: isMajor ? tickMaxHeight : tickMinHeight,
                      color: isMajor
                          ? widget.activeColor
                          : widget.inactiveColor,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: -(indicatorHeight + gapBetweenTicksAndIndicator),
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$selectedWeight ${widget.unit}',
                  style:
                      widget.selectedTextStyle ??
                      TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: widget.activeColor,
                      ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 2,
                  height: tickMaxHeight + offsetFromTicks + 25,
                  color: widget.indicatorColor,
                ),
                const SizedBox(height: 4),
                widget.indicator ??
                    ClipPath(
                      clipper: _TriangleClipper(),
                      child: Container(
                        width: 24,
                        height: indicatorHeight,
                        color: widget.indicatorColor,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_) => false;
}

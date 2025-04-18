import 'package:flutter/material.dart';

import 'app_color.dart';

class MySlider extends StatefulWidget {
  final int min;
  final int max;
  final double value;
  final ValueChanged<int>? onChanged;

  const MySlider(
      {super.key, required this.min,
      required this.max,
      required this.value,
      this.onChanged});

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: CustomSliderThumbShape(
            imageProvider: const AssetImage('assets/images/gr.png'),
            buildContext:
                context // Replace 'assets/slider_thumb.png' with your image path
            ),
      ),
      child: Slider(
        min: widget.min.toDouble(),
        max: widget.max.toDouble(),
        activeColor: AppColors.appColor,
        inactiveColor: AppColors.appBlack.withOpacity(0.2),
        value: widget.value,
        onChanged: (value) {
          // setState(() {
          //   _value = value;
          //   if (widget.onChanged != null) {
          //     widget.onChanged!(_value.round());
          //   }
          // });
        },
      ),
    );
  }
}

class CustomSliderThumbShape extends SliderComponentShape {
  final ImageProvider imageProvider;
  final BuildContext buildContext;

  const CustomSliderThumbShape(
      {required this.imageProvider, required this.buildContext});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(30, 30); // Adjust the size of the thumb as needed
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 10, paint);

    final imageSize = getPreferredSize(false, isDiscrete);
    final imageRect = Rect.fromCenter(
        center: center, width: imageSize.width, height: imageSize.height);

    _paintImage(
      canvas,
      imageRect,
      imageProvider,
      buildContext,
    );
  }

  // Helper method to draw the image onto the canvas
  void _paintImage(Canvas canvas, Rect rect, ImageProvider imageProvider,
      BuildContext context) {
    final imageStream =
        imageProvider.resolve(createLocalImageConfiguration(context));

    imageStream.addListener(ImageStreamListener((imageInfo, _) {
      final image = imageInfo.image;
      paintImage(
        canvas: canvas,
        rect: rect,
        image: image,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      );
    }));
  }
}

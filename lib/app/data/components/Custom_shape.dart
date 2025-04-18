import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:codesapp/app/data/components/parallax/parallax_for_horizontal_scroll.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import 'app_color.dart';
import 'get_size.dart';

class SuperellipseCard extends StatelessWidget {
  SuperellipseCard(
      {super.key,
      this.color = AppColors.white20,
      this.elevation = 4.0,
      this.child,
      this.radius = 80});

  final Color color;
  final double elevation;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: SuperellipseShape(
        borderRadius: BorderRadius.circular(radius),
      ),
      color: color,
      shadowColor: Colors.black38,
      elevation: elevation,
      child: child,
    ); // Material
  }
}

class CategoryTile extends StatelessWidget {
  CategoryTile({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _buildParallaxBackground(context);
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Flow(
        delegate: ParallaxFlowDelegateForHorizontal(
          scrollable: Scrollable.of(context),
          listItemContext: context,
          backgroundImageKey: _backgroundImageKey,
        ),
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            key: _backgroundImageKey,
            fit: BoxFit.cover,
            height: H.h100(context),
            width: W.w100(context),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}

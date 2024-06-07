import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';

class NetworkImageView extends StatelessWidget {
  Size size;
  String image;
  double? borderRadius;

  NetworkImageView(
      {super.key, required this.image, required this.size, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? Insets.xs),
      child: CachedNetworkImage(
        imageUrl: image,
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}

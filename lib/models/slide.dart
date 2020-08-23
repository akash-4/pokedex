import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Slide {
  final String imageUrl;
  final String title;
  IconData ico;

  Slide({this.imageUrl, @required this.title, this.ico});
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/image1.png',
    title: 'Stay Connected with all the Pokemons.',
  ),
  Slide(
      title: 'Search different Pokemons.',
      ico: MdiIcons.cardSearch),
  Slide(title: 'Add Pokemon ratings and reviews.', ico: MdiIcons.commentOutline),
  Slide(
      title: 'Allow other users to view your favourite Pokemons.',
      ico: Icons.favorite_border),
];

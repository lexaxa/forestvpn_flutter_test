import 'package:flutter/material.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';

class FeaturedNewsWidget extends StatelessWidget {
  final Article article;

  const FeaturedNewsWidget(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(article.imageUrl).image,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      constraints: const BoxConstraints(maxHeight: 300.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 40.0, right: 20.0),
              child: Text(
                article.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 28.0,
                  letterSpacing: 16 * 0.02,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

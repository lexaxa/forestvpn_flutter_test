import 'package:flutter/material.dart';
import 'package:forestvpn_test/constants/ui_constants.dart';
import 'package:forestvpn_test/screens/news_details.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';
import 'package:get/get.dart';

class LatestNewsWidget extends StatelessWidget {
  final Article article;

  const LatestNewsWidget(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 103.0,
      ),
      child: Card(
        color: article.readed
            ? UIConstants.lightGrayColor
            : Colors.white,
        child: ListTile(
          leading: SizedBox(
            width: 90.0,
            height: 60.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  article.imageUrl,
                  fit: BoxFit.cover,
                )),
          ),
          title: Text(
            article.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              height: 1.9,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            article.publicationDate.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
              height: 1.4,
              color: UIConstants.publicationDateColor,
            ),
          ),
          onTap: () => Get.to(() => NewsDetailsScreen(article)),
        ),
      ),
    );
  }
}

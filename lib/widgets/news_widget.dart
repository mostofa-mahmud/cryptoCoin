import 'package:cryptocurrency_flutter/model/news_response.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class NewsWidget extends StatelessWidget {
  NewsData news;

  NewsWidget({required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration: boxDecorationDefault(borderRadius: radius(20), image: DecorationImage(image: Image.network(news.thumb_2x.validate()).image, fit: BoxFit.cover)),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            width: context.width(),
            decoration: boxDecorationDefault(
                borderRadius: radius(20),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.9), Colors.black.withOpacity(0.5)],
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${news.news_site.validate()}', style: boldTextStyle(color: Colors.white)),
                8.height,
                Text(
                  news.title.validate(),
                  style: boldTextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                8.height,
                Text('${DateFormat("dd MMM yyyy").format(DateTime.fromMillisecondsSinceEpoch(news.updated_at.validate() * 1000))}', style: secondaryTextStyle()),
                16.height,
                Text('${news.author.validate()}', style: primaryTextStyle(color: secondaryColor)),
              ],
            ),
          ),
        ],
      ).onTap(() {
        AppCommon.launchUrl(news.url.validate(), forceWebView: true);
      }, borderRadius: radius(20)),
    );
  }
}

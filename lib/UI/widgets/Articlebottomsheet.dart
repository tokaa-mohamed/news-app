
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Model/article.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class ArticleBottomSheet extends StatelessWidget {
  final Article article;

  const ArticleBottomSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {

      void _launchURL(String url) async {
    if (!url.startsWith('http')) url = 'https://$url';
    final uri = Uri.parse(url);

    try {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } catch (e) {
      print('Error launching URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the URL')),
      );
    }
  }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage!,
                  fit: BoxFit.cover,
                ),
              ),


            const SizedBox(height: 16),

                if (article.url != null)
                                            InkWell(
                                              onTap: () =>
                                                  _launchURL(article.url!),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
   ),
                                                child: Row(
                                                  children: [
                                                     Icon(Icons.link,
                                                        color: Theme.of(context).textTheme.bodyMedium?.color,
                                                        size: 18),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        article.url!,
                                                        style:  TextStyle(
                                                          color:  Theme.of(context).textTheme.bodyMedium?.color,
                                                          fontSize: 13,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                    const SizedBox(height: 16),



            Text(
              article.title ?? 'No Title',
              style:  TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium?.color
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Text(
                    "By: ${article.author ?? 'Unknown'}",
                    style:  TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                ),
                Text(
                  article.publishedAt != null
                      ? timeago.format(DateTime.parse(article.publishedAt!))
                      : '',
                  style:  TextStyle(fontSize: 13,color:  Theme.of(context).textTheme.bodyMedium?.color),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              article.description ?? "No Content Available",
              style:  TextStyle(fontSize: 16,color:  Theme.of(context).textTheme.bodyMedium?.color),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

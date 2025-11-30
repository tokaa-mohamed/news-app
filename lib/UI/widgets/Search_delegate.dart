import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Api/Api_manager.dart';
import 'package:newsapp/generated/l10n.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;



class NewsSearchDelegate extends SearchDelegate {
  final String? hint;
    final Color textColor;

  NewsSearchDelegate({required this.hint,required this.textColor});

 TextStyle? get searchFieldStyle => TextStyle(
        color: textColor,
        fontSize: 18,
      );

  @override
  String? get searchFieldLabel => hint;
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        color: Theme.of(context).iconTheme.color,
        
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
       color: Theme.of(context).iconTheme.color,
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

  
    return FutureBuilder(
      future:Api_manager.searchNews(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("No results found"));
        }

        final articles = snapshot.data!.articles ?? [];

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];

       return Card(
                                color: Theme.of(context).cardColor,
                                surfaceTintColor: Colors.white,
                                margin: const EdgeInsets.all(8),
                                shape:
                                 RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
      color: Theme.of(context).primaryColor, 
      width: 1,                    
    ),

                                    ),
                                elevation: 5,
                                child:
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (article.urlToImage != null)
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(12)),
                                          child: CachedNetworkImage(
                                     imageUrl: article.urlToImage ?? '',
                                     placeholder: (context, url) => const CircularProgressIndicator(),
                                     errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                                     fit: BoxFit.cover,
                                   ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article.title ?? 'No Title',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            
                                            
                                            Row(children: [
    Expanded(
      child: Text(
        'By: ${article.author ?? 'Unknown'}',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14),
      ),
    ),
                         SizedBox(width: MediaQuery.of(context).size.width * 0.3),
Text(
  article.publishedAt != null
      ? timeago.format(DateTime.parse(article.publishedAt!))
      : '',
)
                                            ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                                                   ),
                                 ),
                              );
                                 },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold();
  }
}

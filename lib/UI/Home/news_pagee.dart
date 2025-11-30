import 'package:flutter/material.dart';
import 'package:newsapp/Api/Api_manager.dart';
import 'package:newsapp/Model/Sourceresponse.dart';
import 'package:newsapp/Model/Articleresponses.dart';
import 'package:newsapp/Model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/UI/widgets/Articlebottomsheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:newsapp/UI/widgets/drawer.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:newsapp/utils/app_styles.dart';
import 'package:newsapp/generated/l10n.dart';
import 'package:newsapp/UI/widgets/Search_delegate.dart';

class News_page extends StatefulWidget {
  final String selectedCategory;

  const News_page({super.key, required this.selectedCategory});

  @override
  State<News_page> createState() => _News_pageState();
}

class _News_pageState extends State<News_page> {
  int selectedIndex = 0;
  late Future<SourceResponse?> _sourcesFuture;
  final Map<String, ArticleResponse?> _cachedArticles = {};
  final Map<String, List<Article>> allArticlesBySource = {};
  final Map<String, List<Article>> visibleArticlesBySource = {};

  @override
  void initState() {
    super.initState();
    _sourcesFuture = Api_manager()
        .fetchSources(widget.selectedCategory)
        .then((sourcesResponse) async {
      if (sourcesResponse != null && sourcesResponse.sources!.isNotEmpty) {
        await _loadArticlesForSource(sourcesResponse.sources!.first.id!);
      }
      return sourcesResponse;
    });
  }

  Future<void> _loadArticlesForSource(String sourceId) async {
    if (_cachedArticles.containsKey(sourceId)) {
      final cached = _cachedArticles[sourceId];
      if (cached != null &&
          cached.articles != null &&
          cached.articles!.isNotEmpty) {
        allArticlesBySource[sourceId] = cached.articles!;
        visibleArticlesBySource[sourceId] =
            cached.articles!.take(2).toList();
        return;
      }
    }

    final response = await Api_manager().fetchNewsBySource(sourceId);

    if (response != null && response.articles!.isNotEmpty) {
      _cachedArticles[sourceId] = response;
      allArticlesBySource[sourceId] = response.articles!;
      visibleArticlesBySource[sourceId] = response.articles!.take(2).toList();
    }
  }

  void _loadMore(String sourceId) {
    final all = allArticlesBySource[sourceId] ?? [];
    final visible = visibleArticlesBySource[sourceId] ?? [];

    if (visible.length >= all.length) return;

    final remaining = all.length - visible.length;
    final nextCount = remaining >= 2 ? 2 : remaining;

    visible.addAll(all.sublist(visible.length, visible.length + nextCount));

    visibleArticlesBySource[sourceId] = visible;
    setState(() {});
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor
,
        automaticallyImplyLeading: true,
        title: Text(
          widget.selectedCategory.isEmpty
              ? S.of(context).home
              : widget.selectedCategory,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NewsSearchDelegate(
                  hint: S.of(context).searchNews,
                  textColor: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle
                          ?.color ??
                      Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      drawer: const Drawerwidget(),
      body: FutureBuilder<SourceResponse?>(
        future: _sourcesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final sources = snapshot.data!.sources ?? [];

          if (sources.isEmpty) {
            return const Center(child: Text('No sources available'));
          }

          return DefaultTabController(
            length: sources.length,
            initialIndex: selectedIndex,

            child: Column(
              children: [
                TabBar(
                 tabAlignment: TabAlignment.start,
                 
                   labelStyle: Theme.of(context).appBarTheme.titleTextStyle,
  unselectedLabelStyle: Theme.of(context).appBarTheme.titleTextStyle,
  labelColor: Theme.of(context).primaryColor,
  unselectedLabelColor: Colors.grey[700],
  

                  isScrollable: true,
                  onTap: (index) async {
                    selectedIndex = index;
                    final sourceId = sources[index].id!;
                    if (!allArticlesBySource.containsKey(sourceId)) {
                      await _loadArticlesForSource(sourceId);
                    }
                    setState(() {});
                  },
                  tabs: sources.map((s) => Tab(text: s.name ?? '')).toList(),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final sourceId = sources[selectedIndex].id!;
                      final articles =
                          visibleArticlesBySource[sourceId] ?? [];

                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: articles.length,
                              itemBuilder: (context, index) {
                                final article = articles[index];
                                return InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      builder: (_) =>
                                          ArticleBottomSheet(article: article),
                                    );
                                  },
                                  child: Card(
                                    color: Appcolors.whitecolor,
                                    surfaceTintColor: Colors.white,
                                    margin: const EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Appcolors.border,
                                        width: 1,
                                      ),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (article.urlToImage != null)
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(12)),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    article.urlToImage ?? '',
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                            Icons.broken_image),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          const SizedBox(height: 8),

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
                                                child:  Row(
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

                                          const SizedBox(height: 8),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  article.title ?? 'No Title',
                                                  style:  TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                          color: Theme.of(context).textTheme.bodyMedium?.color
                                                          ),
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'By: ${article.author ?? 'Unknown'}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:  TextStyle(
                                                            fontSize: 14,
                                                            color: Theme.of(context).textTheme.bodyMedium?.color,
                                                            ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.3),
                                                    Text(
                                                      article.publishedAt != null
                                                          ? timeago.format(
                                                              DateTime.parse(
                                                                  article
                                                                      .publishedAt!))
                                                          : '',
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          if ((allArticlesBySource[sourceId]?.length ?? 0) >
                              articles.length)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () => _loadMore(sourceId),
                                child: const Text("Load 2 more"),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

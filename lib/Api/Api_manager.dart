import 'package:newsapp/Api/Api_constant.dart';
import 'package:newsapp/Api/Api_endpoints.dart';
import 'package:newsapp/Model/Articleresponses.dart';
import 'package:newsapp/Model/Sourceresponse.dart';
import 'package:newsapp/Model/sources.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Api_manager{

Future<SourceResponse?> fetchSources(String category) async {
  Uri url = Uri.https(
    Api_constant.base_url, 
    Api_endpoints.source_endpoint,
    {
      'language': 'en',
      'apiKey': Api_constant.Api_key,
      'category': category,

    },
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {

      return SourceResponse.fromJson(jsonDecode(response.body));
    } else {
      print('error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}


static Future<SourceResponse?> searchSources(String query) async {
  Uri url = Uri.https(
    Api_constant.base_url,
    Api_endpoints.source_endpoint,
    {
      'language': 'en',
      'apiKey': Api_constant.Api_key,
      'q': query,
    },
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return SourceResponse.fromJson(jsonDecode(response.body));
    } else {
      print('error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}



//fetch Articles using Uri
Future<ArticleResponse?> fetchNewsBySource(String sourceId) async {
Uri url = Uri.https(
  Api_constant.base_url, 
  Api_endpoints.News_endpoints,
  {
    'sources': sourceId,
    'apiKey': Api_constant.Api_key,
  },
);

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {

      return ArticleResponse.fromJson(jsonDecode(response.body));
    } else {
      print('error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

static Future<ArticleResponse?> fetchNewsBySourceArabic(String sourceId) async {
  Uri url = Uri.https(
    Api_constant.base_url,
    Api_endpoints.News_endpoints,
    {
      'sources': sourceId,
      'apiKey': Api_constant.Api_key,
      'language': 'ar',
    },
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(jsonDecode(response.body));
    } else {
      print('error (AR): ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error Arabic API: $e');
    return null;
  }
}

//search about article or news
static Future<ArticleResponse?> searchNews(String query) async {
  Uri url = Uri.https(
    Api_constant.base_url,
    Api_endpoints.News_endpoints,
    {
      'q': query,
      'language': 'en',
      'apiKey': Api_constant.Api_key,
    },
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(jsonDecode(response.body));
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

}
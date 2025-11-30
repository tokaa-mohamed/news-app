
import 'package:newsapp/Model/sources.dart';

class SourceResponse {
  List<Source>? sources;

  SourceResponse({this.sources});
  

  factory SourceResponse.fromJson(Map<String, dynamic> json) {
    var list = json['sources'] as List;
    List<Source> sourceList = list.map((i) => Source.fromJson(i)).toList();
    return SourceResponse(sources: sourceList);
  }
}

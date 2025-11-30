import 'package:flutter/material.dart';
import 'package:newsapp/Model/Categorymodel.dart';
import 'package:newsapp/UI/Home/news_pagee.dart';
import 'package:newsapp/UI/widgets/Categorycard.dart';
import 'package:newsapp/generated/l10n.dart';

class CategoriesSearchDelegate extends SearchDelegate<CategoryModel?> {
  final List<CategoryModel> categories;
  final String? hint;
    final Color textColor;

  CategoriesSearchDelegate( { required this.categories,required this.hint,required this.textColor});



  @override

  String? get searchFieldLabel => hint;
  @override

  TextStyle? get searchFieldStyle => TextStyle(
        color: textColor,
        fontSize: 18,
      );

  // ✨ زر المسح
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  // ✨ زر الرجوع
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null), 
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold();
  }

@override
Widget buildResults(BuildContext context) {
  final filteredItems = categories
      .where((c) => c.title!.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return ListView.builder(
    itemCount: filteredItems.length,
    itemBuilder: (context, index) {
      final item = filteredItems[index];
      final isEven = index % 2 == 0;

      return CategoryCard(
        item: item,
        isEven: isEven,
        onTap: (title) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => News_page(selectedCategory: title),
            ),
          );
        },
      );
    },
  );
}
}

import 'package:flutter/material.dart';
import 'package:newsapp/Model/Categorymodel.dart';
import 'package:newsapp/UI/Home/news_pagee.dart';
import 'package:newsapp/UI/widgets/Categorycard.dart';
import 'package:newsapp/UI/widgets/Categorylist.dart';
import 'package:newsapp/UI/widgets/Search_delegate_sources.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:newsapp/utils/app_styles.dart';

import 'package:newsapp/generated/l10n.dart';



class Home extends StatefulWidget {
  final Function(String) onCategoryTap; 

  const Home({super.key, required this.onCategoryTap});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<CategoryModel> category=getCategories();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor:   Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor:  Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          S.of(context).home,
          style:Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
IconButton(
  icon:  Icon(Icons.search),
  onPressed: () async {
    final categories = getCategories(); 
    await showSearch<CategoryModel?>(
      context: context,
      delegate: CategoriesSearchDelegate(categories: categories,hint: S.of(context).searchCategories,
    textColor: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.white,

      ),
    );
  },
)
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).goodMorning, style: Theme.of(context).appBarTheme.titleTextStyle),
                const SizedBox(height: 8),
                Text(S.of(context).newsForYou,
                    style: Theme.of(context).appBarTheme.titleTextStyle),
                const SizedBox(height: 20),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: category.length,
              itemBuilder: (context, index) {
                final item = category[index];
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
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildViewAllButton(String categoryName) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.zero, 
    ),
onPressed: () {
  widget.onCategoryTap(categoryName); 
  print(categoryName);
},
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
     const   Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:  Text(
            'View All',
            style:Appstyles.white16Bold,
          ),
        ),

        Container(
          decoration: const BoxDecoration(
            color:Appcolors.blackcolor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: const Icon(
            Icons.keyboard_arrow_down,
            color: Appcolors.whitecolor,
            size: 20,
          ),
        ),
      ],
    ),
  );
}
}

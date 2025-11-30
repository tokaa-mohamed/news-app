
import 'package:flutter/material.dart';
import 'package:newsapp/Provider/Category_provider.dart';
import 'package:newsapp/UI/Home/homee.dart';
import 'package:newsapp/UI/Home/news_pagee.dart';
import 'package:provider/provider.dart';

class initPage extends StatefulWidget {
  const initPage({super.key});

  @override
  State<initPage> createState() => _initPageState();
}

class _initPageState extends State<initPage> {

  @override
  Widget build(BuildContext context) {
          final category=Provider.of<Categoryprovider>(context);

    return Scaffold(
      body:category.fetchcategory
      ?News_page(selectedCategory: category.Selectedcategory! ):
      Home(onCategoryTap: category.onCategoryTap)

    );
  }
}
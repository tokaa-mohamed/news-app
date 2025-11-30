import 'package:flutter/material.dart';

class Categoryprovider extends ChangeNotifier{
    String? Selectedcategory;
  bool fetchcategory=false;
  void onCategoryTap(String Category){
    Selectedcategory=Category;
    fetchcategory=true;
      print(' Category changed to: $Selectedcategory');

notifyListeners();

  }

  void clearcategory(){
    Selectedcategory=null;
    fetchcategory=false;
notifyListeners();
  }


}
import 'package:newsapp/Model/Categorymodel.dart';


List<CategoryModel> getCategories() {
  return [
    CategoryModel(
      title: "general",
      imageUrl:
          "assets/images/general_light.png",
    ),
    CategoryModel(
      title: "technology",
      imageUrl:
          "assets/images/technology_light.png",
    ),
    CategoryModel(
      title: "science",
      imageUrl:
          "assets/images/science_light.png",
    ),
     CategoryModel(
      title: "business",
      imageUrl:
          "assets/images/business_light.png",
    ),
   CategoryModel(
      title: "sports",
      imageUrl:
          "assets/images/sports_light.png",
    ),
   CategoryModel(
      title: "health",
      imageUrl:
          "assets/images/health_light.png",
    ),
    CategoryModel(
      title: "entertainment",
      imageUrl:
          "assets/images/entertainment_light.png",
    ),
  
  ];
}

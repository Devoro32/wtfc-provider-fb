import 'package:wtfc_provider_app/export.dart';
import 'dart:math';

Future<void> saveRecipeCategoryToFirebase() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("recipeCategoryCollection");
  for (final RecipeCategory recipeCategory in listOfRecipeCategories) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");
    await ref.doc(id).set(recipeCategory.toMap());
  }
}

class RecipeCategory {
  final String name;

  RecipeCategory({required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }
}

final List<RecipeCategory> listOfRecipeCategories = [
  RecipeCategory(name: 'All'),
  RecipeCategory(name: 'Breakfast'),
  RecipeCategory(name: 'Lunch'),
  RecipeCategory(name: 'Dinner'),
];

import 'package:flutter/material.dart';
import 'package:mobil_development_assignment/meal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobil_development_assignment/meal_detail.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.meal});
  final Meal meal;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<MealDetail> mealDetailList = [];

  @override
  void initState() {
    super.initState();
    fetch().then((value) {
      setState(() {
        mealDetailList = value;
      });
    });
  }

  Future<List<MealDetail>> fetch() async {
    var url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.meal.idMeal ?? ""}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var meals = jsonResponse['meals'];
      List<MealDetail> mealDetailList = [];
      for (var meal in meals) {
        mealDetailList.add(MealDetail.fromJson(meal));
      }
      return mealDetailList;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return List.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Meal meal = ModalRoute.of(context)?.settings.arguments as Meal;
    MealDetail mealDetail =
        mealDetailList.isNotEmpty ? mealDetailList[0] : MealDetail();
    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetail.strMeal ?? ""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              mealDetail.strMealThumb == null
                  ? const CircularProgressIndicator()
                  : Image.network(mealDetail.strMealThumb ?? ""),
              const Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Column(
                children: [
                  IngredientView(
                    measure: mealDetail.strMeasure1,
                    ingredient: mealDetail.strIngredient1,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure2,
                    ingredient: mealDetail.strIngredient2,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure3,
                    ingredient: mealDetail.strIngredient3,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure4,
                    ingredient: mealDetail.strIngredient4,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure5,
                    ingredient: mealDetail.strIngredient5,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure6,
                    ingredient: mealDetail.strIngredient6,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure7,
                    ingredient: mealDetail.strIngredient7,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure8,
                    ingredient: mealDetail.strIngredient8,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure9,
                    ingredient: mealDetail.strIngredient9,
                  ),
                  IngredientView(
                    measure: mealDetail.strMeasure10,
                    ingredient: mealDetail.strIngredient10,
                  ),
                ],
              ),
              const Divider(),
              Text(
                mealDetail.strCategory ?? "",
                style: const TextStyle(fontSize: 18),
              ),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                mealDetail.strArea ?? "",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                mealDetail.strInstructions ?? "",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientView extends StatelessWidget {
  const IngredientView(
      {super.key, required this.ingredient, required this.measure});
  final String? ingredient;
  final String? measure;

  @override
  Widget build(BuildContext context) {
    return ingredient != null
        ? Row(
            children: [
              Text(
                measure ?? "",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
              Text(
                ingredient ?? "",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

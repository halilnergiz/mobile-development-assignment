import 'package:flutter/material.dart';
import 'package:mobil_development_assignment/detail_page.dart';
import 'package:mobil_development_assignment/meal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Meal> meals = [];

  @override
  void initState() {
    super.initState();
    fetch().then((value) {
      setState(() {
        meals = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Meals'),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(meals[index].strMeal ?? "asd"),
            subtitle: Text(meals[index].strCategory ?? "asd"),
            leading: Image.network(meals[index].strMealThumb ?? ""),
            onTap: () {
              // Navigator.pushNamed(context, '/detail', arguments: meals[index]);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailPage(meal: meals[index]);
              }));
            },
          );
        },
      ),
    );
  }

  Future<List<Meal>> fetch() async {
    var url =
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=b');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var meals = jsonResponse['meals'];
      List<Meal> mealList = [];
      for (var meal in meals) {
        mealList.add(Meal.fromJson(meal));
      }
      return mealList;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return List.empty();
    }
  }
}

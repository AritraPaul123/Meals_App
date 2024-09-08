import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/views/screens/filters_screen.dart';
import 'package:meals_app/views/screens/home.dart';
import 'package:meals_app/views/screens/meals_screen.dart';
import 'package:meals_app/views/widgets/main_drawer.dart';
import '../../models/meals.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {

  void _onSelectScreen(String identifier) async {
    Navigator.pop(context);
    if(identifier=='filters'){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const FiltersScreen()));
    }
  }

  var _selectedIndex=0;
  void _selectIndex(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    String pageTitle;
   final availableMeals=ref.watch(filteredMealsProvider);
      if(_selectedIndex==1) {
        final List<Meal> favoriteMeals=ref.watch(favoriteMealsProvider);
          pageTitle="Favorites";
          currentPage=MealsScreen(meals: favoriteMeals);
      }else{
        pageTitle="Select A Category";
        currentPage=Home(availableMeals: availableMeals);
      }
    return Scaffold(
      appBar: AppBar(
        title : Text(pageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _onSelectScreen,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _selectIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
      body: currentPage,
    );
  }
}

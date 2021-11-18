import 'package:flutter/material.dart';
import 'package:news/modules/cubit/cubit.dart';
import 'package:news/modules/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News App',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              NewsCubit.get(context).changeAppMode();
            },
            icon: Icon(
              Icons.brightness_4_outlined,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: NewsCubit.get(context).bottomItems,
        currentIndex: NewsCubit.get(context).currentIndex,
        onTap: (index) {
          NewsCubit.get(context).changeBottomNavBar(index);
        },
      ),
      body: NewsCubit.get(context).screens[NewsCubit.get(context).currentIndex],
    );
  }
}

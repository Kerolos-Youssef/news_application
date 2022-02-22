import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/cubit/states.dart';
import 'package:news/modules/home/home_news_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/network/local/cash_helper.dart';
import 'package:news/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(AppNewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeNewsScreen(),
    ScienceScreen(),
    BusinessScreen(),
    SportsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Science News',
    'Business News',
    'Sports news',
  ];
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_filled,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_rounded,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.monetization_on_rounded,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_soccer_rounded,
      ),
      label: 'Sports',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppNewsBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(AppNewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '186583e14e3d486fae1f4f306c9b55d3',
    }).then((value) {
      business = value.data["articles"];
      print(business[0]['title']);
      emit(AppNewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(AppNewsGetBusinessErrorState(error.toString()));
      print('error in getBusiness() method: ${error.toString()}');
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(AppNewsGetSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '186583e14e3d486fae1f4f306c9b55d3',
    }).then((value) {
      sports = value.data["articles"];
      print(sports[0]['title']);
      emit(AppNewsGetSportsSuccessState());
    }).catchError((error) {
      emit(AppNewsGetSportsErrorState(error.toString()));
      print('error in getSports() method: ${error.toString()}');
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(AppNewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '186583e14e3d486fae1f4f306c9b55d3',
    }).then((value) {
      science = value.data["articles"];
      print(science[0]['title']);
      emit(AppNewsGetScienceSuccessState());
    }).catchError((error) {
      emit(AppNewsGetScienceErrorState(error.toString()));
      print('error in getScience() method: ${error.toString()}');
    });
  }

  List<dynamic> generalNews = [];

  void getGeneralNews() {
    emit(AppNewsGetGeneralLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'general',
      'apiKey': '186583e14e3d486fae1f4f306c9b55d3',
    }).then((value) {
      generalNews = value.data["articles"];
      print(generalNews[0]['title']);
      emit(AppNewsGetGeneralSuccessState());
    }).catchError((error) {
      emit(AppNewsGetGeneralErrorState(error.toString()));
      print('error in getGeneralNews() method: ${error.toString()}');
    });
  }

  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppNewsChangeAppModeState());
    } else {
      isDark = !isDark;
      CashHelper.sendAppMod(key: 'isDark', value: isDark).then((value) {
        emit(AppNewsChangeAppModeState());
      });
    }
  }

  List<dynamic> search = [];

  void getSearch({required String keyword}) {
    emit(AppNewsGetSearchLoadingState());
    if (keyword == '') {
      search = [];
    } else {
      DioHelper.getData(url: 'v2/everything', query: {
        'q': '$keyword',
        'apiKey': '186583e14e3d486fae1f4f306c9b55d3',
      }).then((value) {
        search = value.data["articles"];
        print(generalNews[0]['title']);
        emit(AppNewsGetSearchSuccessState());
      }).catchError((error) {
        emit(AppNewsGetSearchErrorState(error.toString()));
        print('error in getSearch() method: ${error.toString()}');
      });
    }
  }

  var searchController = TextEditingController();
}

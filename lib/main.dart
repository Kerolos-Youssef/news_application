import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app_layout/news_layout.dart';
import 'package:news/network/local/cash_helper.dart';
import 'package:news/network/remote/dio_helper.dart';
import 'package:news/shared/bloc_observer.dart';

import 'modules/cubit/cubit.dart';
import 'modules/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.int();
  bool? isDark = CashHelper.getAppMod(key: 'isDark');
  runApp(
    MyApp(
      isDark: isDark,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..changeAppMode(fromShared: isDark)
        ..getScience()
        ..getBusiness()
        ..getGeneralNews()
        ..getSports(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            //theme for light mode
            theme: ThemeData(
              primarySwatch: Colors.purple,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(
                  color: Colors.black,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                //backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.purple,
                elevation: 20,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                headline6: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            // darkTheme for Dark mode
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF000000),
              primarySwatch: Colors.purple,
              appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF000000),
                elevation: 0.0,
                //backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xFF000000),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              iconTheme: IconThemeData(
                color: Color(0xFF000000),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.purple,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: Color(0xFF000000),
              ),
              textTheme: TextTheme(
                headline6: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: Directionality(
              child: NewsLayout(),
              textDirection: TextDirection.rtl,
            ),
          );
        },
      ),
    );
  }
}

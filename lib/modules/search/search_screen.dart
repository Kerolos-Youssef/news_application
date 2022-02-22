import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/modules/cubit/cubit.dart';
import 'package:news/modules/cubit/states.dart';
import 'package:news/shared/components.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).search;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 25.h,
                  horizontal: 25.w,
                ),
                child: defaultTextFormField(
                  isDark: NewsCubit.get(context).isDark,
                  controller: NewsCubit.get(context).searchController,
                  keyboardType: TextInputType.text,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icon(Icons.search),
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(keyword: value!);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(list: list),
              ),
            ],
          ),
        );
      },
    );
  }
}

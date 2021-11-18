import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/cubit/cubit.dart';
import 'package:news/modules/cubit/states.dart';
import 'package:news/shared/components.dart';

class HomeNewsScreen extends StatefulWidget {
  const HomeNewsScreen({Key? key}) : super(key: key);

  @override
  _HomeNewsScreenState createState() => _HomeNewsScreenState();
}

class _HomeNewsScreenState extends State<HomeNewsScreen> {
  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).generalNews;
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        return list.length > 0
            ? articleBuilder(list: list)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
      listener: (context, state) {},
    );
  }
}

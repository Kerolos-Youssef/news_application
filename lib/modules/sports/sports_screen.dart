import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/cubit/cubit.dart';
import 'package:news/modules/cubit/states.dart';
import 'package:news/shared/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsCubit.get(context).getSports();
    var list = NewsCubit.get(context).sports;
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

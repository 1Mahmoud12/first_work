
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/to_do_app/cubit/cubit todo/states.dart';
import '../../../layout/to_do_app/cubit/cubit todo/toda app.dart';
import '../../../shared/components/components.dart';


class archive extends StatelessWidget {
  const archive({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(builder: (context, state) {
      var tasks =AppCubit.get(context).archiveTask;
      return ListView.separated(
          itemBuilder:(context,index){return buildTaskItem(tasks[index],context );} ,
          separatorBuilder:(context,index) {return Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          );},
          itemCount: tasks.length);
    }, listener: (context,state){});

  }

}
